using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Kurinnoy.Startup))]
namespace Kurinnoy
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
