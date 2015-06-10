<%@ Page Title="Manage your account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageJobCategories.aspx.cs" Inherits="Kurinnoy.Account.ManageJobCategories" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.5.4/bootstrap-select.js"></script>
    <script src="~/Scripts/ManageAccount.js"></script>
    <link href="~/Content/dropdown_select.css" rel="stylesheet" />
    <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Choose Categories of Projects you are ready to work on</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Categories:</dt>
                    <dd>
                        <select name="choosedCategories" id="jobCategoriesSelect" multiple="true" class="form-control" runat="server" datasourceid="JobCategoriesSource" datavaluefield="categoryName">
                        </select>
                        
                        <asp:SqlDataSource ID="JobCategoriesSource" runat="server" ConnectionString="<%$ ConnectionStrings:CoWorkerStaffConnectionString %>" SelectCommand="SELECT JobCategories.categoryName FROM JobCategories"></asp:SqlDataSource>
                    </dd>
                </dl>
                <table align="right">
                    <tr>
                        <td>
                            <a href="Manage" class="btn btn-primary">Cancel</a>
                            <asp:Button runat="server" ID="UpdateCategoriesButton" Text="Update" class="btn btn-success" OnClick="UpdateCategoriesButton_Click"></asp:Button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
