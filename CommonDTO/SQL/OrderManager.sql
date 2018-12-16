
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/17/2016 21:14:29
-- Generated from EDMX file: C:\Users\pvams\OneDrive\Development\SVLTDMA\CommonDTO\Entities\OrderManager.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [DMA];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Order_OrderItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderItems] DROP CONSTRAINT [FK_Order_OrderItem];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[OrderItems]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderItems];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'OrderItems'
CREATE TABLE [dbo].[OrderItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [orderItemGuid] uniqueidentifier  NOT NULL,
    [OrderId] int  NOT NULL,
    [serviceId] int  NOT NULL,
    [serviceDate] nvarchar(max)  NOT NULL,
    [serviceName] nvarchar(max)  NOT NULL,
    [quantity] int  NOT NULL,
    [price] decimal(18,4)  NOT NULL,
    [comments] varchar(max)  NULL,
    [itemStatus] nvarchar(max)  NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [devoteeID] int  NOT NULL,
    [MailAddressId] int  NOT NULL,
    [orderDate] nvarchar(max)  NOT NULL,
    [orderGuid] uniqueidentifier  NOT NULL,
    [orderItemCount] smallint  NOT NULL,
    [orderStatus] nvarchar(max)  NOT NULL,
    [orderTotal] decimal(18,4)  NOT NULL,
    [orderCreatedBy] nvarchar(max)  NULL,
    [paymentStatus] nvarchar(max)  NOT NULL,
    [paymentMethodName] nvarchar(max)  NOT NULL,
    [refundedAmount] decimal(18,4)  NOT NULL,
    [checkDate] datetime  NULL,
    [checkNumber] nvarchar(max)  NULL,
    [checkDepositDate] nvarchar(max)  NOT NULL,
    [checkDepositregisteredBy] nvarchar(max)  NOT NULL,
    [checkRoutingNumber] nvarchar(max)  NULL,
    [checkAccountNumber] nvarchar(max)  NULL,
    [cardType] nvarchar(max)  NULL,
    [cardName] nvarchar(max)  NULL,
    [cardNumberMasked] nvarchar(max)  NULL,
    [cardCVV2] nvarchar(max)  NULL,
    [cardExpirationMonth] nvarchar(max)  NULL,
    [cardExpirationYear] nvarchar(max)  NULL,
    [authorizationTransactionId] nvarchar(max)  NULL,
    [authorizationTransactionCode] nvarchar(max)  NULL,
    [comment1] nvarchar(max)  NOT NULL,
    [comment2] nvarchar(max)  NOT NULL,
    [comment3] nvarchar(max)  NOT NULL,
    [refundTransactionId] nvarchar(max)  NOT NULL,
    [refundTransactionCode] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'OrderItems'
ALTER TABLE [dbo].[OrderItems]
ADD CONSTRAINT [PK_OrderItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [OrderId] in table 'OrderItems'
ALTER TABLE [dbo].[OrderItems]
ADD CONSTRAINT [FK_Order_OrderItem]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Order_OrderItem'
CREATE INDEX [IX_FK_Order_OrderItem]
ON [dbo].[OrderItems]
    ([OrderId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------