USE [DMA]
GO
/****** Object:  StoredProcedure [dbo].[GetDevotees]    Script Date: 10/15/2016 7:41:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*********************************************************************
   NAME:     dbo.GetAllDevotees
   PURPOSE:   Created the procedure to return all Devotees

   REVISIONS:
   DATE          AUTHOR           DESCRIPTION
   ----------    ---------------  ------------------------------------
   15-Oct-2016   Vamsi P         1. CREATED the stored Procedure
   

*******************************************************************/

CREATE PROCEDURE [dbo].[GetAllDevotees] 
AS
BEGIN
		SELECT * FROM dbo.Devotee	
END

