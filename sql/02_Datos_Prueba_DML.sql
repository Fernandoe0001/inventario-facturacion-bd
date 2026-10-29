-- DML: Datos de prueba originales del respaldo de inventario_facturacion
-- Se ejecuta UNICAMENTE en una base nueva tras el script DDL.
-- Las columnas IDENTITY requieren OVERRIDING SYSTEM VALUE.
BEGIN;
-- Tabla bodegas: 5 registros
INSERT INTO public.bodegas (id_bodega, nombre_bodega, descripcion) OVERRIDING SYSTEM VALUE VALUES ('1', 'Bodega Principal', 'Almacenamiento general');
INSERT INTO public.bodegas (id_bodega, nombre_bodega, descripcion) OVERRIDING SYSTEM VALUE VALUES ('2', 'Bodega Secundaria', 'Productos de reserva');
INSERT INTO public.bodegas (id_bodega, nombre_bodega, descripcion) OVERRIDING SYSTEM VALUE VALUES ('3', 'Bodega Norte', 'Distribucion zona norte');
INSERT INTO public.bodegas (id_bodega, nombre_bodega, descripcion) OVERRIDING SYSTEM VALUE VALUES ('4', 'Bodega Sur', 'Distribucion zona sur');
INSERT INTO public.bodegas (id_bodega, nombre_bodega, descripcion) OVERRIDING SYSTEM VALUE VALUES ('5', 'Bodega Central', 'Almacenamiento central');

-- Tabla categorias: 10 registros
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('1', 'Herramientas', 'Herramientas manuales');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('2', 'Electricidad', 'Material electrico');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('3', 'Fontaneria', 'Accesorios de plomeria');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('4', 'Pinturas', 'Pinturas y accesorios');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('5', 'Ferreteria', 'Articulos generales');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('6', 'Construccion', 'Materiales de construccion');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('7', 'Seguridad', 'Equipos de proteccion');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('8', 'Jardineria', 'Herramientas de jardin');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('9', 'Automotriz', 'Accesorios automotrices');
INSERT INTO public.categorias (id_categoria, nombre_categoria, descripcion) OVERRIDING SYSTEM VALUE VALUES ('10', 'Iluminacion', 'Productos de iluminacion');

-- Tabla clientes: 15 registros
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('1', '1000001-1', 'Juan Lopez', 'Guatemala', '55520001');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('2', '1000002-2', 'Maria Perez', 'Mixco', '55520002');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('3', '1000003-3', 'Carlos Garcia', 'Villa Nueva', '55520003');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('4', '1000004-4', 'Ana Morales', 'San Juan Sacatepequez', '55520004');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('5', '1000005-5', 'Pedro Ramirez', 'San Pedro Sacatepequez', '55520005');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('6', '1000006-6', 'Sofia Hernandez', 'Guatemala', '55520006');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('7', '1000007-7', 'Luis Gonzalez', 'Mixco', '55520007');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('8', '1000008-8', 'Andrea Martinez', 'Amatitlan', '55520008');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('9', '1000009-9', 'Mario Castillo', 'Guatemala', '55520009');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('10', '1000010-0', 'Gabriela Ruiz', 'Villa Canales', '55520010');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('11', '1000011-1', 'Roberto Flores', 'Guatemala', '55520011');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('12', '1000012-2', 'Claudia Mendez', 'Mixco', '55520012');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('13', '1000013-3', 'Fernando Diaz', 'Chinautla', '55520013');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('14', '1000014-4', 'Daniel Castro', 'San Lucas', '55520014');
INSERT INTO public.clientes (id_cliente, nit, nombre_completo, direccion, telefono) OVERRIDING SYSTEM VALUE VALUES ('15', '1000015-5', 'Paola Estrada', 'Guatemala', '55520015');

-- Tabla proveedores: 15 registros
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('1', 'Distribuidora Central', '55510001', 'Carlos Lopez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('2', 'Ferreteria Industrial', '55510002', 'Juan Perez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('3', 'ElectroMateriales', '55510003', 'Maria Garcia');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('4', 'Pinturas Guatemala', '55510004', 'Pedro Ramirez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('5', 'Comercial del Norte', '55510005', 'Luis Morales');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('6', 'Importadora Universal', '55510006', 'Ana Lopez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('7', 'Suministros Tecnicos', '55510007', 'Jose Hernandez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('8', 'Distribuidora Maya', '55510008', 'Andrea Perez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('9', 'Grupo Comercial GT', '55510009', 'Mario Gonzalez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('10', 'Productos Industriales', '55510010', 'Sofia Martinez');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('11', 'Comercial La Union', '55510011', 'Roberto Diaz');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('12', 'Distribuciones Atlas', '55510012', 'Claudia Ruiz');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('13', 'Suministros del Sur', '55510013', 'Fernando Castro');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('14', 'Importadora Pacifico', '55510014', 'Gabriela Flores');
INSERT INTO public.proveedores (id_proveedor, nombre_empresa, telefono, contacto_principal) OVERRIDING SYSTEM VALUE VALUES ('15', 'Comercial El Progreso', '55510015', 'Daniel Mendez');

-- Tabla formas_pago: 5 registros
INSERT INTO public.formas_pago (id_forma_pago, nombre_forma_pago) OVERRIDING SYSTEM VALUE VALUES ('1', 'EFECTIVO');
INSERT INTO public.formas_pago (id_forma_pago, nombre_forma_pago) OVERRIDING SYSTEM VALUE VALUES ('2', 'TARJETA');
INSERT INTO public.formas_pago (id_forma_pago, nombre_forma_pago) OVERRIDING SYSTEM VALUE VALUES ('3', 'TRANSFERENCIA');
INSERT INTO public.formas_pago (id_forma_pago, nombre_forma_pago) OVERRIDING SYSTEM VALUE VALUES ('4', 'DEPOSITO');
INSERT INTO public.formas_pago (id_forma_pago, nombre_forma_pago) OVERRIDING SYSTEM VALUE VALUES ('5', 'CHEQUE');

-- Tabla ubicaciones: 10 registros
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('1', '1', 'Zona B', 'Herramientas');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('2', '1', 'Zona A', 'Productos generales');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('3', '2', 'Zona B', 'Material electrico');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('4', '2', 'Zona A', 'Productos de reserva');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('5', '3', 'Zona B', 'Productos industriales');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('6', '3', 'Zona A', 'Distribucion norte');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('7', '4', 'Zona B', 'Materiales de construccion');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('8', '4', 'Zona A', 'Distribucion sur');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('9', '5', 'Zona B', 'Productos especiales');
INSERT INTO public.ubicaciones (id_ubicacion, id_bodega, nombre_ubicacion, descripcion) OVERRIDING SYSTEM VALUE VALUES ('10', '5', 'Zona A', 'Productos de alta rotacion');

-- Tabla estantes: 20 registros
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('1', '1', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('2', '2', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('3', '3', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('4', '4', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('5', '5', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('6', '6', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('7', '7', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('8', '8', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('9', '9', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('10', '10', 'E01', 'Estante principal');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('11', '1', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('12', '2', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('13', '3', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('14', '4', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('15', '5', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('16', '6', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('17', '7', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('18', '8', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('19', '9', 'E02', 'Estante secundario');
INSERT INTO public.estantes (id_estante, id_ubicacion, codigo_estante, descripcion) OVERRIDING SYSTEM VALUE VALUES ('20', '10', 'E02', 'Estante secundario');

-- Tabla filas: 40 registros
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('1', '1', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('2', '1', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('3', '2', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('4', '2', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('5', '3', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('6', '3', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('7', '4', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('8', '4', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('9', '5', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('10', '5', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('11', '6', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('12', '6', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('13', '7', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('14', '7', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('15', '8', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('16', '8', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('17', '9', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('18', '9', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('19', '10', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('20', '10', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('21', '11', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('22', '11', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('23', '12', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('24', '12', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('25', '13', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('26', '13', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('27', '14', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('28', '14', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('29', '15', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('30', '15', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('31', '16', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('32', '16', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('33', '17', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('34', '17', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('35', '18', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('36', '18', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('37', '19', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('38', '19', '2', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('39', '20', '1', 'Fila de almacenamiento');
INSERT INTO public.filas (id_fila, id_estante, numero_fila, descripcion) OVERRIDING SYSTEM VALUE VALUES ('40', '20', '2', 'Fila de almacenamiento');

-- Tabla cajas: 80 registros
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('1', '1', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('2', '1', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('3', '2', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('4', '2', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('5', '3', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('6', '3', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('7', '4', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('8', '4', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('9', '5', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('10', '5', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('11', '6', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('12', '6', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('13', '7', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('14', '7', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('15', '8', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('16', '8', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('17', '9', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('18', '9', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('19', '10', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('20', '10', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('21', '11', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('22', '11', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('23', '12', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('24', '12', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('25', '13', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('26', '13', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('27', '14', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('28', '14', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('29', '15', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('30', '15', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('31', '16', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('32', '16', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('33', '17', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('34', '17', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('35', '18', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('36', '18', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('37', '19', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('38', '19', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('39', '20', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('40', '20', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('41', '21', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('42', '21', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('43', '22', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('44', '22', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('45', '23', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('46', '23', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('47', '24', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('48', '24', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('49', '25', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('50', '25', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('51', '26', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('52', '26', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('53', '27', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('54', '27', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('55', '28', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('56', '28', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('57', '29', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('58', '29', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('59', '30', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('60', '30', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('61', '31', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('62', '31', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('63', '32', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('64', '32', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('65', '33', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('66', '33', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('67', '34', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('68', '34', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('69', '35', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('70', '35', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('71', '36', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('72', '36', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('73', '37', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('74', '37', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('75', '38', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('76', '38', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('77', '39', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('78', '39', 'C02', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('79', '40', 'C01', 'Caja de almacenamiento');
INSERT INTO public.cajas (id_caja, id_fila, codigo_caja, descripcion) OVERRIDING SYSTEM VALUE VALUES ('80', '40', 'C02', 'Caja de almacenamiento');

-- Tabla productos: 20 registros
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('4', 'PROD004', 'Cable electrico 12 AWG', '150.00', '210.00', '2', '3', '5', '3');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('5', 'PROD005', 'Tomacorriente doble', '18.00', '30.00', '2', '3', '15', '13');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('6', 'PROD006', 'Interruptor sencillo', '12.00', '22.00', '2', '3', '15', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('9', 'PROD007', 'Tubo PVC 1/2', '15.00', '25.00', '3', '5', '10', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('10', 'PROD008', 'Codo PVC 1/2', '3.00', '6.00', '3', '5', '20', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('7', 'PROD009', 'Pintura blanca galon', '110.00', '160.00', '4', '4', '5', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('8', 'PROD010', 'Brocha 3 pulgadas', '15.00', '28.00', '4', '4', '10', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('11', 'PROD011', 'Tornillos 1/4 caja', '25.00', '40.00', '5', '6', '10', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('13', 'PROD012', 'Clavos 2 pulgadas libra', '8.00', '15.00', '5', '8', '15', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('14', 'PROD013', 'Cemento saco', '65.00', '85.00', '6', '9', '10', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('16', 'PROD014', 'Block de concreto', '4.00', '6.00', '6', '11', '50', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('12', 'PROD015', 'Casco de seguridad', '45.00', '75.00', '7', '7', '8', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('15', 'PROD016', 'Guantes de trabajo', '18.00', '30.00', '7', '10', '10', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('17', 'PROD017', 'Pala cuadrada', '55.00', '85.00', '8', '12', '5', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('18', 'PROD018', 'Manguera 10 metros', '65.00', '100.00', '8', '13', '5', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('19', 'PROD019', 'Aceite motor 20W50', '30.00', '48.00', '9', '14', '10', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('20', 'PROD020', 'Bombilla LED 12W', '15.00', '28.00', '10', '15', '20', '30');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('1', 'PROD001', 'Martillo', '35.00', '55.00', '1', '1', '10', '23');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('2', 'PROD003', 'Alicate universal', '25.00', '40.00', '1', '1', '8', '17');
INSERT INTO public.productos (id_producto, codigo_barras, nombre_producto, precio_compra, precio_venta, id_categoria, id_proveedor, stock_minimo, stock_actual) OVERRIDING SYSTEM VALUE VALUES ('3', 'PROD002', 'Destornillador plano', '12.00', '20.00', '1', '2', '10', '15');

-- Tabla compras: 1 registros
INSERT INTO public.compras (id_compra, numero_compra, id_proveedor, fecha_compra, estado, total) OVERRIDING SYSTEM VALUE VALUES ('1', 'COMP-001', '1', '2026-10-17 17:34:39.925853', 'RECIBIDA', '1195.00');

-- Tabla facturas_encabezado: 1 registros
INSERT INTO public.facturas_encabezado (id_factura, numero_factura, fecha_emision, id_cliente, estado, total) OVERRIDING SYSTEM VALUE VALUES ('1', 'FAC-001', '2026-10-17 17:38:41.095493', '1', 'PAGADO', '495.00');

-- Tabla movimientos_inventario: 2 registros
INSERT INTO public.movimientos_inventario (id_movimiento, fecha_movimiento, tipo_movimiento, referencia, observaciones) OVERRIDING SYSTEM VALUE VALUES ('1', '2026-10-17 17:36:41.589165', 'ENTRADA', 'COMPRA-1', 'Recepcion de mercaderia');
INSERT INTO public.movimientos_inventario (id_movimiento, fecha_movimiento, tipo_movimiento, referencia, observaciones) OVERRIDING SYSTEM VALUE VALUES ('2', '2026-10-17 17:42:55.80353', 'SALIDA', 'FACTURA-1', 'Salida por facturacion');

-- Tabla detalle_compra: 3 registros
INSERT INTO public.detalle_compra (id_detalle_compra, id_compra, id_producto, id_caja, cantidad, costo_unitario) OVERRIDING SYSTEM VALUE VALUES ('1', '1', '1', '1', '20', '35.00');
INSERT INTO public.detalle_compra (id_detalle_compra, id_compra, id_producto, id_caja, cantidad, costo_unitario) OVERRIDING SYSTEM VALUE VALUES ('2', '1', '3', '1', '10', '12.00');
INSERT INTO public.detalle_compra (id_detalle_compra, id_compra, id_producto, id_caja, cantidad, costo_unitario) OVERRIDING SYSTEM VALUE VALUES ('3', '1', '2', '1', '15', '25.00');

-- Tabla facturas_detalle: 3 registros
INSERT INTO public.facturas_detalle (id_detalle, id_factura, id_producto, cantidad, precio_unitario) OVERRIDING SYSTEM VALUE VALUES ('1', '1', '1', '5', '55.00');
INSERT INTO public.facturas_detalle (id_detalle, id_factura, id_producto, cantidad, precio_unitario) OVERRIDING SYSTEM VALUE VALUES ('2', '1', '2', '4', '40.00');
INSERT INTO public.facturas_detalle (id_detalle, id_factura, id_producto, cantidad, precio_unitario) OVERRIDING SYSTEM VALUE VALUES ('3', '1', '3', '3', '20.00');

-- Tabla pagos_factura: 2 registros
INSERT INTO public.pagos_factura (id_pago, id_factura, id_forma_pago, fecha_pago, monto, referencia) OVERRIDING SYSTEM VALUE VALUES ('1', '1', '1', '2026-10-18 21:42:22.14415', '200.00', 'PAGO-001');
INSERT INTO public.pagos_factura (id_pago, id_factura, id_forma_pago, fecha_pago, monto, referencia) OVERRIDING SYSTEM VALUE VALUES ('2', '1', '2', '2026-10-18 21:42:22.14415', '295.00', 'PAGO-002');

-- Tabla inventario_ubicacion: 22 registros
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('2', '3', '2', '8', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('3', '2', '3', '6', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('4', '4', '4', '3', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('5', '5', '5', '13', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('6', '6', '6', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('7', '9', '7', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('8', '10', '8', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('9', '7', '9', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('10', '8', '10', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('11', '11', '11', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('12', '13', '12', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('13', '14', '13', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('14', '16', '14', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('15', '12', '15', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('16', '15', '16', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('17', '17', '17', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('18', '18', '18', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('19', '19', '19', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('20', '20', '20', '30', '2026-10-17 17:18:41.432581');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('1', '1', '1', '23', '2026-10-17 17:42:55.80353');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('22', '2', '1', '11', '2026-10-17 17:42:55.80353');
INSERT INTO public.inventario_ubicacion (id_inventario_ubicacion, id_producto, id_caja, cantidad, fecha_ultima_actualizacion) OVERRIDING SYSTEM VALUE VALUES ('23', '3', '1', '7', '2026-10-17 17:42:55.80353');

-- Tabla detalle_movimiento_inventario: 6 registros
INSERT INTO public.detalle_movimiento_inventario (id_detalle_movimiento, id_movimiento, id_producto, id_caja_origen, id_caja_destino, cantidad) OVERRIDING SYSTEM VALUE VALUES ('1', '1', '1', NULL, '1', '20');
INSERT INTO public.detalle_movimiento_inventario (id_detalle_movimiento, id_movimiento, id_producto, id_caja_origen, id_caja_destino, cantidad) OVERRIDING SYSTEM VALUE VALUES ('2', '1', '2', NULL, '1', '15');
INSERT INTO public.detalle_movimiento_inventario (id_detalle_movimiento, id_movimiento, id_producto, id_caja_origen, id_caja_destino, cantidad) OVERRIDING SYSTEM VALUE VALUES ('3', '1', '3', NULL, '1', '10');
INSERT INTO public.detalle_movimiento_inventario (id_detalle_movimiento, id_movimiento, id_producto, id_caja_origen, id_caja_destino, cantidad) OVERRIDING SYSTEM VALUE VALUES ('4', '2', '1', '1', NULL, '5');
INSERT INTO public.detalle_movimiento_inventario (id_detalle_movimiento, id_movimiento, id_producto, id_caja_origen, id_caja_destino, cantidad) OVERRIDING SYSTEM VALUE VALUES ('5', '2', '2', '1', NULL, '4');
INSERT INTO public.detalle_movimiento_inventario (id_detalle_movimiento, id_movimiento, id_producto, id_caja_origen, id_caja_destino, cantidad) OVERRIDING SYSTEM VALUE VALUES ('6', '2', '3', '1', NULL, '3');

SELECT pg_catalog.setval('public.bodegas_id_bodega_seq', 5, true);
SELECT pg_catalog.setval('public.cajas_id_caja_seq', 80, true);
SELECT pg_catalog.setval('public.categorias_id_categoria_seq', 10, true);
SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 15, true);
SELECT pg_catalog.setval('public.compras_id_compra_seq', 1, true);
SELECT pg_catalog.setval('public.detalle_compra_id_detalle_compra_seq', 3, true);
SELECT pg_catalog.setval('public.detalle_movimiento_inventario_id_detalle_movimiento_seq', 6, true);
SELECT pg_catalog.setval('public.estantes_id_estante_seq', 20, true);
SELECT pg_catalog.setval('public.facturas_detalle_id_detalle_seq', 3, true);
SELECT pg_catalog.setval('public.facturas_encabezado_id_factura_seq', 1, true);
SELECT pg_catalog.setval('public.filas_id_fila_seq', 40, true);
SELECT pg_catalog.setval('public.formas_pago_id_forma_pago_seq', 5, true);
SELECT pg_catalog.setval('public.inventario_ubicacion_id_inventario_ubicacion_seq', 23, true);
SELECT pg_catalog.setval('public.movimientos_inventario_id_movimiento_seq', 2, true);
SELECT pg_catalog.setval('public.pagos_factura_id_pago_seq', 2, true);
SELECT pg_catalog.setval('public.productos_id_producto_seq', 20, true);
SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 15, true);
SELECT pg_catalog.setval('public.ubicaciones_id_ubicacion_seq', 10, true);
COMMIT;
