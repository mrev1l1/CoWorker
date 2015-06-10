<%@ Page Title="Manage your account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Kurinnoy.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.5.4/bootstrap-select.js"></script>
    <script src="~/Scripts/ManageAccount.js"></script>
    <link href="~/Content/dropdown_select.css" rel="stylesheet" />
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Specify your CoWorker information</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Password :</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <%--<dt>Внешние имена входа:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Управление]" runat="server" />

                    </dd>--%>
                    <%--
                        Номера телефонов можно использовать в качестве второго проверочного фактора для системы двухфакторной проверки подлинности.
                        В <a href="http://go.microsoft.com/fwlink/?LinkId=403804">этой статье</a>
                        вы можете узнать, как для этого приложения ASP.NET настроить двухфакторную проверку подлинности с использованием SMS.
                        Настроив двухфакторную проверку подлинности, раскомментируйте следующие блоки.
                    --%>
                    <%--
                    <dt>Номер телефона:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Добавить]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Изменить]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Удалить]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
                    --%>

                    <%--<dt>Двухфакторная проверка подлинности:</dt>
                    <dd>
                        <p>
                            Поставщики двухфакторной проверки подлинности не настроены. В <a href="http://go.microsoft.com/fwlink/?LinkId=403804">этой статье</a>
                            вы можете узнать, как для этого приложения ASP.NET настроить двухфакторную проверку подлинности.
                            </p>
                        <% if (TwoFactorEnabled)
                          { %> 
                        <%--
                        Enabled
                        <asp:LinkButton Text="[Отключить]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
                        --%>
                        <%-- }
                          else
                          { %> 
                        <%--
                        Disabled
                        <asp:LinkButton Text="[Включить]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                        --%>
                        <%-- } %>
                    </dd>--%>
                    <dt> Additional info: </dt>
                    <dd>
                        <%:GetAdditionalInfo() %> 
                        <asp:HyperLink NavigateUrl="~/Account/ManageAditionalInfo" Text="[Change]" Visible="true" ID="AdditionalInfoChangeLink" runat="server" />
                    </dd>
                    <dt> Work Category:  </dt>
                    <dd>
                        <select id="jobCategoriesSelect" multiple="true" class="form-control" runat="server" datasourceid="JobCategoriesSource" datavaluefield="categoryName">
                        </select>
                        <asp:SqlDataSource ID="JobCategoriesSource" runat="server" ConnectionString="<%$ ConnectionStrings:CoWorkerStaffConnectionString %>" SelectCommand="SELECT JobCategories.categoryName FROM JobCategories INNER JOIN CoWorkers INNER JOIN CoWorkerSpecializations ON CoWorkers.Id = CoWorkerSpecializations.coWorkerID ON JobCategories.Id = CoWorkerSpecializations.categoryID WHERE (CoWorkers.email = @email)"></asp:SqlDataSource>
                        <table align="right">
                            <tr>
                                <td>
                                    <asp:HyperLink NavigateUrl="~/Account/ManageJobCategories" Text="[Change]" Visible="true" ID="ManageJobCategories" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </dd>
                    
                </dl>
            </div>
        </div>
    </div>

</asp:Content>
