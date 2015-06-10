using Kurinnoy.DataBase_Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using Kurinnoy.Models;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

namespace Kurinnoy.Project_handling
{
    public partial class ViewProject : System.Web.UI.Page
    {
               
        protected void Page_Load(object sender, EventArgs e)
        {
            caroselSurface.Visible = false;
        }

        protected void ShowInfoButton_Click(object sender, EventArgs e)
        {
            var ProjectId = ProjectIdInput.Value;

            var Workers = GetWorkersForProject(Convert.ToInt32(ProjectId));

            foreach(CoWorkers W in Workers)
            {
                coWorkers.Items.Add(W.name);
            }

            ShowProjectInformation(Convert.ToString(ProjectId));

            ShowProjectImages(Convert.ToString(ProjectId));

            ShowProgressBar(Convert.ToInt32(ProjectId));

            ShowPaymentButton(Convert.ToInt32(ProjectId));
        }

        void ShowProjectInformation(String projectId)
        {
            StreamReader FileReader = null;

            FileReader = File.OpenText(@"D:\\Microsoft Visual Studio 2013\\Kurinnoy\\Kurinnoy\\App_Data\\project" + projectId + '\\' + projectId + ".txt");

            projectInformationHolder.InnerText = FileReader.ReadToEnd();
        }

        void ShowProjectImages(String projectId)
        {
            Int32 ProjectRelatedJpg = new DirectoryInfo(@"D:\\Microsoft Visual Studio 2013\\Kurinnoy\\Kurinnoy\\App_Data\\project" + projectId).GetFiles("*.jpg").Length;
            Int32 ProjectRelatedJpeg = new DirectoryInfo(@"D:\\Microsoft Visual Studio 2013\\Kurinnoy\\Kurinnoy\\App_Data\\project" + projectId).GetFiles("*.jpeg").Length;
            Int32 ProjectRelatedPng = new DirectoryInfo(@"D:\\Microsoft Visual Studio 2013\\Kurinnoy\\Kurinnoy\\App_Data\\project" + projectId).GetFiles("*png").Length;

            String[] JpgImages = Directory.GetFiles(Server.MapPath("~/App_Data/project" + projectId + '/'), "*.jpg");
            String[] JpegImages = Directory.GetFiles(Server.MapPath("~/App_Data/project" + projectId + '/'), "*.jpeg");
            String[] PngImages = Directory.GetFiles(Server.MapPath("~/App_Data/project" + projectId + '/'), "*.png");

            if (ProjectRelatedJpeg > 0)
                imageCarosel.InnerHtml = "<div class=\"item active\"><div class=\"col-md-4\"><a target=\"_blank\" href=\" " + JpegImages[0] + " \"><img src=\" " + JpegImages[0] + " \" id=\"activeImage\" runat=\"server\" width=\"300\" height=\"220\"></a><div class=\"text-center\">1</div></div></div>";
            else if (ProjectRelatedJpg > 0)
                imageCarosel.InnerHtml = "<div class=\"item active\"><div class=\"col-md-4\"><a target=\"_blank\" href=\" " + JpgImages[0] + " \"><img src=\" " + JpgImages[0] + " \" id=\"activeImage\" runat=\"server\" width=\"300\" height=\"220\"></a><div class=\"text-center\">1</div></div></div>";
            else if (ProjectRelatedPng > 0)
                imageCarosel.InnerHtml = "<div class=\"item active\"><div class=\"col-md-4\"><a target=\"_blank\" href=\" " + PngImages[0] + " \"><img src=\" " + PngImages[0] + " \" id=\"activeImage\" runat=\"server\" width=\"300\" height=\"220\"></a><div class=\"text-center\">1</div></div></div>";

            int i;
            for (i = 1; i < JpegImages.Count(); i++)
            {
                imageCarosel.InnerHtml += "<div class=\"item\"><div class=\"col-md-4\"><a target=\"_blank\" href=\" " + JpegImages[i] + " \"><img src=\" " + JpegImages[i] + " \" id=\"activeImage\" runat=\"server\" width=\"300\" height=\"220\"></a><div class=\"text-center\">" + (i + 1).ToString() + "</div></div></div>";
            }

            i = (ProjectRelatedJpeg > 0) ? 0 : 1;
            for (i = i; i < JpgImages.Count(); i++)
            {
                imageCarosel.InnerHtml += "<div class=\"item\"><div class=\"col-md-4\"><a target=\"_blank\" href=\" " + JpgImages[i] + " \"><img src=\" " + JpgImages[i] + " \" id=\"activeImage\" runat=\"server\" width=\"300\" height=\"220\"></a><div class=\"text-center\">" + (i + 1).ToString() + "</div></div></div>";
            }

            i = (ProjectRelatedJpeg > 0) ? 0 : 1;
            i = (i > 0) ? ((ProjectRelatedJpg > 0) ? 0 : 1) : 1;
            for (i = i; i < PngImages.Count(); i++)
            {
                imageCarosel.InnerHtml += "<div class=\"item\"><div class=\"col-md-4\"><a target=\"_blank\" href=\" " + PngImages[i] + " \"><img src=\" " + PngImages[i] + " \" id=\"activeImage\" runat=\"server\" width=\"300\" height=\"220\"></a><div class=\"text-center\">" + (i + 1).ToString() + "</div></div></div>";
            }
            caroselSurface.Visible = true;
        }

        void ShowProgressBar(int projectId)
        {
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var CurrentProject = DbContext.ActiveProjects.Where(Proj => Proj.projectID.Equals(projectId));

            int ProjectReadiness = CurrentProject.First().readiness;

            String ProgressBarColor;

            if (ProjectReadiness < 34)
                ProgressBarColor = "progress-bar progress-bar-danger";
            else if (ProjectReadiness < 67)
                ProgressBarColor = "progress-bar progress-bar-warning";
            else ProgressBarColor = "progress-bar progress-bar-success";

            progressBar.InnerHtml+="<div class=\""+ProgressBarColor+"\" style=\"width: "+ProjectReadiness+"%\"></div>";

            DbContext.Connection.Close();
        }

        void ShowPaymentButton(int projectId)
        {
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var CurrentProject = DbContext.ActiveProjects.Where(Proj => Proj.projectID.Equals(projectId));

            int ProjectReadiness = CurrentProject.First().readiness;

            if(ProjectReadiness==100)
            {
                paymentButton.Visible = true;
            }
            else
            {
                paymentButton.Visible = false;
            }

            DbContext.Connection.Close();
        }

        List<DataBase_Logic.CoWorkers> GetWorkersForProject(int projectID)
        {
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var Projects = DbContext.ActiveProjects.Where(ActiveProject => ActiveProject.projectID == projectID);

            List<int> WorkersID = new List<int>();

            foreach(ActiveProjects Proj in Projects)
            {
                WorkersID.Add(Proj.coWorkerID);
            }

            List<DataBase_Logic.CoWorkers> Result = new List<DataBase_Logic.CoWorkers>();

            for(int i=0;i<WorkersID.Count;i++)
            {
                Result.Add(DbContext.CoWorkers.Where(W => W.Id == WorkersID[i]).First());
            }

            DbContext.Connection.Close();
            return Result;
        }

        
    }
}