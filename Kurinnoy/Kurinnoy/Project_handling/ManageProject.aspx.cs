using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using Kurinnoy.Models;
using System.Data;
using System.Web.UI;
using Kurinnoy.DataBase_Logic;
using System.Configuration;
using System.IO;
using System.Text;

namespace Kurinnoy.Project_handling
{
    public partial class ManageProject : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DeleteImage_Click(object sender, EventArgs e)
        {
            int aaa = 0;
            aaa++;
        }

        protected void ShowInfoButton_Click(object sender, EventArgs e)
        {
            var ProjectId = ProjectIdInput.Value;

            ShowProjectInformation(Convert.ToString(ProjectId));

            ShowReadiness(Convert.ToInt32(ProjectId));

            //ShowProjectImages(Convert.ToString(ProjectId));

            //ShowProgressBar(Convert.ToInt32(ProjectId));

            //ShowPaymentButton(Convert.ToInt32(ProjectId));
        }

        void ShowProjectInformation(String projectId)
        {
            StreamReader FileReader = null;

            FileReader = File.OpenText(@"D:\\Microsoft Visual Studio 2013\\Kurinnoy\\Kurinnoy\\App_Data\\project" + projectId + '\\' + projectId + ".txt");

            //if (!IsPostBack)
            projectInformationTextBox.Text = FileReader.ReadToEnd();

            FileReader.Close();
        }

        List<DataBase_Logic.CoWorkers> GetWorkersForProject(int projectID)
        {
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var Projects = DbContext.ActiveProjects.Where(ActiveProject => ActiveProject.projectID == projectID);

            List<int> WorkersID = new List<int>();

            foreach (ActiveProjects Proj in Projects)
            {
                WorkersID.Add(Proj.coWorkerID);
            }

            List<DataBase_Logic.CoWorkers> Result = new List<DataBase_Logic.CoWorkers>();

            for (int i = 0; i < WorkersID.Count; i++)
            {
                Result.Add(DbContext.CoWorkers.Where(W => W.Id == WorkersID[i]).First());
            }

            DbContext.Connection.Close();
            return Result;
        }

        protected void UpdateInformationButton_Click(object sender, EventArgs e)
        {
            String UpdatedInfo = projectInformationTextBox.Text;
            String CurrentProjectID = Convert.ToString(ProjectIdInput.Value);

            File.WriteAllText(@"D:\\Microsoft Visual Studio 2013\\Kurinnoy\\Kurinnoy\\App_Data\\project" + CurrentProjectID + '\\' + CurrentProjectID + ".txt", UpdatedInfo);
        }

        protected void uploadsButton_Click(object sender, EventArgs e)
        {
            String CurrentProjectID = Convert.ToString(ProjectIdInput.Value);

            if (imagesUpload.HasFile)
            {
                try
                {
                    string Filename = Path.GetFileName(imagesUpload.FileName);
                    imagesUpload.SaveAs(Server.MapPath("~/App_Data/project" + CurrentProjectID + '/') + Filename);
                    statusLabel.Text = "Upload status: File uploaded!";
                }
                catch (Exception ex)
                {
                    statusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
        }

        void ShowReadiness(int projectID)
        {
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var Project = DbContext.ActiveProjects.Where(Proj => Proj.projectID == projectID).First();


            projectReadinessBox.Text = Project.readiness.ToString();
        }
    }
}