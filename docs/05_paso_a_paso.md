# Guía paso a paso para reproducir la base de datos

**Proyecto:** Sistema de Inventario y Facturación  
**Curso:** Bases de Datos I  
**Motor utilizado:** PostgreSQL 18  
**Cliente SQL:** pgAdmin 4  
**Base de datos:** `inventario_facturacion`

## 1. Requisitos previos

- PostgreSQL 18 instalado y en ejecución.
- pgAdmin 4 instalado y conectado al servidor PostgreSQL.
- Permisos para crear una base de datos y ejecutar scripts SQL.
- Archivos de la carpeta `sql/` de este repositorio.

## 2. Crear una base de datos de prueba

Para evitar alterar los datos del proyecto original, crear una base de datos **vacía** llamada `inventario_facturacion_prueba` desde pgAdmin 4:

1. Abrir pgAdmin 4 y conectarse al servidor.
2. Hacer clic derecho en **Databases > Create > Database**.
3. Escribir `inventario_facturacion_prueba` y guardar.
4. Seleccionar la base creada y abrir **Query Tool**.

> No ejecutar el script de creación sobre la base original si las tablas ya existen.

## 3. Ejecutar los scripts SQL

Los archivos disponibles en `sql/` son:

| Orden | Archivo | Propósito |
|---|---|---|
| 1 | `Creacion_Esquema_y_Tablas_Inventario_Facturacion.sql` | Crear las tablas, claves y restricciones del esquema relacional. |
| 2 | `03_Procedimientos_Triggers_Vistas.sql` | Definir procedimientos, función, trigger y vistas del sistema. |
| 3 | `02_Datos_Prueba_DML.sql` | Cargar los datos iniciales de prueba. |
| 4 | `05_Transacciones_Adicionales.sql` | Registrar transacciones complementarias de compras y facturación. |
| 5 | `04_Consultas_Complejas.sql` | Ejecutar los reportes y consultas de validación. |

**Cómo ejecutar cada archivo:** en Query Tool, seleccionar **Open File** (ícono de carpeta), abrir el script correspondiente y pulsar **Execute** (F5). Revisar la pestaña **Messages** antes de continuar.

**Advertencia:** el orden anterior es una guía según la finalidad de los archivos. No se ha comprobado aquí la ejecución completa de todos los scripts en una base nueva. Si un script DML depende de un procedimiento o de datos aún no cargados, revisar la dependencia y ajustar el orden antes de continuar. No ejecutar dos veces los scripts de inserción sin comprobar antes si crean registros duplicados.

## 4. Verificar la creación de las tablas

En Query Tool, ejecutar:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

El proyecto contempla **18 tablas**. Para contar las tablas creadas:

```sql
SELECT COUNT(*) AS total_tablas
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE';
```

## 5. Verificar los datos de prueba

```sql
SELECT 'categorias' AS tabla, COUNT(*) AS registros FROM public.categorias
UNION ALL
SELECT 'proveedores', COUNT(*) FROM public.proveedores
UNION ALL
SELECT 'clientes', COUNT(*) FROM public.clientes
UNION ALL
SELECT 'productos', COUNT(*) FROM public.productos
UNION ALL
SELECT 'facturas_encabezado', COUNT(*) FROM public.facturas_encabezado
UNION ALL
SELECT 'facturas_detalle', COUNT(*) FROM public.facturas_detalle;
```

Comparar las cantidades obtenidas con los mínimos sugeridos en la guía académica: **5 categorías, 5 proveedores, 10 clientes, 30 productos, 10 facturas y 30 detalles**. Si algún mínimo no se alcanza, registrar el resultado y completar los datos necesarios antes de la entrega.

## 6. Verificar los procedimientos, el trigger y las vistas

```sql
-- Procedimientos y funciones del esquema público
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
ORDER BY routine_name;

-- Triggers definidos por el usuario
SELECT event_object_table, trigger_name, event_manipulation
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table, trigger_name;

-- Vistas
SELECT table_name AS vista
FROM information_schema.views
WHERE table_schema = 'public'
ORDER BY table_name;
```

En este proyecto se implementaron los procedimientos `confirmar_recepcion_compra`, `confirmar_factura` y `registrar_pago_factura`, además de la función `fn_sincronizar_stock`, el trigger `trg_sincronizar_stock` y vistas de consulta de inventario.

## 7. Ejecutar las consultas y reportes

Abrir `sql/04_Consultas_Complejas.sql` y ejecutar las consultas. Comprobar que los resultados correspondan con los registros cargados. Conservar capturas de los reportes relevantes, incluyendo inventario, compras y facturación.

## 8. Evidencias y documentación

- La carpeta `docs/` contiene los PDF de documentación y evidencias del proyecto.
- La carpeta `diagramas/` contiene el diagrama entidad-relación y capturas de consultas y validaciones.
- El archivo `README.md` presenta el proyecto y resume sus funcionalidades.

Las capturas de pantalla muestran pruebas realizadas en pgAdmin 4. No sustituyen la verificación de la ejecución desde cero.

## 9. Problemas comunes

| Problema | Recomendación |
|---|---|
| `relation already exists` | Ejecutar la creación en una base nueva y vacía. |
| `function/procedure already exists` | Evitar duplicar la creación; cuando corresponda, usar `CREATE OR REPLACE` con la misma firma. |
| `violates foreign key constraint` | Insertar primero los registros de las tablas referenciadas. |
| `current transaction is aborted` | Ejecutar `ROLLBACK;`, corregir el error y volver a iniciar la operación. |
| `cannot use subquery in CALL argument` | Obtener primero el identificador en una variable PL/pgSQL y luego ejecutar `CALL`. |
| Clave única duplicada | Revisar si los datos de prueba ya fueron insertados. |

## 10. Comprobación final

- [ ] La base de datos de prueba se creó sin alterar la original.
- [ ] El script DDL creó las 18 tablas.
- [ ] Los datos de prueba se cargaron y se verificaron sus cantidades.
- [ ] Los procedimientos, triggers y vistas están presentes.
- [ ] Las consultas de reportes se ejecutaron y sus resultados fueron revisados.
- [ ] El repositorio contiene el README, scripts, documentación, diagrama y evidencias.
- [ ] El repositorio es accesible para el docente.
- [ ] Se publicó el release `v1.0-entrega-final`.

**Nota:** esta guía documenta el proceso previsto. La ejecución integral en una base nueva debe comprobarse en el equipo donde está instalado PostgreSQL.
