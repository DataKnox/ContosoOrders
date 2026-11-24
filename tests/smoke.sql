-- tests/smoke.sql
-- Post-deployment script succeed?
IF (SELECT COUNT(*)
    FROM   dbo.OrderStatus
    WHERE  (OrderStatusID = 1
            AND StatusName = 'Pending')
           OR (OrderStatusID = 2
               AND StatusName = 'Shipped')
           OR (OrderStatusID = 3
               AND StatusName = 'Cancelled')) <> 3
    BEGIN
        THROW 50001, 'Order status reference data test failed.', 1;
    END

PRINT 'PASS: Order status reference data';

-- Sproc return the correct result?
BEGIN TRY
    BEGIN TRANSACTION;
    DECLARE @OrderID AS INT;
    INSERT  INTO dbo.Orders (
        CustomerName,
        RequestedShipDate,
        OrderStatusID
    )
    VALUES                  ('CI Test Customer', NULL, 1);
    SET @OrderID = SCOPE_IDENTITY();
    CREATE TABLE #Results (
        OrderID           INT           ,
        CustomerName      NVARCHAR (100),
        RequestedShipDate DATE          ,
        StatusName        VARCHAR (30)  
    );
    INSERT INTO #Results
    EXECUTE dbo.usp_GetOrders ;
    IF NOT EXISTS (SELECT 1
                   FROM   #Results
                   WHERE  OrderID = @OrderID
                          AND CustomerName = 'CI Test Customer'
                          AND StatusName = 'Pending')
        BEGIN
            THROW 50002, 'Stored procedure test failed.', 1;
        END
    ROLLBACK;
    PRINT 'PASS: Stored procedure test';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;
    THROW;
END CATCH

-- A join test
DECLARE @ConstraintRejected AS BIT = 0;

BEGIN TRY
    BEGIN TRANSACTION;
    INSERT  INTO dbo.Orders (
        CustomerName,
        OrderStatusID
    )
    VALUES                  ('Invalid Test Order', 255);
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 547
        SET @ConstraintRejected = 1;
    ELSE
        BEGIN
            IF @@TRANCOUNT > 0
                ROLLBACK;
            THROW;
        END
END CATCH

IF @@TRANCOUNT > 0
    ROLLBACK;

IF @ConstraintRejected = 0
    BEGIN
        THROW 50003, 'Foreign key test failed.', 1;
    END

PRINT 'PASS: Foreign key constraint';