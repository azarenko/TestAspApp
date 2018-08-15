<%@Application Language='C#' Inherits="Sitecore.Web.Application" %>

<%-- WARNING: Every custom application must derive from the Sitecore.Web.Application class. Otherwise some Sitecore features will not be available or will not work correctly. --%> 

            
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Security" %>

<script runat="server">

  public void Application_Start()
  {
    ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(delegate { return true; });
  }
  
</script>
          