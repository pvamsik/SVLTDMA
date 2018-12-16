using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    public class order
    {
        public string serviceType { get; set; }
        public string service { get; set; }
        public string name { get; set; }
        public string price { get; set; }
        public string creditCardTrack { get; set; }
        public order()
        {
            serviceType = "";
            service = "";
            name = "";
            price = "0.00";
            creditCardTrack = "";
        }
    }
    public class devoteeInfo
    {
        public string firstName { get; set; }
        public string middleName { get; set; }
        public string lastName { get; set; }
        public string address1 { get; set; }
        public string address2 { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string zip { get; set; }
        public string email { get; set; }

        public devoteeInfo()
        {
            firstName = "";
            middleName = "";
            lastName = "";
            address1 = "";
            address2 = "";
            city = "";
            state = "";
            zip = "";
            email = "";
        }
        public devoteeInfo(string devoteeID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString.ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            string queryString = "SELECT D.Devotee_ID, D.Devotee_First_Name, D.Devotee_Last_Name, D.Devotee_M_Name, DMA.Devotee_Address1, DMA.Devotee_Address2, DMA.Devotee_City, DMA.Devotee_State_CD, DMA.Devotee_Zip_CD, DCI.Devotee_Email1 FROM Devotee AS D INNER JOIN Devotee_Mail_Address AS DMA ON D.Devotee_ID = DMA.Devotee_ID INNER JOIN Devotee_Contact_Info AS DCI ON D.Devotee_ID = DCI.Devotee_ID WHERE D.Devotee_ID = " + devoteeID;
            SqlCommand command = new SqlCommand(queryString, connection);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            try
            {
                while (reader.Read())
                {
                    firstName = reader[1].ToString();
                    middleName = reader[3].ToString();
                    lastName = reader[2].ToString();
                    address1 = reader[4].ToString();
                    address2 = reader[5].ToString();
                    city = reader[6].ToString();
                    state = reader[7].ToString();
                    zip = reader[8].ToString();
                    email = reader[9].ToString();
                }
            }
            catch (Exception)
            {
                firstName = "";
                middleName = "";
                lastName = "";
                address1 = "";
                address2 = "";
                city = "";
                state = "";
                zip = "";
                email = "";
            }
            finally
            {
                // Always call Close when done reading.
                reader.Close();
            }
        }
    }
}
