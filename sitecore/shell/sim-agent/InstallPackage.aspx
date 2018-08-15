
<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Sitecore.Configuration" %>
<%@ Import Namespace="Sitecore.Data.Engines" %>
<%@ Import Namespace="Sitecore.Data.Proxies" %>
<%@ Import Namespace="Sitecore.Diagnostics" %>
<%@ Import Namespace="Sitecore.Install" %>
<%@ Import Namespace="Sitecore.Install.Files" %>
<%@ Import Namespace="Sitecore.Install.Framework" %>
<%@ Import Namespace="Sitecore.Install.Items" %>
<%@ Import Namespace="Sitecore.Install.Utils" %>
<%@ Import Namespace="Sitecore.SecurityModel" %>
<%@ Import Namespace="Sitecore.Security.Accounts" %>

<script runat="server">

#region Methods

  protected override void OnInitComplete(EventArgs e)
  {
	  this.Server.ScriptTimeout = 10*60*60; // 10 hours should be enough
    var fileName = this.Request.QueryString["fileName"];
    if (string.IsNullOrEmpty(fileName))
    {
      this.Finish("Error: fileName is empty");
      return;
    }

    var filePath = GetFilePath(fileName);
    if (!File.Exists(filePath))
    {
      this.Finish("Error: the '" + filePath + "' file doesn't exists");
      return;
    }

    try
    {
      Sitecore.Context.SetActiveSite("shell");
      using (new UserSwitcher("sitecore\\admin", true))
      {
        using (new ProxyDisabler())
        {
          using (new SyncOperationContext())
          {
            SimpleProcessingContext context = new SimpleProcessingContext();
            DefaultItemInstallerEvents events = new DefaultItemInstallerEvents(new BehaviourOptions(InstallMode.Overwrite, MergeMode.Undefined));
            context.AddAspect(events);
            DefaultFileInstallerEvents events1 = new DefaultFileInstallerEvents(true);
            context.AddAspect(events1);
            this.UpdateStatus(@"Started: package is being installed");
            new Installer().InstallPackage(filePath, context);
            new Installer().InstallSecurity(filePath, context);
            this.Finish(@"Done: package installed");
          }
        }
      }
    }
    catch (Exception ex)
    {
      var inn = string.Empty;
      if (ex.InnerException != null)
      {
        inn = "\n\nInner Exception:\n" + ex.InnerException;
      }

      this.Finish(@"Error: " + ex + inn);
    }
  }

  private void Finish(string message)
  {
    Log.Info(@"[SIM] InstallPackage.aspx: " + message, this);
    this.UpdateStatus(message);
    this.Response.Write(message);
  }

  private void UpdateStatus(string message)
  {
    var installedTemp = this.Server.MapPath(Path.Combine(Settings.TempFolderPath, "sim.status"));
    File.WriteAllText(installedTemp, message);
  }

  private string GetFilePath(string name)
  {
    Assert.ArgumentNotNullOrEmpty(name, "name");

    var packageFolderPath = Sitecore.Configuration.Settings.PackagePath;
    Assert.IsNotNullOrEmpty(packageFolderPath, "packageFolderPath");

    // if path is virtual i.e. not C:\something then do a map path
    if (packageFolderPath.Length < 2 || packageFolderPath[1] != ':')
    {
      packageFolderPath = packageFolderPath.TrimStart('/');
      var prefix = "~/";
      if (packageFolderPath.StartsWith(prefix))
      {
        packageFolderPath = packageFolderPath.Substring(prefix.Length);
      }

      packageFolderPath = Server.MapPath(prefix + packageFolderPath);
    }
      
    return Path.Combine(packageFolderPath, name);      
  }

#endregion

</script>