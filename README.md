# OCP Kata

Kata para explorar [Open Closed Principle](http://c2.com/cgi/wiki?OpenClosedPrinciple)

Un comercio online tiene un proceso de compra donde se calcula el
precio total en base a las siguientes reglas:
 - La suma de los productos elegidos
 - Gastos de envío de $10.00
 - Cupones que descuentan un porcentaje sobre la suma de los productos más los gastos de envío
 - No se aplican gastos de envio si los gastos totales incluidos los cupones superan los $1,000.00


## Requisitos
Ruby 2.0.0 o mayor

## Ejecutar los tests
```bash
$ ruby order_price_test.rb
```
