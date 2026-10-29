-- Procedimientos, funcion y trigger originales; se instala sobre las 18 tablas.
-- Ejecutar despues de cargar los datos de prueba.
BEGIN;
CREATE PROCEDURE public.confirmar_recepcion_compra(IN p_id_compra integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_estado VARCHAR(20);
    v_id_movimiento INTEGER;
    v_total NUMERIC(12,2);
    r RECORD;
BEGIN

    -- 1. Verificar y bloquear la compra
    SELECT estado
    INTO v_estado
    FROM compras
    WHERE id_compra = p_id_compra
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'La compra % no existe', p_id_compra;
    END IF;

    IF v_estado <> 'PENDIENTE' THEN
        RAISE EXCEPTION
            'La compra % no esta pendiente', p_id_compra;
    END IF;

    -- 2. Verificar que tenga productos
    IF NOT EXISTS (
        SELECT 1
        FROM detalle_compra
        WHERE id_compra = p_id_compra
    ) THEN
        RAISE EXCEPTION
            'La compra no tiene productos registrados';
    END IF;

    -- 3. Calcular el total
    SELECT SUM(cantidad * costo_unitario)
    INTO v_total
    FROM detalle_compra
    WHERE id_compra = p_id_compra;

    -- 4. Crear movimiento de inventario
    INSERT INTO movimientos_inventario (
        tipo_movimiento,
        referencia,
        observaciones
    )
    VALUES (
        'ENTRADA',
        'COMPRA-' || p_id_compra,
        'Recepcion de mercaderia'
    )
    RETURNING id_movimiento
    INTO v_id_movimiento;

    -- 5. Procesar los productos comprados
    FOR r IN
        SELECT
            id_producto,
            id_caja,
            cantidad
        FROM detalle_compra
        WHERE id_compra = p_id_compra
        ORDER BY id_producto, id_caja
    LOOP

        -- Registrar detalle del movimiento
        INSERT INTO detalle_movimiento_inventario (
            id_movimiento,
            id_producto,
            id_caja_origen,
            id_caja_destino,
            cantidad
        )
        VALUES (
            v_id_movimiento,
            r.id_producto,
            NULL,
            r.id_caja,
            r.cantidad
        );

        -- Incrementar inventario por caja
        INSERT INTO inventario_ubicacion (
            id_producto,
            id_caja,
            cantidad
        )
        VALUES (
            r.id_producto,
            r.id_caja,
            r.cantidad
        )
        ON CONFLICT (id_producto, id_caja)
        DO UPDATE SET
            cantidad =
                inventario_ubicacion.cantidad
                + EXCLUDED.cantidad,
            fecha_ultima_actualizacion =
                CURRENT_TIMESTAMP;

    END LOOP;

    -- 6. Confirmar compra
    UPDATE compras
    SET
        estado = 'RECIBIDA',
        total = v_total
    WHERE id_compra = p_id_compra;

    RAISE NOTICE
        'Compra % recibida correctamente. Total: Q %',
        p_id_compra,
        v_total;

END;
$$;

CREATE FUNCTION public.fn_sincronizar_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		UPDATE productos
		SET stock_actual = (
			SELECT COALESCE(SUM(cantidad), 0)
			FROM inventario_ubicacion
			WHERE id_producto = OLD.id_producto
		)
		WHERE id_producto = OLD.id_producto;

		RETURN OLD;
	END IF;

	UPDATE productos
	SET stock_actual = (
		SELECT COALESCE(SUM(cantidad), 0)
		FROM inventario_ubicacion
		WHERE id_producto = NEW.id_producto
	)
	WHERE id_producto = NEW.id_producto;

	IF TG_OP = 'UPDATE'
		AND OLD.id_producto <> NEW.id_producto THEN

			UPDATE productos
			SET stock_actual = (
				SELECT COALESCE(SUM(cantidad), 0)
				FROM inventario_ubicacion
				WHERE id_producto = OLD.id_producto
			)
			WHERE id_producto = OLD.id_producto;
		END IF;

RETURN NEW;

END;
$$;

CREATE PROCEDURE public.registrar_pago_factura(IN p_id_factura integer, IN p_id_forma_pago integer, IN p_monto numeric, IN p_referencia character varying DEFAULT NULL::character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_estado VARCHAR(20);
    v_total NUMERIC(12,2);
    v_pagado NUMERIC(12,2);
    v_saldo NUMERIC(12,2);
BEGIN

    -- 1. Bloquear y consultar factura
    SELECT estado, total
    INTO v_estado, v_total
    FROM facturas_encabezado
    WHERE id_factura = p_id_factura
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La factura % no existe', p_id_factura;
    END IF;

    -- 2. Validar estado
    IF v_estado NOT IN ('EMITIDA', 'PAGADO') THEN
        RAISE EXCEPTION
            'La factura % no permite pagos en estado %',
            p_id_factura, v_estado;
    END IF;

    -- 3. Validar monto
    IF p_monto IS NULL OR p_monto <= 0 THEN
        RAISE EXCEPTION 'El monto debe ser mayor que cero';
    END IF;

    -- 4. Validar forma de pago
    IF NOT EXISTS (
        SELECT 1
        FROM formas_pago
        WHERE id_forma_pago = p_id_forma_pago
    ) THEN
        RAISE EXCEPTION 'La forma de pago no existe';
    END IF;

    -- 5. Calcular pagos anteriores
    SELECT COALESCE(SUM(monto), 0)
    INTO v_pagado
    FROM pagos_factura
    WHERE id_factura = p_id_factura;

    v_saldo := v_total - v_pagado;

    -- 6. Impedir pagos superiores al saldo
    IF p_monto > v_saldo THEN
        RAISE EXCEPTION
            'Pago excede el saldo. Saldo disponible: Q%',
            v_saldo;
    END IF;

    -- 7. Registrar pago
    -- PostgreSQL genera id_pago automáticamente
    INSERT INTO pagos_factura (
        id_factura,
        id_forma_pago,
        monto,
        referencia
    )
    VALUES (
        p_id_factura,
        p_id_forma_pago,
        p_monto,
        p_referencia
    );

    -- 8. Actualizar estado si se liquida
    IF p_monto = v_saldo THEN
        UPDATE facturas_encabezado
        SET estado = 'PAGADO'
        WHERE id_factura = p_id_factura;
    END IF;

    RAISE NOTICE
        'Pago registrado. Saldo pendiente: Q%',
        v_saldo - p_monto;

END;
$$;

CREATE OR REPLACE PROCEDURE public.confirmar_factura(IN p_id_factura integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_estado VARCHAR(20);
    v_total NUMERIC(12,2);
    v_id_movimiento INTEGER;
    v_pendiente INTEGER;
    v_descontar INTEGER;
    r RECORD;
    c RECORD;
BEGIN

    -- Verificar y bloquear la factura
    SELECT estado
    INTO v_estado
    FROM facturas_encabezado
    WHERE id_factura = p_id_factura
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La factura % no existe', p_id_factura;
    END IF;

    IF v_estado <> 'PENDIENTE' THEN
        RAISE EXCEPTION 'La factura % no esta pendiente', p_id_factura;
    END IF;

    -- Verificar productos
    IF NOT EXISTS (
        SELECT 1
        FROM facturas_detalle
        WHERE id_factura = p_id_factura
    ) THEN
        RAISE EXCEPTION 'La factura no contiene productos';
    END IF;

    -- Calcular total
    SELECT SUM(cantidad * precio_unitario)
    INTO v_total
    FROM facturas_detalle
    WHERE id_factura = p_id_factura;

    -- Bloquear productos para evitar ventas simultaneas
    PERFORM 1
    FROM productos
    WHERE id_producto IN (
        SELECT id_producto
        FROM facturas_detalle
        WHERE id_factura = p_id_factura
    )
    ORDER BY id_producto
    FOR UPDATE;

    -- Validar stock de todos los productos
    IF EXISTS (
        SELECT 1
        FROM facturas_detalle fd
        INNER JOIN productos p
            ON fd.id_producto = p.id_producto
        WHERE fd.id_factura = p_id_factura
          AND fd.cantidad > p.stock_actual
    ) THEN
        RAISE EXCEPTION 'Stock insuficiente para completar la factura';
    END IF;

    -- Registrar movimiento de salida
    INSERT INTO movimientos_inventario (
        tipo_movimiento,
        referencia,
        observaciones
    )
    VALUES (
        'SALIDA',
        'FACTURA-' || p_id_factura,
        'Salida por facturacion'
    )
    RETURNING id_movimiento INTO v_id_movimiento;

    -- Procesar cada producto
    FOR r IN
        SELECT id_producto, cantidad
        FROM facturas_detalle
        WHERE id_factura = p_id_factura
        ORDER BY id_producto
    LOOP

        v_pendiente := r.cantidad;

        -- Descontar desde las cajas disponibles
        FOR c IN
            SELECT id_caja, cantidad
            FROM inventario_ubicacion
            WHERE id_producto = r.id_producto
              AND cantidad > 0
            ORDER BY id_caja
            FOR UPDATE
        LOOP

            EXIT WHEN v_pendiente = 0;

            v_descontar := LEAST(v_pendiente, c.cantidad);

            UPDATE inventario_ubicacion
            SET cantidad = cantidad - v_descontar,
                fecha_ultima_actualizacion = CURRENT_TIMESTAMP
            WHERE id_producto = r.id_producto
              AND id_caja = c.id_caja;

            INSERT INTO detalle_movimiento_inventario (
                id_movimiento,
                id_producto,
                id_caja_origen,
                id_caja_destino,
                cantidad
            )
            VALUES (
                v_id_movimiento,
                r.id_producto,
                c.id_caja,
                NULL,
                v_descontar
            );

            v_pendiente := v_pendiente - v_descontar;

        END LOOP;

        IF v_pendiente > 0 THEN
            RAISE EXCEPTION
                'No se pudo completar la salida del producto %',
                r.id_producto;
        END IF;

    END LOOP;

    -- Actualizar factura
    UPDATE facturas_encabezado
    SET total = v_total,
        estado = 'EMITIDA'
    WHERE id_factura = p_id_factura;

    RAISE NOTICE
        'Factura % confirmada. Total Q %',
        p_id_factura,
        v_total;

END;
$$;

CREATE VIEW public.vw_inventario_critico AS
 SELECT id_producto,
    codigo_barras,
    nombre_producto,
    stock_minimo,
    stock_actual,
    (stock_minimo - stock_actual) AS cantidad_faltante
   FROM public.productos
  WHERE (stock_actual <= stock_minimo);

CREATE VIEW public.vw_stock_productos AS
 SELECT p.id_producto,
    p.codigo_barras,
    p.nombre_producto,
    c.nombre_categoria,
    p.stock_minimo,
    p.stock_actual,
        CASE
            WHEN (p.stock_actual = 0) THEN 'SIN STOCK'::text
            WHEN (p.stock_actual <= p.stock_minimo) THEN 'STOCK BAJO'::text
            ELSE 'DISPONIBLE'::text
        END AS estado_stock
   FROM (public.productos p
     JOIN public.categorias c ON ((p.id_categoria = c.id_categoria)));

CREATE VIEW public.vw_ubicacion_productos AS
 SELECT p.codigo_barras,
    p.nombre_producto,
    b.nombre_bodega,
    u.nombre_ubicacion,
    e.codigo_estante,
    f.numero_fila,
    ca.codigo_caja,
    iu.cantidad
   FROM ((((((public.inventario_ubicacion iu
     JOIN public.productos p ON ((iu.id_producto = p.id_producto)))
     JOIN public.cajas ca ON ((iu.id_caja = ca.id_caja)))
     JOIN public.filas f ON ((ca.id_fila = f.id_fila)))
     JOIN public.estantes e ON ((f.id_estante = e.id_estante)))
     JOIN public.ubicaciones u ON ((e.id_ubicacion = u.id_ubicacion)))
     JOIN public.bodegas b ON ((u.id_bodega = b.id_bodega)));

CREATE TRIGGER trg_sincronizar_stock AFTER INSERT OR DELETE OR UPDATE ON public.inventario_ubicacion FOR EACH ROW EXECUTE FUNCTION public.fn_sincronizar_stock();
COMMIT;
