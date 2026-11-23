CREATE PROCEDURE dbo.usp_GetOrders
AS
BEGIN
    SET NOCOUNT ON;
    SELECT   o.OrderID,
             o.CustomerName,
             s.StatusName
    FROM     dbo.Orders AS o
             INNER JOIN
             dbo.OrderStatus AS s
             ON s.OrderStatusID = o.OrderStatusID
    ORDER BY o.OrderID;
END