<%@ outputcache location="None" varybyparam="none" %>

<%@ page language="c#" codebehind="noaccess.aspx.cs" enableviewstate="false" autoeventwireup="True" inherits="SitecoreClient.Page.NoAccess" %>

<%@ import namespace="Sitecore.Configuration" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <title>Access Denied</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <sc:PlatformFontStylesLink runat="server"/>
  <link href="/sitecore/shell/client/Speak/Assets/css/speak-default-theme.css" rel="stylesheet" />
  <style>
    .sc-text-label {
      white-space: nowrap;
      width: 1%;
    }
  </style>
</head>
<body class="sc">
    <div class="sc-task">
        <header class="sc-globalHeader">
            <div class="row sc-globalHeader-content">
                <div class="col-md-3">
                    <div class="sc-globalHeader-startButton">
                        <a class="sc-global-logo medium" title="Go to the start page" href="/"></a>
                    </div>
                </div>
            </div>
        </header>

        <header class="sc-applicationHeader">
            <div class="sc-applicationHeader-row1">
                <div class="sc-applicationHeader-content">
                    <div class="sc-applicationHeader-title">
                        Permission to the requested document was denied
                    </div>
                </div>
            </div>
        </header>

        <section class="sc-dialogContent-toolbar">
            <div class="container">
                <div class="row sc-dialogContent-toolbar-back">
                    <button class="btn sc-backbutton" type="button" onclick="javascript:history.go(-1);"><span class="sc-backbutton-text">Back</span></button>
                </div>
            </div>
        </section>

        <section class="sc-applicationContent">
            <div class="col-md-12 sc-applicationContent-main">
                <h3>Most likely causes:
                </h3>

                <ul>
                    <li>
                        <asp:placeholder id="LikelyCause" runat="server" />
                    </li>
                </ul>

                <div runat="server" id="SuggestedActions">
                    <h3>What you can try:
                    </h3>

                    <ul>
                        <li>
                            <asp:hyperlink id="LoginPageLink"
                                navigateurl="#"
                                text="Go to Login Page"
                                runat="server" />
                    </ul>
                </div>
                <br />

                <h4>Additional Information:
                </h4>

                <table class="table">
                    <tr>
                        <td class="sc-text sc-text-label">Requested URL:</td>
                        <td class="sc-text sc-text-value">
                            <asp:placeholder id="RequestedUrl" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="sc-text sc-text-label">User name:</td>
                        <td class="sc-text sc-text-value">
                            <asp:placeholder id="UserName" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="sc-text sc-text-label">Site name:</td>
                        <td class="sc-text sc-text-value">
                            <asp:placeholder id="SiteName" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="sc-text sc-text-label">Right name:</td>
                        <td class="sc-text sc-text-value">
                            <asp:placeholder id="RightName" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </section>
    </div>
  <sc:VisitorIdentification runat='server'/> 
 </body>
</html>
