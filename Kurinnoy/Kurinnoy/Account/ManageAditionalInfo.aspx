<%@ Page Title="Manage your account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageAditionalInfo.aspx.cs" Inherits="Kurinnoy.Account.ManageAditionalInfo" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.5.4/bootstrap-select.js"></script>
    <script src="~/Scripts/ManageAccount.js"></script>
    <link href="~/Content/dropdown_select.css" rel="stylesheet" />
    <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Specify your CoWorker information</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Information:</dt>
                    <dd>
                        <div class="form-group">
                            <div class="col-lg-10">
                                <asp:TextBox ID="CoWorkersInformationTextBox" runat="server" class="form-control"  TextMode="multiline"></asp:TextBox>
                                <span class="help-block">Specify any information, that you would consider as helpfull.</span>
                            </div>
                        </div>
                    </dd>
                </dl>
                <table align="right">
                    <tr>
                        <td>
                            <a href="Manage" class="btn btn-primary">Cancel</a>
                            <asp:Button runat="server" ID="UpdateInformationButton" Text="Update" class="btn btn-success" OnClick="UpdateInformationButton_Click"></asp:Button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

</asp:Content>
