CREATE TABLE [dbo].[Orders] (
    [OrderID]       INT            IDENTITY (1, 1) NOT NULL,
    [CustomerName]  NVARCHAR (100) NOT NULL,
    [OrderStatusID] TINYINT        NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY ([OrderStatusID]) REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
);


GO

