using Kurinnoy.DataBase_Logic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Kurinnoy.Client_API
{
    public class CoWorkersController : ApiController
    {
        // GET api/<controller>
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        // GET api/<controller>/5
        [HttpGet]
        public void FindCoworkers(String projectContainer)
        {
            String[] ProjectParameters = projectContainer.Split(new String[] { ";" }, StringSplitOptions.RemoveEmptyEntries);

            CoWorkerStaffHandlersDataContext DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);
            Int32 Category = Convert.ToInt32(ProjectParameters[4]);
            Int32 WorkersQuantity = Convert.ToInt32(ProjectParameters[1]);
            Int32 Price = Convert.ToInt32(ProjectParameters[2]);
            String ProjectInfo = ProjectParameters[3];
            String ClientContacts = ProjectParameters[0];

            DbContext.FindCoWorkersForProjectByCategory(Category, WorkersQuantity, Price, ProjectInfo, ClientContacts);
            DbContext.Connection.Close();
        }

        //// POST api/<controller>
        //public void Post([FromBody]string value)
        //{
        //}

        //// PUT api/<controller>/5
        //public void Put(int id, [FromBody]string value)
        //{
        //}

        //// DELETE api/<controller>/5
        //public void Delete(int id)
        //{
        //}
    }
}