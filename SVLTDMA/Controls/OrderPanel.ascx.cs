using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CommonDTO;

public partial class Controls_OrderPanel : BaseControl
{
    Data data;
    public int rowIndex;
    protected List<ServiceDTO> ServiceList
    {
        get
        {
            if (rblServiceType.SelectedItem == null)
                return Services.FindAll(s => s.Service_Type_ID == ServiceTypes.FirstOrDefault().Service_Type_ID);
            else
                return Services.FindAll(s => s.Service_Type_ID.ToString() == rblServiceType.SelectedItem.Value);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();

        if (!IsPostBack)
        {
            int Devotee_ID = Utilities.GetInteger(Request.QueryString["devoteeid"]);

            rblServiceType.DataSource = ServiceTypes;
            rblServiceType.DataBind();

            ServiceTypeDTO serviceTypeDto = ServiceTypes.Find(st => st.ShowDefault == true);
            if (serviceTypeDto != null)
                rblServiceType.SelectedIndex = rblServiceType.Items.IndexOf(rblServiceType.Items.FindByValue(serviceTypeDto.Service_Type_ID.ToString()));

            gvServiceList.DataSource = ServiceList;
            gvServiceList.DataBind();

        }
    }

    protected void rblServiceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        rowIndex = ServiceList.IndexOf(ServiceList.Find(st => st.ShowDefault == true));

        if (rowIndex < 0)
            rowIndex = ServiceList.IndexOf(ServiceList.FirstOrDefault());

        gvServiceList.DataSource = ServiceList;
        gvServiceList.DataBind();

    }



    protected void gvServiceList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            // Convert the row index stored in the CommandArgument
            // property to an Integer.
            int index = Convert.ToInt32(e.CommandArgument);

            GridViewRow row = gvServiceList.Rows[index];
            int ServiceID = Convert.ToInt16(row.Cells[0].Text);

            using (shoppingCart usersShoppingCart = new shoppingCart())
            {
                usersShoppingCart.AddToCart(Convert.ToInt16(ServiceID), txtServiceDate.Text);
            }
            Response.Redirect("~/devotee/shoppingCart.aspx?devoteeID=" + (string)Request.QueryString["devoteeID"]);
        }
    }
}