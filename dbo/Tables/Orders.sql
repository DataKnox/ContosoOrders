CREATE TABLE [dbo].[Orders] (
    [OrderID]           INT            IDENTITY (1, 1) NOT NULL,
    [CustomerName]      NVARCHAR (100) NOT NULL,
    [RequestedShipDate] DATE           NULL,
    [OrderStatusID]     TINYINT        NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY ([OrderStatusID]) REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
);
GO
CREATE NONCLUSTERED INDEX [IX_Orders_RequestedShipDate]
    ON [dbo].[Orders]([RequestedShipDate] ASC);
GO

