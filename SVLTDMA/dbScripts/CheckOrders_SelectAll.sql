USE [DMA]
GO
/****** Object:  StoredProcedure [dbo].[CheckOrders_SelectAll]    Script Date: 10/17/2016 9:44:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*********************************************************************
   NAME:     dbo.[CheckManagement_Select]
   PURPOSE:   Created the procedure to return orders paid with Checks

   REVISIONS:
   DATE          AUTHOR           DESCRIPTION
   ----------    ---------------  ------------------------------------
   17-Oct-2016   Vamsi P         1. CREATED the stored Procedure
   

**********************************************************************/
CREATE PROCEDURE [dbo].[CheckOrders_SelectAll]
AS
BEGIN
	SELECT			Orders.Id, 
					Orders.orderDate, 
					Orders.paymentMethodName, 
					Orders.orderTotal, 
					Orders.checkDate, 
					Orders.checkNumber, 
					Orders.checkDepositDate, 
					Orders.checkDepositRegisteredBy, 
					Devotee.Devotee_First_Name, 
					Devotee.Devotee_Last_Name,
					Devotee.Devotee_First_Name + ' ' + Devotee.Devotee_Last_Name as DevoteeFullName
	FROM            Devotee INNER JOIN
							 Orders ON Devotee.Devotee_ID = Orders.devoteeID
	WHERE			Orders.paymentMethodName = 'CHECK'
	ORDER BY		Orders.orderDate DESC

/*	
	SELECT sr.Service_Date, sr.Service_Request_ID, d.Devotee_First_Name, d.Devotee_Last_Name, d.Devotee_First_Name + ' ' + d.Devotee_Last_Name as Name,
		sr.Service_ID, pt.Payment_type_description, sr.Check_Number, sr.Service_Fee_Paid, sr.Status, sr.Check_Date, 
		sr.Check_Deposit_Date, sr.Check_Deposit_Registered_By
	FROM Service_Requests as sr INNER JOIN Devotee as d ON sr.Devotee_ID = d.Devotee_ID 
		AND sr.Devotee_ID = d.Devotee_ID INNER JOIN Payment_Type as pt ON sr.Payment_Type_ID = pt.Payment_type_ID 
		AND sr.Payment_Type_ID = pt.Payment_type_ID 
	WHERE (sr.Payment_Type_ID = 1)
	ORDER BY sr.Service_Date DESC
*/

END


