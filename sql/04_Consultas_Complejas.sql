-- PROYECTO BASE DE DATOS I - FASE 2
-- SISTEMA DE INVENTARIO Y FACTURACION
-- Consultas y reportes transaccionales (PostgreSQL 18)
-- Ejecutar en la base de datos inventario_facturacion.
-- Las fechas son parametros de ejemplo ajustables.

-- 1. TOP DE PRODUCTOS MAS VENDIDOS EN UN PERIODO
SELECT p.id_producto, p.nombre_producto,
       SUM(fd.cantidad) AS unidades_vendidas,
       SUM(fd.cantidad * fd.precio_unitario) AS monto_generado
FROM public.facturas_detalle fd
INNER JOIN public.facturas_encabezado f ON f.id_factura = fd.id_factura
INNER JOIN public.productos p ON p.id_producto = fd.id_producto
WHERE f.fecha_emision >= DATE '2026-01-01'
  AND f.fecha_emision < DATE '2027-01-01'
  AND f.estado IN ('EMITIDA','PAGADO')
GROUP BY p.id_producto, p.nombre_producto
HAVING SUM(fd.cantidad) > 0
ORDER BY unidades_vendidas DESC, monto_generado DESC;

-- 2. REPORTE CONSOLIDADO POR CLIENTE (INCLUYE CLIENTES SIN FACTURAS)
SELECT c.id_cliente, c.nombre_completo,
       COUNT(f.id_factura) FILTER (WHERE f.estado IN ('EMITIDA','PAGADO')) AS frecuencia_compra,
       COALESCE(SUM(f.total) FILTER (WHERE f.estado IN ('EMITIDA','PAGADO')),0) AS total_gastado,
       COALESCE(ROUND(AVG(f.total) FILTER (WHERE f.estado IN ('EMITIDA','PAGADO')),2),0) AS promedio_compra,
       MAX(f.fecha_emision) FILTER (WHERE f.estado IN ('EMITIDA','PAGADO')) AS ultima_compra
FROM public.clientes c
LEFT JOIN public.facturas_encabezado f ON f.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_completo
ORDER BY total_gastado DESC, c.nombre_completo;

-- 3. COMPRAS A PROVEEDORES CLASIFICADAS POR CATEGORIA
SELECT pr.nombre_empresa AS proveedor, cat.nombre_categoria AS categoria,
       COUNT(DISTINCT co.id_compra) AS cantidad_compras,
       SUM(dc.cantidad) AS unidades_compradas,
       SUM(dc.cantidad * dc.costo_unitario) AS total_comprado,
       ROUND(AVG(dc.costo_unitario),2) AS costo_unitario_promedio
FROM public.compras co
INNER JOIN public.proveedores pr ON pr.id_proveedor = co.id_proveedor
INNER JOIN public.detalle_compra dc ON dc.id_compra = co.id_compra
INNER JOIN public.productos p ON p.id_producto = dc.id_producto
INNER JOIN public.categorias cat ON cat.id_categoria = p.id_categoria
WHERE co.estado = 'RECIBIDA'
GROUP BY pr.id_proveedor, pr.nombre_empresa, cat.id_categoria, cat.nombre_categoria
HAVING SUM(dc.cantidad) > 0
ORDER BY total_comprado DESC;

-- 4. KARDEX: ENTRADAS, SALIDAS Y SALDO ACUMULADO POR PRODUCTO
-- El saldo acumulado se calcula desde los movimientos registrados.
-- Puede diferir del stock actual si hubo carga inicial sin movimiento historico.
WITH kardex AS (
 SELECT m.id_movimiento, m.fecha_movimiento, m.tipo_movimiento,
        m.referencia, p.id_producto, p.nombre_producto,
        d.id_detalle_movimiento, d.cantidad,
        CASE WHEN m.tipo_movimiento = 'ENTRADA' THEN d.cantidad
             WHEN m.tipo_movimiento = 'SALIDA' THEN -d.cantidad
             WHEN m.tipo_movimiento = 'TRANSFERENCIA' THEN 0
             ELSE 0 END AS variacion
 FROM public.movimientos_inventario m
 INNER JOIN public.detalle_movimiento_inventario d ON d.id_movimiento = m.id_movimiento
 INNER JOIN public.productos p ON p.id_producto = d.id_producto
)
SELECT id_producto, nombre_producto, fecha_movimiento, tipo_movimiento,
       referencia, cantidad, variacion,
       SUM(variacion) OVER (
           PARTITION BY id_producto
           ORDER BY fecha_movimiento, id_movimiento, id_detalle_movimiento
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS saldo_movimientos
FROM kardex
ORDER BY id_producto, fecha_movimiento, id_movimiento, id_detalle_movimiento;

-- 5. CIERRE DE CAJA POR FORMA DE PAGO Y PERIODO
SELECT fp.nombre_forma_pago,
       COUNT(pg.id_pago) AS numero_pagos,
       COALESCE(SUM(pg.monto),0) AS monto_cobrado,
       COALESCE(MIN(pg.monto),0) AS pago_minimo,
       COALESCE(MAX(pg.monto),0) AS pago_maximo
FROM public.formas_pago fp
LEFT JOIN public.pagos_factura pg
  ON pg.id_forma_pago = fp.id_forma_pago
 AND pg.fecha_pago >= DATE '2026-01-01'
 AND pg.fecha_pago < DATE '2027-01-01'
GROUP BY fp.id_forma_pago, fp.nombre_forma_pago
ORDER BY monto_cobrado DESC, fp.nombre_forma_pago;

-- 6. INVENTARIO CRITICO Y UBICACION DE PRODUCTOS
SELECT p.id_producto, p.nombre_producto, cat.nombre_categoria,
       p.stock_actual, p.stock_minimo,
       GREATEST(p.stock_minimo - p.stock_actual,0) AS unidades_para_minimo,
       COUNT(DISTINCT iu.id_caja) AS cajas_con_existencia,
       COALESCE(SUM(iu.cantidad),0) AS stock_en_ubicaciones
FROM public.productos p
INNER JOIN public.categorias cat ON cat.id_categoria = p.id_categoria
LEFT JOIN public.inventario_ubicacion iu
  ON iu.id_producto = p.id_producto AND iu.cantidad > 0
GROUP BY p.id_producto, p.nombre_producto, cat.nombre_categoria,
         p.stock_actual, p.stock_minimo
HAVING p.stock_actual <= p.stock_minimo
ORDER BY unidades_para_minimo DESC, p.nombre_producto;

-- 7. HISTORIAL DE FACTURACION Y SALDO PENDIENTE POR CLIENTE
SELECT f.numero_factura, c.nombre_completo AS cliente,
       f.fecha_emision, f.estado, f.total,
       COUNT(pg.id_pago) AS cantidad_pagos,
       COALESCE(SUM(pg.monto),0) AS total_pagado,
       f.total - COALESCE(SUM(pg.monto),0) AS saldo_pendiente
FROM public.facturas_encabezado f
INNER JOIN public.clientes c ON c.id_cliente = f.id_cliente
LEFT JOIN public.pagos_factura pg ON pg.id_factura = f.id_factura
GROUP BY f.id_factura, f.numero_factura, c.nombre_completo,
         f.fecha_emision, f.estado, f.total
ORDER BY f.fecha_emision DESC, f.numero_factura;

-- 8. RESUMEN DE INVENTARIO POR BODEGA Y CATEGORIA
SELECT b.nombre_bodega, cat.nombre_categoria,
       COUNT(DISTINCT p.id_producto) AS productos_distintos,
       SUM(iu.cantidad) AS unidades_almacenadas,
       SUM(iu.cantidad * p.precio_compra) AS valor_inventario_costo,
       ROUND(AVG(p.precio_compra),2) AS costo_promedio_producto
FROM public.inventario_ubicacion iu
INNER JOIN public.productos p ON p.id_producto = iu.id_producto
INNER JOIN public.categorias cat ON cat.id_categoria = p.id_categoria
INNER JOIN public.cajas ca ON ca.id_caja = iu.id_caja
INNER JOIN public.filas fi ON fi.id_fila = ca.id_fila
INNER JOIN public.estantes e ON e.id_estante = fi.id_estante
INNER JOIN public.ubicaciones u ON u.id_ubicacion = e.id_ubicacion
INNER JOIN public.bodegas b ON b.id_bodega = u.id_bodega
GROUP BY b.id_bodega, b.nombre_bodega, cat.id_categoria, cat.nombre_categoria
HAVING SUM(iu.cantidad) > 0
ORDER BY b.nombre_bodega, valor_inventario_costo DESC;
