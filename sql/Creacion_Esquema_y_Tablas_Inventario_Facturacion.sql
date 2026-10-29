-- PROYECTO BASE DE DATOS I - FASE 2
-- CREACION DEL ESQUEMA RELACIONAL: INVENTARIO Y FACTURACION
-- Motor: PostgreSQL 18 (compatible con PostgreSQL moderno)
-- Contiene las 18 tablas originales, identidades, PK, UNIQUE, FK e indices.
-- NO contiene datos ni procedimientos: este archivo es exclusivamente DDL.
-- EJECUTAR EN UNA BASE DE DATOS NUEVA Y VACIA, desde pgAdmin Query Tool.
-- No ejecutar sobre la base actual: las tablas ya existen.

BEGIN;
CREATE SCHEMA IF NOT EXISTS public;

-- 1. TABLAS
CREATE TABLE public.bodegas (
    id_bodega integer NOT NULL,
    nombre_bodega character varying(100) NOT NULL,
    descripcion character varying(255)
);

CREATE TABLE public.cajas (
    id_caja integer NOT NULL,
    id_fila integer NOT NULL,
    codigo_caja character varying(50) NOT NULL,
    descripcion character varying(255)
);

CREATE TABLE public.categorias (
    id_categoria integer NOT NULL,
    nombre_categoria character varying(100) NOT NULL,
    descripcion character varying(255)
);

CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nit character varying(20) NOT NULL,
    nombre_completo character varying(150) NOT NULL,
    direccion character varying(255),
    telefono character varying(20)
);

CREATE TABLE public.compras (
    id_compra integer NOT NULL,
    numero_compra character varying(30) NOT NULL,
    id_proveedor integer NOT NULL,
    fecha_compra timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    total numeric(12,2) DEFAULT 0 NOT NULL,
    CONSTRAINT chk_compra_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'RECIBIDA'::character varying, 'ANULADA'::character varying])::text[]))),
    CONSTRAINT chk_compra_total CHECK ((total >= (0)::numeric))
);

CREATE TABLE public.detalle_compra (
    id_detalle_compra integer NOT NULL,
    id_compra integer NOT NULL,
    id_producto integer NOT NULL,
    id_caja integer NOT NULL,
    cantidad integer NOT NULL,
    costo_unitario numeric(12,2) NOT NULL,
    CONSTRAINT chk_detalle_compra_cantidad CHECK ((cantidad > 0)),
    CONSTRAINT chk_detalle_compra_costo CHECK ((costo_unitario > (0)::numeric))
);

CREATE TABLE public.detalle_movimiento_inventario (
    id_detalle_movimiento integer NOT NULL,
    id_movimiento integer NOT NULL,
    id_producto integer NOT NULL,
    id_caja_origen integer,
    id_caja_destino integer,
    cantidad integer NOT NULL,
    CONSTRAINT chk_cajas_distintas CHECK (((id_caja_origen IS NULL) OR (id_caja_destino IS NULL) OR (id_caja_origen <> id_caja_destino))),
    CONSTRAINT chk_movimiento_cantidad CHECK ((cantidad > 0))
);

CREATE TABLE public.estantes (
    id_estante integer NOT NULL,
    id_ubicacion integer NOT NULL,
    codigo_estante character varying(50) NOT NULL,
    descripcion character varying(255)
);

CREATE TABLE public.facturas_detalle (
    id_detalle integer NOT NULL,
    id_factura integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(12,2) NOT NULL,
    CONSTRAINT chk_detalle_cantidad CHECK ((cantidad > 0)),
    CONSTRAINT chk_detalle_precio CHECK ((precio_unitario >= (0)::numeric))
);

CREATE TABLE public.facturas_encabezado (
    id_factura integer NOT NULL,
    numero_factura character varying(30) NOT NULL,
    fecha_emision timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_cliente integer NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    total numeric(12,2) DEFAULT 0 NOT NULL,
    CONSTRAINT chk_factura_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'EMITIDA'::character varying, 'PAGADO'::character varying, 'CANCELADA'::character varying])::text[]))),
    CONSTRAINT chk_factura_total CHECK ((total >= (0)::numeric))
);

CREATE TABLE public.filas (
    id_fila integer NOT NULL,
    id_estante integer NOT NULL,
    numero_fila integer NOT NULL,
    descripcion character varying(255),
    CONSTRAINT chk_numero_fila CHECK ((numero_fila > 0))
);

CREATE TABLE public.formas_pago (
    id_forma_pago integer NOT NULL,
    nombre_forma_pago character varying(50) NOT NULL
);

CREATE TABLE public.inventario_ubicacion (
    id_inventario_ubicacion integer NOT NULL,
    id_producto integer NOT NULL,
    id_caja integer NOT NULL,
    cantidad integer DEFAULT 0 NOT NULL,
    fecha_ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_inventario_cantidad CHECK ((cantidad >= 0))
);

CREATE TABLE public.movimientos_inventario (
    id_movimiento integer NOT NULL,
    fecha_movimiento timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    tipo_movimiento character varying(20) NOT NULL,
    referencia character varying(50),
    observaciones character varying(255),
    CONSTRAINT chk_tipo_movimiento CHECK (((tipo_movimiento)::text = ANY ((ARRAY['ENTRADA'::character varying, 'SALIDA'::character varying, 'TRANSFERENCIA'::character varying, 'AJUSTE'::character varying])::text[])))
);

CREATE TABLE public.pagos_factura (
    id_pago integer NOT NULL,
    id_factura integer NOT NULL,
    id_forma_pago integer NOT NULL,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    monto numeric(12,2) NOT NULL,
    referencia character varying(100),
    CONSTRAINT chk_pago_monto CHECK ((monto > (0)::numeric))
);

CREATE TABLE public.productos (
    id_producto integer NOT NULL,
    codigo_barras character varying(50) NOT NULL,
    nombre_producto character varying(150) NOT NULL,
    precio_compra numeric(12,2) NOT NULL,
    precio_venta numeric(12,2) NOT NULL,
    id_categoria integer NOT NULL,
    id_proveedor integer NOT NULL,
    stock_minimo integer DEFAULT 5 NOT NULL,
    stock_actual integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_producto_precio_compra CHECK ((precio_compra >= (0)::numeric)),
    CONSTRAINT chk_producto_precio_venta CHECK ((precio_venta > (0)::numeric)),
    CONSTRAINT chk_producto_stock_actual CHECK ((stock_actual >= 0)),
    CONSTRAINT chk_producto_stock_minimo CHECK ((stock_minimo >= 0))
);

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    nombre_empresa character varying(150) NOT NULL,
    telefono character varying(20),
    contacto_principal character varying(150)
);

CREATE TABLE public.ubicaciones (
    id_ubicacion integer NOT NULL,
    id_bodega integer NOT NULL,
    nombre_ubicacion character varying(100) NOT NULL,
    descripcion character varying(255)
);

-- 2. COLUMNAS IDENTITY (AUTOINCREMENTALES)
ALTER TABLE public.bodegas ALTER COLUMN id_bodega ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bodegas_id_bodega_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.cajas ALTER COLUMN id_caja ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cajas_id_caja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.categorias ALTER COLUMN id_categoria ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categorias_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.clientes ALTER COLUMN id_cliente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clientes_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.compras ALTER COLUMN id_compra ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.compras_id_compra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.detalle_compra ALTER COLUMN id_detalle_compra ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detalle_compra_id_detalle_compra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.detalle_movimiento_inventario ALTER COLUMN id_detalle_movimiento ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detalle_movimiento_inventario_id_detalle_movimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.estantes ALTER COLUMN id_estante ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.estantes_id_estante_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.facturas_detalle ALTER COLUMN id_detalle ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.facturas_detalle_id_detalle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.facturas_encabezado ALTER COLUMN id_factura ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.facturas_encabezado_id_factura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.filas ALTER COLUMN id_fila ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.filas_id_fila_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.formas_pago ALTER COLUMN id_forma_pago ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.formas_pago_id_forma_pago_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.inventario_ubicacion ALTER COLUMN id_inventario_ubicacion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.inventario_ubicacion_id_inventario_ubicacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.movimientos_inventario ALTER COLUMN id_movimiento ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.movimientos_inventario_id_movimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.pagos_factura ALTER COLUMN id_pago ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pagos_factura_id_pago_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.productos ALTER COLUMN id_producto ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.productos_id_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.proveedores ALTER COLUMN id_proveedor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.proveedores_id_proveedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public.ubicaciones ALTER COLUMN id_ubicacion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ubicaciones_id_ubicacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

-- 3. RESTRICCIONES: CLAVES PRIMARIAS, UNICAS Y FORANEAS
ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT pk_bodegas PRIMARY KEY (id_bodega);

ALTER TABLE ONLY public.cajas
    ADD CONSTRAINT pk_cajas PRIMARY KEY (id_caja);

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT pk_categorias PRIMARY KEY (id_categoria);

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT pk_clientes PRIMARY KEY (id_cliente);

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT pk_compras PRIMARY KEY (id_compra);

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT pk_detalle_compra PRIMARY KEY (id_detalle_compra);

ALTER TABLE ONLY public.detalle_movimiento_inventario
    ADD CONSTRAINT pk_detalle_movimiento PRIMARY KEY (id_detalle_movimiento);

ALTER TABLE ONLY public.estantes
    ADD CONSTRAINT pk_estantes PRIMARY KEY (id_estante);

ALTER TABLE ONLY public.facturas_detalle
    ADD CONSTRAINT pk_facturas_detalle PRIMARY KEY (id_detalle);

ALTER TABLE ONLY public.facturas_encabezado
    ADD CONSTRAINT pk_facturas_encabezado PRIMARY KEY (id_factura);

ALTER TABLE ONLY public.filas
    ADD CONSTRAINT pk_filas PRIMARY KEY (id_fila);

ALTER TABLE ONLY public.formas_pago
    ADD CONSTRAINT pk_formas_pago PRIMARY KEY (id_forma_pago);

ALTER TABLE ONLY public.inventario_ubicacion
    ADD CONSTRAINT pk_inventario_ubicacion PRIMARY KEY (id_inventario_ubicacion);

ALTER TABLE ONLY public.movimientos_inventario
    ADD CONSTRAINT pk_movimientos_inventario PRIMARY KEY (id_movimiento);

ALTER TABLE ONLY public.pagos_factura
    ADD CONSTRAINT pk_pagos_factura PRIMARY KEY (id_pago);

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT pk_productos PRIMARY KEY (id_producto);

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT pk_proveedores PRIMARY KEY (id_proveedor);

ALTER TABLE ONLY public.ubicaciones
    ADD CONSTRAINT pk_ubicaciones PRIMARY KEY (id_ubicacion);

ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT uq_bodega_nombre UNIQUE (nombre_bodega);

ALTER TABLE ONLY public.cajas
    ADD CONSTRAINT uq_caja_fila UNIQUE (id_fila, codigo_caja);

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT uq_categoria_nombre UNIQUE (nombre_categoria);

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT uq_cliente_nit UNIQUE (nit);

ALTER TABLE ONLY public.estantes
    ADD CONSTRAINT uq_estante_ubicacion UNIQUE (id_ubicacion, codigo_estante);

ALTER TABLE ONLY public.facturas_encabezado
    ADD CONSTRAINT uq_factura_numero UNIQUE (numero_factura);

ALTER TABLE ONLY public.facturas_detalle
    ADD CONSTRAINT uq_factura_producto UNIQUE (id_factura, id_producto);

ALTER TABLE ONLY public.filas
    ADD CONSTRAINT uq_fila_estante UNIQUE (id_estante, numero_fila);

ALTER TABLE ONLY public.formas_pago
    ADD CONSTRAINT uq_forma_pago UNIQUE (nombre_forma_pago);

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT uq_numero_compra UNIQUE (numero_compra);

ALTER TABLE ONLY public.inventario_ubicacion
    ADD CONSTRAINT uq_producto_caja UNIQUE (id_producto, id_caja);

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT uq_producto_codigo_barras UNIQUE (codigo_barras);

ALTER TABLE ONLY public.ubicaciones
    ADD CONSTRAINT uq_ubicacion_bodega UNIQUE (id_bodega, nombre_ubicacion);

ALTER TABLE ONLY public.cajas
    ADD CONSTRAINT fk_caja_fila FOREIGN KEY (id_fila) REFERENCES public.filas(id_fila) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra FOREIGN KEY (id_compra) REFERENCES public.compras(id_compra) ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_caja FOREIGN KEY (id_caja) REFERENCES public.cajas(id_caja) ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT fk_detalle_compra_producto FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;

ALTER TABLE ONLY public.facturas_detalle
    ADD CONSTRAINT fk_detalle_factura FOREIGN KEY (id_factura) REFERENCES public.facturas_encabezado(id_factura) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_movimiento_inventario
    ADD CONSTRAINT fk_detalle_movimiento FOREIGN KEY (id_movimiento) REFERENCES public.movimientos_inventario(id_movimiento) ON DELETE RESTRICT;

ALTER TABLE ONLY public.facturas_detalle
    ADD CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.estantes
    ADD CONSTRAINT fk_estante_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES public.ubicaciones(id_ubicacion) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.facturas_encabezado
    ADD CONSTRAINT fk_factura_cliente FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.filas
    ADD CONSTRAINT fk_fila_estante FOREIGN KEY (id_estante) REFERENCES public.estantes(id_estante) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.inventario_ubicacion
    ADD CONSTRAINT fk_inventario_caja FOREIGN KEY (id_caja) REFERENCES public.cajas(id_caja) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.inventario_ubicacion
    ADD CONSTRAINT fk_inventario_producto FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_movimiento_inventario
    ADD CONSTRAINT fk_movimiento_caja_destino FOREIGN KEY (id_caja_destino) REFERENCES public.cajas(id_caja) ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_movimiento_inventario
    ADD CONSTRAINT fk_movimiento_caja_origen FOREIGN KEY (id_caja_origen) REFERENCES public.cajas(id_caja) ON DELETE RESTRICT;

ALTER TABLE ONLY public.detalle_movimiento_inventario
    ADD CONSTRAINT fk_movimiento_producto FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto) ON DELETE RESTRICT;

ALTER TABLE ONLY public.pagos_factura
    ADD CONSTRAINT fk_pago_factura FOREIGN KEY (id_factura) REFERENCES public.facturas_encabezado(id_factura) ON DELETE RESTRICT;

ALTER TABLE ONLY public.pagos_factura
    ADD CONSTRAINT fk_pago_forma_pago FOREIGN KEY (id_forma_pago) REFERENCES public.formas_pago(id_forma_pago) ON DELETE RESTRICT;

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES public.categorias(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_producto_proveedor FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.ubicaciones
    ADD CONSTRAINT fk_ubicacion_bodega FOREIGN KEY (id_bodega) REFERENCES public.bodegas(id_bodega) ON UPDATE CASCADE ON DELETE RESTRICT;

-- 4. INDICES
CREATE INDEX idx_cajas_fila ON public.cajas USING btree (id_fila);

CREATE INDEX idx_detalle_factura ON public.facturas_detalle USING btree (id_factura);

CREATE INDEX idx_detalle_producto ON public.facturas_detalle USING btree (id_producto);

CREATE INDEX idx_estantes_ubicacion ON public.estantes USING btree (id_ubicacion);

CREATE INDEX idx_facturas_cliente ON public.facturas_encabezado USING btree (id_cliente);

CREATE INDEX idx_filas_estante ON public.filas USING btree (id_estante);

CREATE INDEX idx_inventario_caja ON public.inventario_ubicacion USING btree (id_caja);

CREATE INDEX idx_inventario_producto ON public.inventario_ubicacion USING btree (id_producto);

CREATE INDEX idx_productos_categoria ON public.productos USING btree (id_categoria);

CREATE INDEX idx_productos_proveedor ON public.productos USING btree (id_proveedor);

CREATE INDEX idx_ubicaciones_bodega ON public.ubicaciones USING btree (id_bodega);

COMMIT;

-- COMPROBACION: debe devolver 18 tablas.
SELECT COUNT(*) AS total_tablas
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
