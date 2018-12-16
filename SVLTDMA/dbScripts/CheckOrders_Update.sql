USE [DMA]
GO

/****** Object:  StoredProcedure [dbo].[CheckOrders_Update]    Script Date: 10/17/2016 9:34:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





/*********************************************************************
   NAME:     dbo.[CheckOrders_Update]
   PURPOSE:   Created the procedure to return orders paid with Checks

   REVISIONS:
   DATE          AUTHOR           DESCRIPTION
   ----------    ---------------  ------------------------------------
   17-Oct-2016   Vamsi P         1. CREATED the stored Procedure
   

**********************************************************************/
CREATE PROCEDURE [dbo].[CheckOrders_Update]
	@checkDepositDate nvarchar(50),
	@checkDepositRegisteredBy nvarchar(50),
	@id int
AS
BEGIN
	UPDATE [dbo].[Orders] 
	SET [checkDepositDate] = @checkDepositDate, 
		[checkDepositRegisteredBy] = @checkDepositRegisteredBy 
	WHERE id=@id
END



GO


