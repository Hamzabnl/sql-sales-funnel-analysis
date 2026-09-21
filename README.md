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

- Las etapas finales del funnel presentan una **tasa de conversión superior al 80% desde Checkout Start hasta Purchase**, lo que sugiere que el proceso de compra presenta una baja fricción en sus etapas finales.

- **Social Media concentra aproximadamente el 30% del tráfico**, pero registra una tasa de conversión cercana al **6%**, inferior a la de otros canales analizados.

- **Email alcanza aproximadamente un 13% de conversión**, mostrando una mayor eficiencia de conversión que Social Media (~6%).

- El **Average Order Value (AOV) se sitúa alrededor de $115**, una métrica relevante para evaluar la eficiencia y rentabilidad de las estrategias de adquisición.

### Recomendaciones de negocio

- **Mantener el proceso de checkout actual**, ya que las tasas de conversión en las etapas finales son elevadas y no muestran una necesidad evidente de cambios importantes.

- **Revisar la estrategia de adquisición en Social Media**, analizando la calidad del tráfico y considerando estrategias de retargeting o captación de leads para mejorar su conversión.

- **Potenciar Email Marketing**, dado que presenta una tasa de conversión superior a Social Media.

- **Monitorizar el coste de adquisición de clientes (CAC) en relación con el AOV**, especialmente en canales con menor conversión, para evaluar la rentabilidad de las campañas.

## Cómo reproducirlo

1. Crear un proyecto en Google Cloud y habilitar BigQuery.
2. Cargar el dataset de eventos en una tabla con el esquema descrito arriba
   (o adaptar el nombre de la tabla en cada consulta a tu propio proyecto).
3. Ejecutar las consultas de `queries/` en orden desde la consola de
   BigQuery o desde el editor SQL de tu elección.

## Autor

Hamza — Máster en Sistemas Inteligentes, Universidad de Salamanca.
