using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Web.Http;


namespace Kurinnoy.Client_API
{
    public class ImageHandler : IHttpHandler
    {
        public void ProcessRequest(System.Web.HttpContext context)
        {
            String Path = context.Request.Params["path"];

            WebRequest req = WebRequest.Create(Path);
            WebResponse response = req.GetResponse();
            Stream stream = response.GetResponseStream();
            MemoryStream mempryStream = new MemoryStream();
            stream.CopyTo(mempryStream);
            System.Drawing.Image img = System.Drawing.Image.FromStream(stream);
            context.Response.OutputStream.Write(mempryStream.ToArray(), 0, mempryStream.ToArray().Length);
            context.Response.End();
            
            stream.Close();

        }

        public bool IsReusable
        {
            get
            {
                return true;
            }
        }

    }
}