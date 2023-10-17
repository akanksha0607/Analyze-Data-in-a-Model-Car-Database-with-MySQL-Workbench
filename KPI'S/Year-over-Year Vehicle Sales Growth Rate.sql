-- percentage of increase in sales over the years for every warehouse.
WITH cte AS (
    SELECT
        p.warehouseCode,
        YEAR(o.shippedDate) AS sold_in_year,
        SUM(od.quantityordered) AS sold_count,
        LAG(SUM(od.quantityordered), 1, SUM(od.quantityordered)) OVER (PARTITION BY p.warehouseCode ORDER BY YEAR(o.shippedDate)) AS prev
    FROM
        products p
    JOIN
        orderdetails od ON p.productCode = od.productCode
    JOIN
        orders o ON od.orderNumber = o.orderNumber
    WHERE
        o.shippedDate IS NOT NULL
    GROUP BY
        p.warehouseCode, YEAR(o.shippedDate)
    ORDER BY
        p.warehouseCode, YEAR(o.shippedDate)
)
SELECT
    *,
    ROUND(((sold_count - prev) / prev) * 100, 2) AS percent_inc
FROM
    cte;

-- percentage of increase in sales over the years for every warehouse and also for every product.
WITH cte AS (
    SELECT
        p.warehouseCode,p.productline,
        YEAR(o.shippedDate) AS sold_in_year,
        SUM(od.quantityordered) AS sold_count,
        LAG(SUM(od.quantityordered), 1, SUM(od.quantityordered)) OVER (PARTITION BY p.warehouseCode,p.productline ORDER BY YEAR(o.shippedDate)) AS prev
    FROM
        products p
    JOIN
        orderdetails od ON p.productCode = od.productCode
    JOIN
        orders o ON od.orderNumber = o.orderNumber
    WHERE
        o.shippedDate IS NOT NULL
    GROUP BY
        p.warehouseCode, p.productline, YEAR(o.shippedDate)
    ORDER BY
        p.warehouseCode, p.productline,YEAR(o.shippedDate)
)
SELECT
    *,
    ROUND(((sold_count - prev) / prev) * 100, 2) AS percent_inc
FROM
    cte;
