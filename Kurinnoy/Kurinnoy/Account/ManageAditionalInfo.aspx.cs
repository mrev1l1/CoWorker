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
using System.Web.UI;
using Kurinnoy.DataBase_Logic;
using System.Configuration;

namespace Kurinnoy.Account
{
    public partial class ManageAditionalInfo : System.Web.UI.Page
    {
        public String GetAdditionalInfo()
        {
            String Result = "";
            String EmailToCompare;
            String UserEmail = Context.User.Identity.GetUserName();
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var CoWorkers = DbContext.CoWorkers;

            foreach (var Worker in CoWorkers)
            {
                EmailToCompare = Worker.email;
                Boolean CmpResult = true;
                for (int i = 0; i < UserEmail.Length; i++)
                    if (!(EmailToCompare[i] == UserEmail[i]))
                    {
                        CmpResult = false;
                        break;
                    }
                if (CmpResult)
                {
                    Result = Worker.additionalInfo;
                    break;
                }
            }

            return Result;
        }

        public int LoginsCount { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CoWorkersInformationTextBox.Text = GetAdditionalInfo();

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;



            //CoWorkersInformationTextArea.InnerText = GetAdditionalInfo();
        }

        void UpdateCurrentCoWorker(String value)
        {
            String UserEmail = Context.User.Identity.GetUserName();
            String EmailToCompare;

            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var test = from CoWorkers in DbContext.CoWorkers where CoWorkers.email == Context.User.Identity.GetUserName() select CoWorkers; 
            
            foreach (CoWorkers Worker in test)
            {
                Worker.additionalInfo = value;
            }

            DbContext.GetChangeSet();
            DbContext.SubmitChanges();

            var CoWorkerss = DbContext.CoWorkers;

            foreach (var Worker in CoWorkerss)
            {
                EmailToCompare = Worker.email;
                Boolean CmpResult = true;
                for (int i = 0; i < UserEmail.Length; i++)
                    if (!(EmailToCompare[i] == UserEmail[i]))
                    {
                        CmpResult = false;
                        break;
                    }
                if (CmpResult)
                {
                    Worker.additionalInfo = value;
                    break;
                }
            }

            DbContext.SubmitChanges();
            DbContext.Connection.Close();
        }

        protected void UpdateInformationButton_Click(object sender, EventArgs e)
        {
            String NewAdditionalInformation = CoWorkersInformationTextBox.Text;//.InnerText;

            UpdateCurrentCoWorker(NewAdditionalInformation);
        }
    }
}