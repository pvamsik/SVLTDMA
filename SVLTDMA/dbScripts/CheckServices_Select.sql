USE [DMA]
GO
/****** Object:  StoredProcedure [dbo].[CheckServices_Select]    Script Date: 10/31/2016 3:28:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*********************************************************************
   NAME:     dbo.[CheckServices_Select]
   PURPOSE:   Created the procedure to return Services paid with Checks

   REVISIONS:
   DATE          AUTHOR           DESCRIPTION
   ----------    ---------------  ------------------------------------
   12-May-2014   Vamsi P         1. CREATED the stored Procedure
   

**********************************************************************/
ALTER PROCEDURE [dbo].[CheckServices_Select]
AS
BEGIN
	SELECT sr.Service_Date, sr.Service_Request_ID, d.Devotee_First_Name, d.Devotee_Last_Name, d.Devotee_First_Name + ' ' + d.Devotee_Last_Name as Name,
		sr.Service_ID, pt.Payment_type_description, sr.Service_Fee_Paid, sr.Status, sr.Check_Number, sr.Check_Date, 
		sr.Check_Deposit_Date, sr.Check_Deposit_Registered_By
	FROM Service_Requests as sr INNER JOIN Devotee as d ON sr.Devotee_ID = d.Devotee_ID 
		AND sr.Devotee_ID = d.Devotee_ID INNER JOIN Payment_Type as pt ON sr.Payment_Type_ID = pt.Payment_type_ID 
		AND sr.Payment_Type_ID = pt.Payment_type_ID 
	WHERE (sr.Payment_Type_ID = 1)
END


