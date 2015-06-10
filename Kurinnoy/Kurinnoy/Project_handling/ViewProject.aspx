<%@ Page Title="View Project State" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewProject.aspx.cs" Inherits="Kurinnoy.Project_handling.ViewProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#myCarousel').carousel({
                interval: 10000
            })
            $('.fdi-Carousel .item').each(function () {
                var next = $(this).next();
                if (!next.length) {
                    next = $(this).siblings(':first');
                }
                next.children(':first-child').clone().appendTo($(this));

                if (next.next().length > 0) {
                    next.next().children(':first-child').clone().appendTo($(this));
                }
                else {
                    $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
                }
            });
        });
</script>
    <style>
        .carousel-inner.onebyone-carosel {
            margin: auto;
            width: 90%;
        }

        .onebyone-carosel .active.left {
            left: -33.33%;
        }

        .onebyone-carosel .active.right {
            left: 33.33%;
        }

        .onebyone-carosel .next {
            left: 33.33%;
        }

        .onebyone-carosel .prev {
            left: -33.33%;
        }
    </style>

    <div class="row">
        <br />
        <div class="col-md-9" id="ProjetInfoHolder" runat="server">
           <div class="form-horizontal">
                <h4>Project Information</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>CoWorkers:</dt>
                    <dd>
                        <select id="coWorkers" multiple="true" class="form-control" runat="server">
                        </select>
                    </dd>
                    <br />
                    <dt>Information:</dt>
                    <dd>
                        <p id="projectInformationHolder" runat="server" class="list-group-item-text"></p>
                    </dd>
                </dl>
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

        <div class="container" id="caroselSurface" runat="server">
        <div class="row">
            <div class="span12">
                <div class="well">
                    <div id="myCarousel" class="carousel fdi-Carousel slide">
                     <!-- Carousel items -->
                        <div class="carousel fdi-Carousel slide" id="eventCarousel" data-interval="0">
                            <div class="carousel-inner onebyone-carosel" id="imageCarosel" runat="server">                                
                            </div>
                            <a class="left carousel-control" href="#eventCarousel" data-slide="prev"></a>
                            <a class="right carousel-control" href="#eventCarousel" data-slide="next"></a>
                        </div>
                        <!--/carousel-inner-->
                    </div><!--/myCarousel-->
                </div><!--/well-->
            </div>
        </div>
    </div>
    
    <label class="col-lg-2 control-label">Project Readiness:</label>
    <div class="progress" id="progressBar" runat="server">
    </div>

    <table align="right">
        <tr>
            <td>
                <a id="paymentButton" runat="server" href="#" class="btn btn-info" visible="false">Pay</a>
            </td>
        </tr>
    </table>
    
</asp:Content>
