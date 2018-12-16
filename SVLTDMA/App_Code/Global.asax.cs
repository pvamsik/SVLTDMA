using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.Unity;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration.Unity;
using Microsoft.Practices.EnterpriseLibrary.Data.Configuration.Unity;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;


/// <summary>
/// Summary description for Global
/// </summary>
public class Global : System.Web.HttpApplication, IContainerAccessor
{
    private static IUnityContainer _container;

    public static IUnityContainer Container
    {
        get
        {
            return _container;
        }
        set
        {
            _container = value;
        }
    }

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        BuildContainer();

        // Load Common Data
        Data data = new Data();

        lock (_container)
        {
            data.DB = _container.Resolve<Database>();
        }
    }

    private static void BuildContainer()
    {
        IUnityContainer container = new UnityContainer();
        container.AddNewExtension<EnterpriseLibraryCoreExtension>();
        //container.AddNewExtension<DataAccessBlockExtension>();
        Container = container;
    }

    private static void CleanUp()
    {
        if (Container != null)
        {
            Container.Dispose();
        }
    }

    void Application_End(object sender, EventArgs e)
    {
        CleanUp();
    }

    void Application_Error(object sender, EventArgs e)
    {

    }

    void Session_Start(object sender, EventArgs e)
    {
    }

    void Session_End(object sender, EventArgs e)
    {
    }

    #region IContainerAccessor Members
    IUnityContainer IContainerAccessor.Container
    {
        get
        {
            return Container;
        }
    }
    #endregion
}