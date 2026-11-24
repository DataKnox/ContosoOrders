-- This file contains SQL statements that will be executed after the build script.
-- Paste into postdeploy.sql
INSERT INTO dbo.OrderStatus (
    OrderStatusID,
    StatusName
)
SELECT seed.OrderStatusID,
       seed.StatusName
FROM   (VALUES (1, 'Pending'), (2, 'Shipped'), (3, 'Cancelled'), (4, 'Returned')) AS seed(OrderStatusID, StatusName)
WHERE  NOT EXISTS (SELECT 1
                   FROM   dbo.OrderStatus AS existing
                   WHERE  existing.OrderStatusID = seed.OrderStatusID);