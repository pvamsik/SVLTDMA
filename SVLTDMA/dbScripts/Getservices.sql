USE [DMA]
GO
/****** Object:  StoredProcedure [dbo].[GetServices]    Script Date: 12/1/2016 1:06:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************************
   NAME:     dbo.GetServices
   PURPOSE:   Created the procedure to return Services for a given Type Id

   REVISIONS:
   DATE          AUTHOR           DESCRIPTION
   ----------    ---------------  ------------------------------------
   21-Jan-2013   Mohan P         1. CREATED the stored Procedure
   

*******************************************************************/


-- [dbo].[GetServices] 1, 1
--  [dbo].[GetServices] 0, 1
ALTER PROCEDURE [dbo].[GetServices] 
	-- Add the parameters for the stored procedure here
	--@ServiceTypeId int = 0,
	--@ServiceId int = 0
AS
BEGIN
		SELECT s.Service_ID, s.[Service_Name], s.[Service_Name] + ' - Fee: (' + convert(varchar(20),s.Service_Fee) + ')' as ServiceDescription, s.Service_Fee
		, s.Service_Type_ID, s.ShowDefault, s.PriceEditable, s.IsActive
	   FROM		dbo.[Service] s
	   WHERE s.IsActive = 1
	   ORDER BY s.[Service_Name]
	  --WHERE		((s.Service_Type_ID =  @ServiceTypeId AND @ServiceTypeId <> 0) OR @ServiceTypeId = 0)
	  --    AND ((s.Service_ID = @ServiceId AND @ServiceId <> 0) OR @ServiceId = 0)
	
END
