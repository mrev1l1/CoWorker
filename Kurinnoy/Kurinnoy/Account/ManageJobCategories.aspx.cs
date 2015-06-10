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
using System.Web.UI;
using Kurinnoy.DataBase_Logic;
using System.Configuration;

namespace Kurinnoy.Account
{
    public partial class ManageJobCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateCategoriesButton_Click(object sender, EventArgs e)
        {
            foreach(ListItem Item in jobCategoriesSelect.Items)	
            {
                if(Item.Selected){
                    AddSpecialization(Item.Value);
                }
            }
        }

        void AddSpecialization(String specializationToAdd)
        {
            String CurrentCoWorkerEmail = Context.User.Identity.GetUserName();

            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            DeleteOldSpecializations(DbContext);

            var CurrentWorker = DbContext.CoWorkers.Where(Worker => Worker.email.Equals(CurrentCoWorkerEmail));
            var SelectedSpecialization = DbContext.JobCategories.Where(Category => Category.categoryName.Equals(specializationToAdd));

            CoWorkerSpecializations NewSpecialization = new DataBase_Logic.CoWorkerSpecializations();

            NewSpecialization.categoryID = SelectedSpecialization.First().Id;
            NewSpecialization.coWorkerID = CurrentWorker.First().Id;

            DbContext.CoWorkerSpecializations.InsertOnSubmit(NewSpecialization);
            DbContext.SubmitChanges();
            DbContext.Connection.Close();
        }

        void DeleteOldSpecializations(CoWorkerStaffHandlersDataContext dbContext)
        {
            var Worker = dbContext.CoWorkers.Where(W => W.email.Equals(Context.User.Identity.GetUserName()));

            var OldSpecializations = dbContext.CoWorkerSpecializations.Where(Spec => Spec.coWorkerID == Worker.First().Id);

            foreach (CoWorkerSpecializations Spec in OldSpecializations)
            {
                dbContext.CoWorkerSpecializations.DeleteOnSubmit(Spec);
            }

            dbContext.SubmitChanges();
        }
    }
}