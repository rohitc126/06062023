using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class FA_FixedAsset_OfficeEqipment_Furniture_Certify : System.Web.UI.Page
{
    Message msg = new Message();
    BAL_OfficeEquipmentFurniture Office = new BAL_OfficeEquipmentFurniture();
    BAL_FA_CommonMaster comm = new BAL_FA_CommonMaster();
    BALHRM_UploadDocument menu = new BALHRM_UploadDocument();
    BALSGX_VendorMaster vendor = new BALSGX_VendorMaster();
    public DataTable dtMenuDesc;
    FillTreeControl objtree = new FillTreeControl();

    protected void Page_Init(object sender, EventArgs e)
    {
        if (Request.UrlReferrer == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else if (Session["Employee_Code"] == null | Session["EmpName"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else
        {
            string str = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath).ToString();

            DataTable dtEmployeeAccessRight = objtree.CheckEmployeeAccessRight(Session["Employee_Code"].ToString(), str);
            if (dtEmployeeAccessRight.Rows.Count == 0)
            {
                // Response.Redirect(Session["URLName"].ToString());
            }
            if (dtEmployeeAccessRight.Rows.Count > 0)
            {
                Session["nodevalue"] = dtEmployeeAccessRight.Rows[0][1].ToString();
            }
        }
        Session["URLText"] = "Test";
        Session["URLName"] = "Test";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //Load Page Heading
        dtMenuDesc = menu.MenuDesc(Request.QueryString["Menu"].ToString());
        if (!Page.IsPostBack)
        {
            hdnccode.Value = Request.QueryString["comp"].ToString();
            hdnbcode.Value = Request.QueryString["banch"].ToString();
            txtTDate.Text = Request.QueryString["tdate"].ToString();
            Fill_Vendor();
            
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
        }
    }

    void Page_PreRender(object obj, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }

    private void Fill_Vendor()
    {
        ddlVendor.Items.Clear();
        DataTable dt = vendor.FillVendor("0", Session["Employee_Code"].ToString());
        DataView dv = dt.DefaultView;
        dv.RowFilter = " Branch_Code='" + hdnbcode.Value + "'";
        DataTable dt1 = dv.ToTable();
        if (dt1.Rows.Count > 0)
        {
            ddlVendor.DataSource = dt1;
            ddlVendor.DataTextField = "VendorName";
            ddlVendor.DataValueField = "VendorCode";
            ddlVendor.DataBind();
        }
        ddlVendor.Items.Insert(0, new ListItem("All Vendor", "0"));
    }

    private void Fill_Grid()
    {
        pnlView.Visible = false;

        DataTable dt = Office.View_FAP_OfficeEquipment_LogStatus(hdnccode.Value, hdnbcode.Value, ddlVendor.SelectedValue, txtFDate.Text, txtTDate.Text, "Certification Entry");
      
        if (dt.Rows.Count > 0)
        {
           
            gvAsset.DataSource = dt;
            gvAsset.DataBind();
            ViewState["table1"] = dt;
            ErrorContainer.Visible = false;
        }
        else
        {
            gvAsset.DataSource = null;
            gvAsset.DataBind();
            ViewState["table1"] = null;
            ErrorContainer.Visible = true;
            msg.ShowMessage("No Data Found", null, ErrorContainer, MyMessage, "Warning");

        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        Fill_Grid();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        ErrorContainer.Visible = true;
        try
        {
            string result = "";           
            string verified = Session["Employee_Code"].ToString();
            
            if (Session["update"].ToString() == ViewState["update"].ToString())
            {
                result = Office.Insert_FAP_OfficeEquipmentFurniture_LogStatus(Convert.ToDouble(hiddID.Value), ddlStatus.SelectedValue, "Certification Entry", txtRemarks.Text, verified);
            }

            if (result != "")
            {
                Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
                msg.ShowMessage("Record Inserted Successfully", null, ErrorContainer, MyMessage, "Success");
                DataTable dt = Office.View_FAP_OfficeEquipment_LogStatus(hdnccode.Value, hdnbcode.Value, ddlVendor.SelectedValue, txtFDate.Text, txtTDate.Text, "Certification Entry");
             
                if (dt.Rows.Count > 0)
                {
                    gvAsset.DataSource = dt;
                    gvAsset.DataBind();
                }
                else
                {
                    gvAsset.DataSource = null;
                    gvAsset.DataBind();
                }               
            }
            else
            {
                msg.ShowMessage("Record Already Exists", null, ErrorContainer, MyMessage, "Warning");
            }
            Reset();
        }
        catch (Exception ex)
        {
            msg.ShowMessage(null, ex, ErrorContainer, MyMessage, null);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Reset();
    }

    private void Reset()
    {
        ddlStatus.ClearSelection();
        txtRemarks.Text = "";
        pnlView.Visible = false;
    }

    protected void imgView_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton img = (ImageButton)sender;
        GridViewRow gv = (GridViewRow)img.NamingContainer;
        int row = gv.RowIndex;
        Label lblID = gvAsset.Rows[row].FindControl("lblID") as Label;
        Label lbladdBy = gvAsset.Rows[row].FindControl("lbladdBy") as Label;
        Label lbladdDate = gvAsset.Rows[row].FindControl("lbladdDate") as Label;
        Label lblSta_Status = gvAsset.Rows[row].FindControl("lblSta_Status") as Label;
        Label lblSta_Remarks = gvAsset.Rows[row].FindControl("lblSta_Remarks") as Label;
        hiddID.Value = lblID.Text;
        //lblverifiedBy.Text = lbladdBy.Text;
        //lblverifiedDate.Text = lbladdDate.Text;
        //lblLastStatus.Text = lblSta_Status.Text;
        //txtLastRemarks.Text = lblSta_Remarks.Text;
        pnlView.Visible = true;
    }

    protected void btnGVView_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton img = (ImageButton)sender;
        GridViewRow gv = (GridViewRow)img.NamingContainer;
        int row = gv.RowIndex;
        Label lblcopy = gvAsset.Rows[row].FindControl("lblID") as Label;
        DataTable dt = (DataTable)ViewState["table1"];
        DataView dv = dt.DefaultView;
        dv.RowFilter = " OEF_ID='" + lblcopy.Text + "'";
        DataTable dt1 = dv.ToTable();
        FrmDocumentView.DataSource = dt1;
        FrmDocumentView.DataBind();
        this.btnShowPopup_ModalPopupExtender.Show();

    }
}
