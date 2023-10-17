-- sold_to_intial_percentage warehouse wise.
SELECT
    p.warehouseCode,
    SUM(p.quantityInStock) AS initial_stock,
    SUM(od.quantityordered) AS sold_count,round(SUM(od.quantityordered)*100/SUM(p.quantityInStock),4) as sold_to_intial_percentage,
    SUM(p.quantityInStock) - SUM(od.quantityordered) AS current_stock_level
FROM
    products p
JOIN
    orderdetails od ON p.productCode = od.productCode
JOIN
    orders o ON od.orderNumber = o.orderNumber
WHERE
    o.shippedDate IS NOT NULL
GROUP BY
    p.warehouseCode
ORDER BY
    p.warehouseCode;

-- sold_to_intial_percentage warehouse wise and also productline wise.
SELECT
    p.warehouseCode,p.productline,
    SUM(p.quantityInStock) AS initial_stock,
    SUM(od.quantityordered) AS sold_count,round(SUM(od.quantityordered)*100/SUM(p.quantityInStock),4) as sold_to_intial_percentage,
    SUM(p.quantityInStock) - SUM(od.quantityordered) AS current_stock_level
FROM
    products p
JOIN
    orderdetails od ON p.productCode = od.productCode
JOIN
    orders o ON od.orderNumber = o.orderNumber
WHERE
    o.shippedDate IS NOT NULL
GROUP BY
    p.warehouseCode,p.productline
ORDER BY
    p.warehouseCode;
