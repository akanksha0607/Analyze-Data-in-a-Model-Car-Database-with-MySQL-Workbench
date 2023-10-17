-- inventory composition percentage warehouse wise.
SELECT
    p.warehouseCode,
    sum(p.quantityInStock) AS ProductCount,
    (sum(p.quantityInStock) / (SELECT SUM(quantityInStock) FROM products)) * 100 AS InventoryCompositionPercentage
FROM    products p 
GROUP BY
    p.warehouseCode
ORDER BY
     p.warehouseCode;
     
-- inventory composition percentage warehouse wise and also productline wise
SELECT
    p.warehouseCode,p.productline,
    sum(p.quantityInStock) AS ProductCount,
    (sum(p.quantityInStock) / (SELECT SUM(quantityInStock) FROM products)) * 100 AS InventoryCompositionPercentage
FROM    products p 
GROUP BY
    p.warehouseCode,p.productline
ORDER BY
     p.warehouseCode;
