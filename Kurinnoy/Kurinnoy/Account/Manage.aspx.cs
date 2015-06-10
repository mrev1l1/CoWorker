using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
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
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
            
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        public String GetAdditionalInfo()
        {
            String Result = "";
            String EmailToCompare;
            String UserEmail = Context.User.Identity.GetUserName(); 
            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var CoWorkers = DbContext.CoWorkers;

            foreach(var Worker in CoWorkers)
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

        protected void Page_Load()
        {
            JobCategoriesSource.SelectParameters.Add("email", Context.User.Identity.GetUserName());

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            HasPhoneNumber = String.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));

            // Включите после настройки двухфакторной проверки подлинности
            //PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;

            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());

            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            if (!IsPostBack)
            {
                // Определите разделы для отображения
                if (HasPassword(manager))
                {
                    ChangePassword.Visible = true;
                }
                else
                {
                    CreatePassword.Visible = true;
                    ChangePassword.Visible = false;
                }

                // Отобразить сообщение об успехе
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Извлечь строку запроса из действия
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Пароль изменен."
                        : message == "SetPwdSuccess" ? "Пароль задан."
                        : message == "RemoveLoginSuccess" ? "Учетная запись удалена."
                        : message == "AddPhoneNumberSuccess" ? "Номер телефона добавлен"
                        : message == "RemovePhoneNumberSuccess" ? "Номер телефона удален"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }
        }


        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        // Удаление номера телефона пользователя
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
            }
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);

            Response.Redirect("/Account/Manage");
        }

        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);

            Response.Redirect("/Account/Manage");
        }
    }
}