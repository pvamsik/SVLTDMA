using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ManageTemple.Startup))]
namespace ManageTemple
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
