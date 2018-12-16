using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class manage_CheckDepositManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvCheckManagement_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int serviceReqId = Convert.ToInt32(e.Keys[0].ToString());
        DateTime chkDepositDt = Convert.ToDateTime(e.NewValues[0].ToString());
        string chkDepositRegBy = HttpContext.Current.User.Identity.Name.ToString();


        sds_CheckManagement.UpdateParameters["ServiceRequestId"].DefaultValue = Convert.ToString(serviceReqId);
        sds_CheckManagement.UpdateParameters["chkDepositDt"].DefaultValue = Convert.ToString(chkDepositDt);
        sds_CheckManagement.UpdateParameters["chkDepositRegby"].DefaultValue = Convert.ToString(chkDepositRegBy);

        try
        {
            sds_CheckManagement.Update();
        }
        catch (Exception ex)
        {
            
        }

    }

}