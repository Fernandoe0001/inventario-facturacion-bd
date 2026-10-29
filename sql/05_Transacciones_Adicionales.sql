-- COMPLEMENTO FASE 2: 12 TRANSACCIONES, CORRECCION DE ESTADO Y 8 REPORTES
-- PostgreSQL 18 | Ejecutar en inventario_facturacion (Query Tool de pgAdmin)
-- No ejecutar sobre otra base. Crear respaldo antes de ejecutar.
-- Una sola transaccion: si hay error, ROLLBACK; si todo funciona, COMMIT.
-- Idempotente: las operaciones de prueba se identifican por COMP-F2-xxx y FAC-F2-xxx.
-- NO crea ni elimina tablas; conserva datos existentes.

BEGIN;

-- 1. CORREGIR FLUJO: confirmar factura descuenta inventario y la deja EMITIDA.
--    registrar_pago_factura la pasa a PAGADO cuando se liquida.
-- El procedimiento confirmar_factura ya fue creado en el archivo 03.


-- 2. GENERAR 6 COMPRAS RECIBIDAS Y 6 VENTAS PAGADAS = 12 TRANSACCIONES.
-- Cada compra incluye 2 productos; cada venta incluye 2 productos.
-- Si el codigo ya existe, se omite para evitar duplicar existencias y pagos.
DO $fase2$
DECLARE
    i integer;
    v_id integer;
    v_factura integer;
    v_total numeric(12,2);
    v_prod1 integer;
    v_prod2 integer;
    v_costo1 numeric(12,2);
    v_costo2 numeric(12,2);
    v_precio1 numeric(12,2);
    v_precio2 numeric(12,2);
    v_proveedor integer;
    v_caja integer := 1;
    v_compras integer := 0;
    v_ventas integer := 0;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM public.cajas WHERE id_caja = v_caja) THEN
        RAISE EXCEPTION 'No existe la caja 1; no se pueden ejecutar las pruebas';
    END IF;

    -- Compras: 6 operaciones, 2 lineas por compra (12 detalles)
    FOR i IN 1..6 LOOP
        IF EXISTS (SELECT 1 FROM public.compras WHERE numero_compra = 'COMP-F2-' || LPAD(i::text,3,'0')) THEN
            CONTINUE;
        END IF;
        v_prod1 := i;
        v_prod2 := i + 1;
        SELECT id_proveedor, precio_compra INTO v_proveedor, v_costo1
        FROM public.productos WHERE id_producto = v_prod1;
        SELECT precio_compra INTO v_costo2 FROM public.productos WHERE id_producto = v_prod2;
        IF v_proveedor IS NULL OR v_costo1 IS NULL OR v_costo2 IS NULL OR v_costo1 <= 0 OR v_costo2 <= 0 THEN
            RAISE EXCEPTION 'Datos de productos insuficientes para compra %', i;
        END IF;
        INSERT INTO public.compras(numero_compra,id_proveedor)
        VALUES ('COMP-F2-' || LPAD(i::text,3,'0'),v_proveedor)
        RETURNING id_compra INTO v_id;
        INSERT INTO public.detalle_compra(id_compra,id_producto,id_caja,cantidad,costo_unitario)
        VALUES (v_id,v_prod1,v_caja,10,v_costo1),
               (v_id,v_prod2,v_caja,8,v_costo2);
        CALL public.confirmar_recepcion_compra(v_id);
        v_compras := v_compras + 1;
    END LOOP;


    -- Ventas: 6 operaciones, 2 lineas por factura, un pago completo
    FOR i IN 1..6 LOOP
        IF EXISTS (SELECT 1 FROM public.facturas_encabezado WHERE numero_factura = 'FAC-F2-' || LPAD(i::text,3,'0')) THEN
            CONTINUE;
        END IF;
        v_prod1 := i;
        v_prod2 := i + 1;
        SELECT precio_venta INTO v_precio1 FROM public.productos WHERE id_producto = v_prod1;
        SELECT precio_venta INTO v_precio2 FROM public.productos WHERE id_producto = v_prod2;
        IF v_precio1 IS NULL OR v_precio2 IS NULL THEN
            RAISE EXCEPTION 'Productos insuficientes para factura %', i;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.clientes WHERE id_cliente = i) THEN
            RAISE EXCEPTION 'No existe cliente %', i;
        END IF;
        INSERT INTO public.facturas_encabezado(numero_factura,id_cliente)
        VALUES ('FAC-F2-' || LPAD(i::text,3,'0'),i)
        RETURNING id_factura INTO v_factura;
        INSERT INTO public.facturas_detalle(id_factura,id_producto,cantidad,precio_unitario)
        VALUES (v_factura,v_prod1,2,v_precio1),
               (v_factura,v_prod2,1,v_precio2);
        CALL public.confirmar_factura(v_factura);
        SELECT total INTO v_total FROM public.facturas_encabezado WHERE id_factura = v_factura;
        CALL public.registrar_pago_factura(v_factura, 1, v_total, 'PRUEBA-FASE2');
        v_ventas := v_ventas + 1;
    END LOOP;
    RAISE NOTICE 'Nuevas compras: %, nuevas ventas: %, total nuevas transacciones: %',
        v_compras,v_ventas,v_compras+v_ventas;
END;
$fase2$;

COMMIT;

-- 3. VERIFICACIONES PARA CAPTURAS DE EVIDENCIA
-- Transacciones de Fase 2: deben aparecer 12 (6 compras y 6 facturas)
SELECT 'COMPRA' AS operacion, numero_compra AS numero, estado, total
FROM public.compras WHERE numero_compra LIKE 'COMP-F2-%'
UNION ALL
SELECT 'FACTURA', numero_factura, estado, total
FROM public.facturas_encabezado WHERE numero_factura LIKE 'FAC-F2-%'
ORDER BY operacion, numero;

-- Pagos y saldo (todas las nuevas facturas deben estar PAGADO y saldo 0)
SELECT f.numero_factura, f.estado, f.total,
       COALESCE(SUM(p.monto),0) AS pagado,
       f.total - COALESCE(SUM(p.monto),0) AS saldo
FROM public.facturas_encabezado f
LEFT JOIN public.pagos_factura p ON p.id_factura = f.id_factura
WHERE f.numero_factura LIKE 'FAC-F2-%'
GROUP BY f.id_factura, f.numero_factura, f.estado, f.total
ORDER BY f.numero_factura;

-- Stock por ubicaciones: diferencias deben ser cero
SELECT p.id_producto,p.nombre_producto,p.stock_actual,
       COALESCE(SUM(i.cantidad),0) AS stock_por_cajas,
       p.stock_actual-COALESCE(SUM(i.cantidad),0) AS diferencia
FROM public.productos p
LEFT JOIN public.inventario_ubicacion i ON i.id_producto=p.id_producto
GROUP BY p.id_producto,p.nombre_producto,p.stock_actual
ORDER BY p.id_producto;

-- Comprobar existencia de restricciones PK, FK, UNIQUE, CHECK
SELECT CASE con.contype WHEN 'p' THEN 'PK' WHEN 'f' THEN 'FK'
           WHEN 'u' THEN 'UNIQUE' WHEN 'c' THEN 'CHECK' ELSE con.contype::text END AS tipo,
       COUNT(*) AS cantidad
FROM pg_constraint con
JOIN pg_namespace n ON n.oid=con.connamespace
WHERE n.nspname='public' AND con.contype IN ('p','f','u','c')
GROUP BY con.contype ORDER BY tipo;

-- Comprobar que las 18 tablas contienen datos
SELECT relname AS tabla, n_live_tup AS registros_estimados
FROM pg_stat_user_tables WHERE schemaname='public'
ORDER BY relname;

