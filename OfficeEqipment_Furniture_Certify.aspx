<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OfficeEqipment_Furniture_Certify.aspx.cs"
    Inherits="FA_FixedAsset_OfficeEqipment_Furniture_Certify" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="sgg" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../css/FA_1.css" rel="stylesheet" type="text/css" />

    <script src="../../Jquery/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script src="../../SGX/JavaScript/num2Word.js" type="text/javascript"></script>

    <script src="../../../JavaScript/num2Word.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <div>

            <script type="text/jscript">
        function CheckDatesMinLessMax(source, arg) {
            var day, month, year;
            var fromdate = document.getElementById('<%=txtFDate.ClientID %>');
            var todate = document.getElementById('<%=txtTDate.ClientID %>');
            day = fromdate.value.split("/")[0];
            month = fromdate.value.split("/")[1];
            year = fromdate.value.split("/")[2];
            var fromdate1 = month + '/' + day + '/' + year;
            day = todate.value.split("/")[0];
            month = todate.value.split("/")[1];
            year = todate.value.split("/")[2];
            var todate1 = month + '/' + day + '/' + year;
            var myDate1 = new Date(fromdate1);

            var myDate2 = new Date(todate1);
            if (myDate1 <= myDate2)
                arg.IsValid = true;
            else
                arg.IsValid = false;
                  
        } 
            </script>

        </div>
        <center>
            <table width="100%" style="overflow: scroll;">
                <tr>
                    <td colspan="6">
                        <asp:Panel ID="ErrorContainer" runat="server">
                            <asp:Label ID="MyMessage" runat="server" Font-Size="10pt"></asp:Label>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <table width="100%" border="0" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="FA_Left" style="width: 10%">
                        Vendor/Supplier
                    </td>
                    <td style="width: 10%">
                        <asp:DropDownList ID="ddlVendor" runat="server" CssClass="FA_ddlNormal">
                        </asp:DropDownList>
                    </td>
                    <td class="FA_Left" style="width: 10%">
                        From Invoice Date
                    </td>
                    <td style="width: 15%">
                        <asp:TextBox ID="txtFDate" runat="server" CssClass="FA_txtDate"></asp:TextBox>
                        <sgg:MaskedEditExtender ID="txtStatDate_mee1" runat="server" Mask="99/99/9999" MaskType="Date"
                            Enabled="True" TargetControlID="txtFDate">
                        </sgg:MaskedEditExtender>
                        <sgg:CalendarExtender ID="txtStatDate_Calendar1" runat="server" Format="dd/MM/yyyy"
                            Enabled="True" PopupPosition="BottomLeft" TargetControlID="txtFDate">
                        </sgg:CalendarExtender>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="To date is not less than from date."
                            ToolTip="To date is not less than from date." ClientValidationFunction="CheckDatesMinLessMax"
                            Display="Dynamic" ValidationGroup="Vin" SetFocusOnError="True" ControlToValidate="txtFDate">*</asp:CustomValidator>
                    </td>
                    <td class="FA_Left">
                        To Invoice Date
                    </td>
                    <td class="FA_Left">
                        <asp:TextBox ID="txtTDate" runat="server" CssClass="FA_txtDate" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:Button ID="btnShow" runat="server" Text="Filter List" CssClass="Submit" ValidationGroup="Vin"
                            OnClick="btnShow_Click" />
                        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="Vin" ShowMessageBox="true"
                            ShowSummary="false" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <div class="FA_rowHeader1 glow_1">
                            List Fof Pending for Certify
                        </div>
                        <div style="overflow: auto; max-height: 100px">
                            <asp:GridView ID="gvAsset" runat="server" AutoGenerateColumns="false" CssClass="grid-view_1">
                                <HeaderStyle CssClass="header_1" />
                                <RowStyle CssClass="normal_1" />
                                <AlternatingRowStyle CssClass="alternaterow" />
                                <Columns>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Text='<%#Eval("OEF_ID") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblHEM_Code" runat="server" Text='<%#Eval("OEF_Code") %>' Visible="false"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Attachment">
                                        <ItemTemplate>
                                            <asp:Label ID="lbladdBy" runat="server" Text='<%#Eval("Sta_AddBy") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblSta_Remarks" runat="server" Text='<%#Eval("Sta_Remarks") %>' Visible="false"></asp:Label>
                                            <asp:ImageButton ID="btnGVView" runat="server" Width="20px" Height="20px" ImageUrl="../../images/attach.jpg"
                                                CausesValidation="false" Visible='<%# bool.Parse(Eval("checkcopy").ToString() == "Y" ? "True": "False") %>'
                                                OnClick="btnGVView_Click" />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="BillNo" HeaderText="Bill No">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="29%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BillDate" HeaderText="Bill Date">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BillAmount" HeaderText="Bill Amount">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VAT_Per" HeaderText="VAT_Per">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ExciseDuty_Per" HeaderText="ExciseDuty_Per">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CustomDuty" HeaderText="CustomDuty">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Octroi_Per" HeaderText="Octroi_Per">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FreightAmount" HeaderText="FreightAmount">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GrandTotal" HeaderText="GrandTotal">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="8%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="View" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSta_Status" runat="server" Text='<%#Eval("CurrentStatus") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="lbladdDate" runat="server" Text='<%#Eval("Sta_Addon") %>' Visible="false"></asp:Label>
                                            <asp:ImageButton ID="imgView" runat="server" ImageUrl="~/HRM/HrmImages/view.jpg"
                                                OnClick="imgView_Click" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:Panel ID="pnlView" runat="server" Visible="false">
                            <div class="FA_rowHeader1 glow_1">
                                Status of Approval</div>
                            <table width="100%">
                                <tr>
                                    <td class="FA_Left" style="width: 10%">
                                        Status
                                    </td>
                                    <td class="FA_Left" style="width: 20%">
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="FA_ddlNormal">
                                            <asp:ListItem Value="N">Select Status</asp:ListItem>
                                            <asp:ListItem Value="A">Approved</asp:ListItem>
                                            <asp:ListItem Value="H">Hold</asp:ListItem>
                                            <asp:ListItem Value="C">Cancel</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="Required_ddlStatus" runat="server" ValidationGroup="VComp"
                                            Display="Dynamic" ControlToValidate="ddlStatus" ErrorMessage="Select Status"
                                            ToolTip="Select Status" SetFocusOnError="True" InitialValue="N">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td class="FA_Left" style="width: 10%">
                                        Remarks
                                    </td>
                                    <td class="FA_Left" style="width: 60%">
                                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="FA_txtLongNormal" TextMode="MultiLine"
                                            MaxLength="250">
                                        </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="Required_txtRemarks" runat="server" ValidationGroup="VComp"
                                            Display="Dynamic" ControlToValidate="txtRemarks" ErrorMessage="Enter Remarks"
                                            ToolTip="Enter Remarks" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" align="center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Submit" CausesValidation="true"
                                            ValidationGroup="VComp" OnClick="btnSave_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="Submit" CausesValidation="false"
                                            OnClick="btnCancel_Click" />
                                        <asp:ValidationSummary ID="ValidationSummary2" ValidationGroup="VComp" ShowMessageBox="true"
                                            ShowSummary="false" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                                        <sgg:ModalPopupExtender ID="btnShowPopup_ModalPopupExtender" runat="server" PopupControlID="pnlpopup"
                                            CancelControlID="imgCancels" BackgroundCssClass="modalBackground" TargetControlID="btnShowPopup">
                                        </sgg:ModalPopupExtender>
                                        <asp:Panel ID="pnlpopup" runat="server" Style="display: none;">
                                            <table class="fbgridbox" style="width: 800px">
                                                <tr class="fbinfobox">
                                                    <td align="right" style="padding-right: 5px;">
                                                        <asp:ImageButton ID="imgCancels" runat="server" ImageUrl="~/HRM/HrmImages/close.gif"
                                                            ToolTip="Close User Manual" CausesValidation="False" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="height: 500px; overflow: scroll">
                                                            <asp:FormView ID="FrmDocumentView" runat="server" AllowPaging="false">
                                                                <ItemTemplate>
                                                                    <asp:Image ID="ImgDocument" runat="server" Style="width: 800px; border: solid 1px red"
                                                                        ImageUrl='<%# "~/FA/VendorPayment/VP_Handler.ashx?OEF=" + Eval("OEF_ID") %>' />
                                                                </ItemTemplate>
                                                                <PagerStyle Font-Names="Arial" Font-Size="8px" ForeColor="Maroon" />
                                                            </asp:FormView>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </center>
        <asp:HiddenField ID="hiddID" runat="server" Value="0"></asp:HiddenField>
        <asp:HiddenField ID="hdnccode" runat="server" />
        <asp:HiddenField ID="hdnbcode" runat="server" />
        <asp:HiddenField ID="hdnTdate" runat="server" />
    </div>
    </form>
</body>
</html>
