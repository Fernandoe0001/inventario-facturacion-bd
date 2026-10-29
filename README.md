# Sistema de Inventario y Facturación

**Proyecto Final – Bases de Datos I**

## Descripción del proyecto

Sistema de base de datos relacional desarrollado para administrar el inventario y la facturación de una ferretería.

Permite gestionar productos, categorías, proveedores, clientes, bodegas, ubicaciones, compras, ventas, facturas y pagos, manteniendo el control de existencias mediante procedimientos almacenados y triggers.

## Tecnologías utilizadas

- PostgreSQL 18
- pgAdmin 4
- SQL y PL/pgSQL
- GitHub para documentación y control de versiones

## Estructura de la base de datos

La base de datos `inventario_facturacion` contiene:

- 18 tablas relacionadas.
- Claves primarias y foráneas.
- Restricciones de integridad.
- Procedimientos almacenados.
- Trigger para sincronización del inventario.
- Vistas para consultas y reportes.

El diseño está organizado conforme a los principios de normalización hasta la tercera forma normal (3FN).

## Funcionalidades principales

1. Registro de productos, categorías y proveedores.
2. Administración de clientes.
3. Control de inventario por bodegas y ubicaciones.
4. Registro de compras y recepción de productos.
5. Generación y confirmación de facturas.
6. Registro de pagos.
7. Actualización automática de existencias.
8. Consultas y reportes de inventario y facturación.

## Diagrama entidad-relación

El diagrama completo se encuentra en la carpeta `diagramas`.

## Organización del repositorio

- `sql/`: scripts de creación, datos de prueba, procedimientos, triggers y consultas.
- `docs/`: documentación técnica, diccionario de datos, normalización, guía de ejecución y evidencias.
- `diagramas/`: modelo entidad-relación.

## Instrucciones de ejecución

1. Instalar PostgreSQL y pgAdmin 4.
2. Crear una base de datos llamada `inventario_facturacion`.
3. Abrir Query Tool en pgAdmin.
4. Ejecutar el script de creación del esquema y las tablas.
5. Ejecutar el script de procedimientos, funciones, triggers y vistas.
6. Ejecutar los scripts de inserción de datos de prueba y transacciones.
7. Ejecutar las consultas SQL para comprobar el funcionamiento.
8. Revisar los resultados y las evidencias disponibles en la carpeta `docs`.

**Nota:** ejecutar los scripts en una base de datos vacía y respetar el orden de dependencias.

## Documentación

El repositorio incluye documentación técnica, diagrama entidad-relación, scripts SQL y capturas de las pruebas realizadas en PostgreSQL.

## Conclusión

El proyecto demuestra la implementación de una base de datos relacional para gestionar operaciones comerciales, aplicando integridad referencial, normalización, procedimientos almacenados, triggers y consultas SQL.
