USE [DMA]
GO
/****** Object:  StoredProcedure [dbo].[editDevoteeInformation]    Script Date: 8/17/2016 10:53:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- 
-- Author							Created Date		Comments
-- Vamsi Krishna Pulavarthi			12/01/2013			Get Devotee Information for Devotee ID
-- 
-- ToDo: Add Error Checking to see if the Devotee Id Exists? This could be implemented as part of the Code
-- =============================================
CREATE PROCEDURE [dbo].[GetDevoteeInformation]
	-- Input Options for the stored procedure
	@devoteeID int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT Devotee.Devotee_Title, Devotee.Devotee_M_Name, Devotee.Devotee_First_Name, Devotee.Devotee_Last_Name, Devotee_Contact_Info.Devotee_Contact_Info_ID, Devotee_Contact_Info.Devotee_Phone1, Devotee_Contact_Info.Devotee_Phone2, Devotee_Contact_Info.Devotee_Email1, Devotee_Contact_Info.Devotee_Email2, Devotee_Mail_Address.Devotee_Mail_Address_ID, Devotee_Mail_Address.Devotee_Address1, Devotee_Mail_Address.Devotee_Address2, Devotee_Mail_Address.Devotee_City, Devotee_Mail_Address.Devotee_State_CD, Devotee_Mail_Address.Devotee_Zip_CD 
		FROM Devotee INNER JOIN Devotee_Contact_Info ON Devotee.Devotee_ID = Devotee_Contact_Info.Devotee_ID 
			INNER JOIN Devotee_Mail_Address ON Devotee_Contact_Info.Devotee_ID = Devotee_Mail_Address.Devotee_ID 
		WHERE (Devotee.Devotee_ID = @devoteeID);

	 RETURN 0;
END
