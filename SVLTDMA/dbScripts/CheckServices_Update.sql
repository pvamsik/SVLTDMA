USE [DMA]
GO
/****** Object:  StoredProcedure [dbo].[CheckServices_Update]    Script Date: 10/31/2016 3:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*********************************************************************
   NAME:		dbo.[CheckServices_Update]
   PURPOSE:		Created the procedure to update Services paid with 
				Checks to register Check Deposit Date

   REVISIONS:
   DATE          AUTHOR           DESCRIPTION
   ----------    ---------------  ------------------------------------
   12-May-2014   Vamsi P         1. CREATED the stored Procedure
   

**********************************************************************/
ALTER PROCEDURE [dbo].[CheckServices_Update]
	@serviceRequestID int
	, @depositDate datetime
	, @depositBy nvarchar(100)
AS
BEGIN
	UPDATE sr
	SET sr.[Check_Deposit_Registered_By] = @depositBy 
		, sr.[Check_Deposit_Date] = @depositDate
	FROM [dbo].[Service_Requests] sr
	WHERE sr.[Service_Request_ID] = @serviceRequestID;

	RETURN 0;
END

