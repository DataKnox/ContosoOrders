CREATE TABLE [dbo].[OrderStatus] (
    [OrderStatusID] TINYINT      NOT NULL,
    [StatusName]    VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED ([OrderStatusID] ASC),
    CONSTRAINT [UQ_OrderStatus_StatusName] UNIQUE NONCLUSTERED ([StatusName] ASC)
);


GO

