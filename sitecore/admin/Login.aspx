﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Sitecore.Admin.Login" %>
<%@ Import Namespace="Sitecore.Globalization" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>Sitecore Login</title>
  <link rel="shortcut icon" href="/sitecore/images/favicon.ico" />
  <sc:PlatformFontStylesLink runat="server"/>
  <link rel="Stylesheet" type="text/css" href="/sitecore/shell/themes/standard/default/WebFramework.css" />
  
  <script type="text/javascript" src="/sitecore/shell/controls/lib/jQuery/jquery.js"></script>
  <script type="text/javascript" src="/sitecore/shell/controls/lib/jQuery/jquery.watermark.js"></script>
  <script type="text/javascript" src="/sitecore/shell/controls/webframework/webframework.js"></script>
  
  <style type="text/css">
    .login-form { margin-top: 2em; }
    .wf-content input { width: 300px; display: block; margin-bottom: 4px; }
    p.error { margin-top: 2em; }
    p.error span { background: #C10100; color: white; padding: 2px 4px; }
    .external-signin { padding-left: 100px;}
  </style>
</head>
<body>
  <form runat="server" class="wf-container" id="LoginForm">
      <div class="wf-content">
        <h1>Log into Sitecore</h1>
        
        <asp:PlaceHolder ID="ErrorMessage" runat="server" />
        
        <div class="login-form">
          <asp:TextBox ID="LoginTextBox" CssClass="wf-watermarked" ToolTip="Login" runat="server" Text="sitecore\admin" /> 
          <asp:TextBox ID="PasswordTextBox" CssClass="wf-watermarked" ToolTip="Password" TextMode="Password" runat="server" /> 
        </div>
      </div>
    
    <div class="wf-footer">
      <asp:Button runat="server" Text="Log in" OnClick="LoginClick" />
    </div>

    <div class="external-signin">
      <asp:Repeater ID="ExternalSignInLinks" runat="server">
        <ItemTemplate>
          <p>
            <asp:Button CssClass='<%# "btn btn-default btn-block " + this.Eval("IdentityProvider") %>' PostBackUrl='<%# this.Eval("Href") %>'
              Text='<%# Translate.Text((string) this.Eval("Caption")) %>' runat="server" />
          </p>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </form>
</body>
</html>
