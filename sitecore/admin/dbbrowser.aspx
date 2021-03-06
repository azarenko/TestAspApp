<%@ Page CodePage="65001" language="c#" Codebehind="dbbrowser.aspx.cs" AutoEventWireup="false" EnableViewState="false" Inherits="Sitecore.Admin.DBBrowser.DBBrowserPage" %>
<!DOCTYPE html>
<html>
  <head runat="server">
    <title>DB Browser</title>
    <link rel="shortcut icon" href="/sitecore/images/favicon.ico" />
    <sc:PlatformFontStylesLink runat="server"/>
    <link href="/sitecore/admin/dbbrowser.css" rel="stylesheet">
  </head>
  <body>
    <form id="Form1" method="post" runat="server" onsubmit="return confirm('Are you sure?');">
      <div class="scStretch">
        <div class="header">
          <div class="caption">
            DB Browser
          </div>
          <div id="dataBases" class="dataBases caption" runat="server" />
        </div>
        <div class="content">
          <div id="tree" class="tree" runat="server"></div><!--
       --><div id="contentEditor" class="contentEditor" runat="server"></div>
        </div>
      </div>
    </form>
  </body>
</html>
