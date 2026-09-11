# E-commerce Sales Funnel Analysis (SQL / BigQuery)

Análisis del embudo de conversión de un e-commerce a partir de datos de eventos
(clickstream): desde la visita a una página hasta la compra. El objetivo es
identificar en qué etapa del embudo se pierden más usuarios, comparar el
rendimiento por canal de adquisición y cuantificar el impacto en ingresos.

## Preguntas de negocio

1. ¿Cuántos usuarios llegan a cada etapa del embudo (vista → carrito →
   checkout → pago → compra)?
2. ¿Cuál es la tasa de conversión entre cada etapa y la conversión global?
3. ¿Qué canales de tráfico convierten mejor?
4. ¿Cuánto tarda un usuario en pasar de ver un producto a comprarlo?
5. ¿Cuál es el impacto del embudo en ingresos (AOV, ingreso por comprador,
   ingreso por visitante)?

## Dataset

Tabla de eventos de usuario en BigQuery (`sql_practice.data`) con, entre
otros, los siguientes campos:

| Campo | Descripción |
|---|---|
| `user_id` | Identificador del usuario |
| `event_type` | `page_view`, `add_to_cart`, `checkout_start`, `payment_info`, `purchase` |
| `event_date` | Marca temporal del evento |
| `traffic_source` | Canal de adquisición (orgánico, pagado, email, etc.) |
| `amount` | Importe de la compra (solo en eventos `purchase`) |

> Todas las consultas trabajan sobre una ventana móvil de los **últimos 30
> días** respecto a la fecha más reciente de la tabla.

## Estructura del repositorio

```
sql-sales-funnel-analysis/
├── README.md
└── queries/
    ├── 01_funnel_stage_counts.sql        -- volumen de eventos por etapa
    ├── 02_conversion_rates.sql           -- tasas de conversión etapa a etapa
    ├── 03_traffic_source_performance.sql -- conversión por canal
    ├── 04_time_to_conversion.sql         -- tiempo medio hasta la compra
    └── 05_revenue_analysis.sql           -- AOV e ingresos por embudo
```

## Herramientas

- **BigQuery Standard SQL**: CTEs, funciones condicionales de agregación
  (`COUNT(CASE WHEN ...)`), `SAFE_DIVIDE` para evitar errores de división por
  cero, y `TIMESTAMP_DIFF` para medir tiempos entre eventos.

## Principales hallazgos

*(Pendiente de completar con los resultados reales al ejecutar las consultas
sobre el dataset — sustituye estos placeholders por tus números.)*

- La mayor caída del embudo se produce entre **[etapa X] → [etapa Y]**, con
  una tasa de conversión de **[XX%]**.
- El canal **[canal]** tiene la mejor tasa de conversión global (**[XX%]**),
  frente al **[XX%]** de **[canal]**.
- El tiempo medio desde la primera vista hasta la compra es de **[XX]
  minutos**.
- El valor medio de pedido (AOV) es de **[XX €]**, con un ingreso medio por
  visitante de **[XX €]**.

## Cómo reproducirlo

1. Crear un proyecto en Google Cloud y habilitar BigQuery.
2. Cargar el dataset de eventos en una tabla con el esquema descrito arriba
   (o adaptar el nombre de la tabla en cada consulta a tu propio proyecto).
3. Ejecutar las consultas de `queries/` en orden desde la consola de
   BigQuery o desde el editor SQL de tu elección.

## Autor

Hamza — Máster en Sistemas Inteligentes, Universidad de Salamanca.
[LinkedIn] · [Portfolio]
