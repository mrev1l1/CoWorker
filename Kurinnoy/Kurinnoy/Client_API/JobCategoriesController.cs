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
    public class JobCategoriesController : ApiController
    {
        private CoWorkerStaffHandlersDataContext DbContext;

        // GET api/<controller>
        public IEnumerable<JobCategories> GetJobCategories()
        {
            DbContext = new CoWorkerStaffHandlersDataContext(ConfigurationManager.ConnectionStrings["CoWorkerStaffConnectionString"].ConnectionString);

            var Categories = DbContext.JobCategories;

            DbContext.Connection.Close();

            return Categories;
        }

        //// GET api/<controller>/5
        //public string Get(int id)
        //{
        //    return "value";
        //}

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