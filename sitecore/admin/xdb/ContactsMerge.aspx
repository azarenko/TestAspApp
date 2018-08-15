<%@ Page Async="true" Language="C#" AutoEventWireup="true" CodeBehind="ContactsMerge.aspx.cs" Inherits="Sitecore.Xdb.Processing.ContactMerge.UI.Admin.xdb.ContactsMerge" %>

<html>
<head runat="server">
    <title>Contacts Merge Data Update.</title>
    <link rel="shortcut icon" href="/sitecore/images/favicon.ico" />
    <link rel="Stylesheet" type="text/css" href="/sitecore/shell/themes/standard/default/WebFramework.css" />
    <style type="text/css">
        .wf-container {
            display: inline-block;
            min-width: 950px;
        } 

        .wf-content {
            padding: 2em 2em;
        }

        #wf-dropshadow-right {
            display: none;
        }

        table {
            width: 100%;
            max-width: 950px;
        }

            table.main {
                border: 1px solid #ccc;
                border-collapse: collapse;
                font-family: Tahoma;
                font-size: 14pt;
                padding: 1em 1em;
            }

                table.main td {
                    border: 1px solid #ccc;
                    font-family: Tahoma;
                    font-size: 14pt;
                    padding: 5px;
                }

                table.main th {
                    border: 1px solid #ccc;
                    font-family: Tahoma;
                    font-size: 14pt;
                    font-weight: normal;
                    padding: 5px;
                    text-align: center;
                }

        .wf-configsection table th {
            background-color: #ccc;
        }

        td.datacell {
            text-align: right;
            white-space: nowrap;
        }

        table.main th.dataheader {
            text-align: center;
        }

        tr.groupheader {
            background-color: #bbb;
        } 

        .top1 {
            background-image: url(/sitecore/shell/themes/Standard/Images/PipelineProfiling/font_char49_red_16.png);
            background-position: 5px 5px;
            background-repeat: no-repeat;
        }

        .top2 {
            background-image: url(/sitecore/shell/themes/Standard/Images/PipelineProfiling/font_char50_orange_16.png);
            background-position: 5px 5px;
            background-repeat: no-repeat;
        }

        .top3 {
            background-image: url(/sitecore/shell/themes/Standard/Images/PipelineProfiling/font_char51_yellow_16.png);
            background-position: 5px 5px;
            background-repeat: no-repeat;
        }

        table.main td.processor {
            padding-left: 30px;
        }
    </style>
</head>
<body>
    <form id="mainForm" runat="server" class="wf-container">
        <div class="wf-content">
            <h1>Contacts Merge Data Update.</h1>
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <asp:Timer ID="ProgressTimer" Interval="1000" runat="server" OnTick="ProgressTimer_Tick"></asp:Timer>

            <p />
            <p />
            <p />
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Label runat="server" ID="TimeSliceErrorLabel" ForeColor="red" Visible="false"></asp:Label>
                    <p />
                    <asp:Button runat="server" ID="StartButton" OnClick="StartClick" Text="Start" />
                    <asp:Button runat="server" ID="CancelButton" OnClick="CancelClick" Text="Cancel" />
                    <p />
                    <asp:Label runat="server" ID="ErrorStringMsg" ForeColor="red"></asp:Label>
                    <p />
                    <p />

                    <asp:Table ID="TableOverallStatus" runat="server">
                        <asp:TableHeaderRow ID="TableHeaderOverallStatus" runat="server">
                            <asp:TableHeaderCell style="min-width: 250px;" ID="TableHeaderCellOverallStatus" runat="server" HorizontalAlign="Left">
                    Overall Status
                            </asp:TableHeaderCell>
                        </asp:TableHeaderRow>

                        <asp:TableRow ID="TableRowOverallState" runat="server">
                            <asp:TableCell ID="TableCellOverallStateKey" runat="server">
                    Process State:
                            </asp:TableCell>
                            <asp:TableCell ID="TableCellOverallStateValue" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="ProcesStateLabel" />
                            </asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow ID="TableRowError" runat="server">
                            <asp:TableCell ID="TableCell1" runat="server">
                    Last stored error:
                            </asp:TableCell>
                            <asp:TableCell ID="TableCell2" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="ErrorLabel" />
                            </asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow ID="TableRowIsActive" runat="server" Visible="true">
                            <asp:TableCell ID="TableCellIsActiveKey" runat="server">
                    Is Active:
                            </asp:TableCell>
                            <asp:TableCell ID="TableCellIsActiveValue" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="IsActiveLabel" />
                            </asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow ID="TableRow1" runat="server" Visible="true">
                            <asp:TableCell ID="TableCell3" runat="server">
                    Progress:
                            </asp:TableCell>
                            <asp:TableCell ID="TableCell4" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="ProgressLabel" />
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow ID="TableRow2" runat="server" Visible="true">
                            <asp:TableCell ID="TableCell5" runat="server">
                    Total:
                            </asp:TableCell>
                            <asp:TableCell ID="TableCell6" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="TotalLabel" />
                            </asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow ID="TableRow3" runat="server" Visible="true">
                            <asp:TableCell ID="TableCell7" runat="server">
                    Processed:
                            </asp:TableCell>
                            <asp:TableCell ID="TableCell8" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="ProcessedLabel" />
                            </asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow ID="TableRowStartedAt" runat="server">
                            <asp:TableCell ID="TableCellStartedAtKey" runat="server">
                    Started at (Server Time):
                            </asp:TableCell>
                            <asp:TableCell ID="TableCellStartedAtValue" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="StartedAtLabel" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="TableRowFinishedAt" runat="server">
                            <asp:TableCell ID="TableCellFinishedAtKey" runat="server">
                    Last Process State Change At (Server Time):
                            </asp:TableCell>
                            <asp:TableCell ID="TableCellFinishedAtValue" runat="server" HorizontalAlign="Right">
                                <asp:Label runat="server" ID="LastChangedLabel" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                   
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ProgressTimer"  runat="server" EventName="Tick" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
