using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(vhcbcloud.Startup))]
namespace vhcbcloud
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
