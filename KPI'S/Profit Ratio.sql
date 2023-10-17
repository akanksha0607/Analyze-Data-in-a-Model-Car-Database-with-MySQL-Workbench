-- profit_Margin_ratio for every warehouse
SELECT
    w.warehouseCode,
    w.warehouseName,
    SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue,
    SUM(p.buyPrice * od.quantityOrdered) AS TotalCost,
    (SUM(od.priceEach * od.quantityOrdered) - SUM(p.buyPrice * od.quantityOrdered)) / SUM(od.priceEach * od.quantityOrdered) AS profit_Margin_ratio
FROM
    warehouses w
LEFT JOIN
    products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN
    orderdetails od ON p.productCode = od.productCode
GROUP BY
    w.warehouseCode, w.warehouseName;

-- profit_Margin_ratio for every warehouse and Productline
SELECT
    w.warehouseCode,
    w.warehouseName,p.productline,
    SUM(od.priceEach * od.quantityOrdered) AS TotalRevenue,
    SUM(p.buyPrice * od.quantityOrdered) AS TotalCost,
    (SUM(od.priceEach * od.quantityOrdered) - SUM(p.buyPrice * od.quantityOrdered)) / SUM(od.priceEach * od.quantityOrdered) AS Margin
FROM
    warehouses w
LEFT JOIN
    products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN
    orderdetails od ON p.productCode = od.productCode
GROUP BY
    w.warehouseCode, w.warehouseName,p.productline;
