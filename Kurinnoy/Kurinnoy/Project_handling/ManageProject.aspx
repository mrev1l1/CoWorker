<%@ Page Title="Manage Project Information" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProject.aspx.cs" Inherits="Kurinnoy.Project_handling.ManageProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="row">
        <br />
        <div class="col-md-9" id="ProjetInfoHolder" runat="server">
           <div class="form-horizontal">
                <h4>Project Information</h4>
                <hr />
                <dl class="dl-horizontal">
                    
                    <dt>Information:</dt>
                    <dd>
                        <div class="col-lg-10">
                            <asp:TextBox ID="projectInformationTextBox" runat="server" class="form-control" TextMode="multiline" Rows="7"></asp:TextBox>
                            <span class="help-block">Feel free to change everything that's writen here the way you want to.</span>
                        </div>
                        <%--<table align="right">
                    <tr>
                        <td>--%>
                            <asp:Button runat="server" ID="UpdateInformationButton" Text="Update" class="btn btn-success" OnClick="UpdateInformationButton_Click"></asp:Button>
                        <%--</td>
                    </tr>
                </table>--%>
                        
                    </dd>

                    <br />
                    <dt> Upload new photos</dt>
                    <dd>
                        <asp:FileUpload ID="imagesUpload" runat="server" class="panel-body" AllowMultiple="True"/>
                        <asp:Button runat="server" ID="uploadsButton" Text="Upload Images" class="btn btn-info" OnClick="uploadsButton_Click"></asp:Button>
                        <asp:Label runat="server" id="statusLabel" text="Upload status: " />
                    </dd>
                    
                    <br />
                    <dt> Set Project readiness: </dt>
                    <dd>

                        <asp:TextBox ID="projectReadinessBox" runat="server" TextMode="Range" ></asp:TextBox>

                    </dd>
                </dl>
               <table>
                   <tr>
                       <td>set changes
                       </td>
                   </tr>
               </table>
            </div>

        </div>

        <div class="col-md-3">
            <div class="form-horizontal">
                <h4>Input Project ID</h4>
                <hr />
                <div class="input-group">
                    <input id="ProjectIdInput" runat="server" type="text" class="form-control">
                    <span class="input-group-btn">
                        <asp:Button id="ShowInfoButton" runat="server" Text="Show" class="btn btn-default" type="button" onclick="ShowInfoButton_Click"></asp:Button>
                    </span>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
