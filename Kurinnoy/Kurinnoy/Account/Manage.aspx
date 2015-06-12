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

                <div class="container-fluid bg-info" id="jobOfferModal" runat="server" visible="false">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3><span class="label label-warning" id="qid">!</span> New Project</h3>
                                <br />
                                <h4 id="desciptionLabel" runat="server"></h4>
                                <br />
                                <h5  id="priceLabel" runat="server"></h5>
                                <h5  id="workerNumberLabel" runat="server"></h5>
                            </div>
                            <div class="modal-body">
                                <asp:Button class="btn btn-success" runat="server" ID="acceptButton" Text="Accept Offer" OnClick="acceptButton_Click"/>
                                    <asp:Button class="btn btn-primary" runat="server" ID="declineButton" Text="Decline Offer" OnClick="declineButton_Click"/>
                                  
                                <div class="col-xs-3 col-xs-offset-5">
                                    <div id="loadbar" style="display: none;">
                                        <div class="blockG" id="rotateG_01"></div>
                                        <div class="blockG" id="rotateG_02"></div>
                                        <div class="blockG" id="rotateG_03"></div>
                                        <div class="blockG" id="rotateG_04"></div>
                                        <div class="blockG" id="rotateG_05"></div>
                                        <div class="blockG" id="rotateG_06"></div>
                                        <div class="blockG" id="rotateG_07"></div>
                                        <div class="blockG" id="rotateG_08"></div>
                                    </div>
                                </div>

                                <div class="quiz" id="quiz" data-toggle="buttons">
                                    <%-- <label class="element-animation1 btn btn-lg btn-success btn-block" ><span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span>
                                        <input type="radio" name="q_answer" value="1">
                                         </label> --%>
                                    <%--<label class="element-animation2 btn btn-lg btn-primary btn-block"><span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span>
                                        <input type="radio" name="q_answer" value="2">
                                        </label>--%>                    
                                </div>
                            </div>
                            <div class="modal-footer text-muted">
                                <span id="answerLabel" runat="server"></span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

     <script type="text/javascript">

         //$(function () {
         //    var loading = $('#loadbar').hide();
         //    $(document)
         //    .ajaxStart(function () {
         //        loading.show();
         //    }).ajaxStop(function () {
         //        loading.hide();
         //    });

         //    $("label.btn").on('click', function () {
         //        var choice = $(this).find('input:radio').val();
         //        $('#loadbar').show();
         //        $('#quiz').fadeOut();
         //        setTimeout(function () {
         //            $("#answer").html($(this).checking(choice));
         //            $('#quiz').show();
         //            $('#loadbar').fadeOut();
         //            /* something else */
         //        }, 1500);
         //    });

         //    $ans = 3;

         //    $.fn.checking = function (ck) {
                 
         //        if (ck != $ans)
         //            return 'INCORRECT';
         //        else
         //            return 'CORRECT';
         //    };
         //});

</script>
    <style>
        .txtright{
            text-align:right;
        }

        #qid {
  padding: 10px 15px;
  -moz-border-radius: 50px;
  -webkit-border-radius: 50px;
  border-radius: 20px;
}
label.btn {
    padding: 18px 60px;
    white-space: normal;
    -webkit-transform: scale(1.0);
    -moz-transform: scale(1.0);
    -o-transform: scale(1.0);
    -webkit-transition-duration: .3s;
    -moz-transition-duration: .3s;
    -o-transition-duration: .3s
}

label.btn:hover {
    text-shadow: 0 3px 2px rgba(0,0,0,0.4);
    -webkit-transform: scale(1.1);
    -moz-transform: scale(1.1);
    -o-transform: scale(1.1)
}
label.btn-block {
    text-align: left;
    position: relative
}

label .btn-label {
    position: absolute;
    left: 0;
    top: 0;
    display: inline-block;
    padding: 0 10px;
    background: rgba(0,0,0,.15);
    height: 100%
}

label .glyphicon {
    top: 34%
}
.element-animation1 {
    animation: animationFrames ease .8s;
    animation-iteration-count: 1;
    transform-origin: 50% 50%;
    -webkit-animation: animationFrames ease .8s;
    -webkit-animation-iteration-count: 1;
    -webkit-transform-origin: 50% 50%;
    -ms-animation: animationFrames ease .8s;
    -ms-animation-iteration-count: 1;
    -ms-transform-origin: 50% 50%
}
.element-animation2 {
    animation: animationFrames ease 1s;
    animation-iteration-count: 1;
    transform-origin: 50% 50%;
    -webkit-animation: animationFrames ease 1s;
    -webkit-animation-iteration-count: 1;
    -webkit-transform-origin: 50% 50%;
    -ms-animation: animationFrames ease 1s;
    -ms-animation-iteration-count: 1;
    -ms-transform-origin: 50% 50%
}
.element-animation3 {
    animation: animationFrames ease 1.2s;
    animation-iteration-count: 1;
    transform-origin: 50% 50%;
    -webkit-animation: animationFrames ease 1.2s;
    -webkit-animation-iteration-count: 1;
    -webkit-transform-origin: 50% 50%;
    -ms-animation: animationFrames ease 1.2s;
    -ms-animation-iteration-count: 1;
    -ms-transform-origin: 50% 50%
}
.element-animation4 {
    animation: animationFrames ease 1.4s;
    animation-iteration-count: 1;
    transform-origin: 50% 50%;
    -webkit-animation: animationFrames ease 1.4s;
    -webkit-animation-iteration-count: 1;
    -webkit-transform-origin: 50% 50%;
    -ms-animation: animationFrames ease 1.4s;
    -ms-animation-iteration-count: 1;
    -ms-transform-origin: 50% 50%
}
@keyframes animationFrames {
    0% {
        opacity: 0;
        transform: translate(-1500px,0px)
    }

    60% {
        opacity: 1;
        transform: translate(30px,0px)
    }

    80% {
        transform: translate(-10px,0px)
    }

    100% {
        opacity: 1;
        transform: translate(0px,0px)
    }
}

@-webkit-keyframes animationFrames {
    0% {
        opacity: 0;
        -webkit-transform: translate(-1500px,0px)
    }
    60% {
        opacity: 1;
        -webkit-transform: translate(30px,0px)
    }

    80% {
        -webkit-transform: translate(-10px,0px)
    }

    100% {
        opacity: 1;
        -webkit-transform: translate(0px,0px)
    }
}

@-ms-keyframes animationFrames {
    0% {
        opacity: 0;
        -ms-transform: translate(-1500px,0px)
    }

    60% {
        opacity: 1;
        -ms-transform: translate(30px,0px)
    }
    80% {
        -ms-transform: translate(-10px,0px)
    }

    100% {
        opacity: 1;
        -ms-transform: translate(0px,0px)
    }
}

.modal-header {
    background-color: transparent;
    color: inherit
}

.modal-body {
    min-height: 205px
}
#loadbar {
    position: absolute;
    width: 62px;
    height: 77px;
    top: 2em
}
.blockG {
    position: absolute;
    background-color: #FFF;
    width: 10px;
    height: 24px;
    -moz-border-radius: 8px 8px 0 0;
    -moz-transform: scale(0.4);
    -moz-animation-name: fadeG;
    -moz-animation-duration: .8800000000000001s;
    -moz-animation-iteration-count: infinite;
    -moz-animation-direction: linear;
    -webkit-border-radius: 8px 8px 0 0;
    -webkit-transform: scale(0.4);
    -webkit-animation-name: fadeG;
    -webkit-animation-duration: .8800000000000001s;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-direction: linear;
    -ms-border-radius: 8px 8px 0 0;
    -ms-transform: scale(0.4);
    -ms-animation-name: fadeG;
    -ms-animation-duration: .8800000000000001s;
    -ms-animation-iteration-count: infinite;
    -ms-animation-direction: linear;
    -o-border-radius: 8px 8px 0 0;
    -o-transform: scale(0.4);
    -o-animation-name: fadeG;
    -o-animation-duration: .8800000000000001s;
    -o-animation-iteration-count: infinite;
    -o-animation-direction: linear;
    border-radius: 8px 8px 0 0;
    transform: scale(0.4);
    animation-name: fadeG;
    animation-duration: .8800000000000001s;
    animation-iteration-count: infinite;
    animation-direction: linear
}
#rotateG_01 {
    left: 0;
    top: 28px;
    -moz-animation-delay: .33s;
    -moz-transform: rotate(-90deg);
    -webkit-animation-delay: .33s;
    -webkit-transform: rotate(-90deg);
    -ms-animation-delay: .33s;
    -ms-transform: rotate(-90deg);
    -o-animation-delay: .33s;
    -o-transform: rotate(-90deg);
    animation-delay: .33s;
    transform: rotate(-90deg)
}
#rotateG_02 {
    left: 8px;
    top: 10px;
    -moz-animation-delay: .44000000000000006s;
    -moz-transform: rotate(-45deg);
    -webkit-animation-delay: .44000000000000006s;
    -webkit-transform: rotate(-45deg);
    -ms-animation-delay: .44000000000000006s;
    -ms-transform: rotate(-45deg);
    -o-animation-delay: .44000000000000006s;
    -o-transform: rotate(-45deg);
    animation-delay: .44000000000000006s;
    transform: rotate(-45deg)
}
#rotateG_03 {
    left: 26px;
    top: 3px;
    -moz-animation-delay: .55s;
    -moz-transform: rotate(0deg);
    -webkit-animation-delay: .55s;
    -webkit-transform: rotate(0deg);
    -ms-animation-delay: .55s;
    -ms-transform: rotate(0deg);
    -o-animation-delay: .55s;
    -o-transform: rotate(0deg);
    animation-delay: .55s;
    transform: rotate(0deg)
}
#rotateG_04 {
    right: 8px;
    top: 10px;
    -moz-animation-delay: .66s;
    -moz-transform: rotate(45deg);
    -webkit-animation-delay: .66s;
    -webkit-transform: rotate(45deg);
    -ms-animation-delay: .66s;
    -ms-transform: rotate(45deg);
    -o-animation-delay: .66s;
    -o-transform: rotate(45deg);
    animation-delay: .66s;
    transform: rotate(45deg)
}
#rotateG_05 {
    right: 0;
    top: 28px;
    -moz-animation-delay: .7700000000000001s;
    -moz-transform: rotate(90deg);
    -webkit-animation-delay: .7700000000000001s;
    -webkit-transform: rotate(90deg);
    -ms-animation-delay: .7700000000000001s;
    -ms-transform: rotate(90deg);
    -o-animation-delay: .7700000000000001s;
    -o-transform: rotate(90deg);
    animation-delay: .7700000000000001s;
    transform: rotate(90deg)
}
#rotateG_06 {
    right: 8px;
    bottom: 7px;
    -moz-animation-delay: .8800000000000001s;
    -moz-transform: rotate(135deg);
    -webkit-animation-delay: .8800000000000001s;
    -webkit-transform: rotate(135deg);
    -ms-animation-delay: .8800000000000001s;
    -ms-transform: rotate(135deg);
    -o-animation-delay: .8800000000000001s;
    -o-transform: rotate(135deg);
    animation-delay: .8800000000000001s;
    transform: rotate(135deg)
}
#rotateG_07 {
    bottom: 0;
    left: 26px;
    -moz-animation-delay: .99s;
    -moz-transform: rotate(180deg);
    -webkit-animation-delay: .99s;
    -webkit-transform: rotate(180deg);
    -ms-animation-delay: .99s;
    -ms-transform: rotate(180deg);
    -o-animation-delay: .99s;
    -o-transform: rotate(180deg);
    animation-delay: .99s;
    transform: rotate(180deg)
}
#rotateG_08 {
    left: 8px;
    bottom: 7px;
    -moz-animation-delay: 1.1s;
    -moz-transform: rotate(-135deg);
    -webkit-animation-delay: 1.1s;
    -webkit-transform: rotate(-135deg);
    -ms-animation-delay: 1.1s;
    -ms-transform: rotate(-135deg);
    -o-animation-delay: 1.1s;
    -o-transform: rotate(-135deg);
    animation-delay: 1.1s;
    transform: rotate(-135deg)
}
@-moz-keyframes fadeG {
    0% {
        background-color: #000
    }

    100% {
        background-color: #FFF
    }
}

@-webkit-keyframes fadeG {
    0% {
        background-color: #000
    }

    100% {
        background-color: #FFF
    }
}

@-ms-keyframes fadeG {
    0% {
        background-color: #000
    }

    100% {
        background-color: #FFF
    }
}

@-o-keyframes fadeG {
    0% {
        background-color: #000
    }
    100% {
        background-color: #FFF
    }
}

@keyframes fadeG {
    0% {
        background-color: #000
    }

    100% {
        background-color: #FFF
    }
}

    </style>

</asp:Content>
