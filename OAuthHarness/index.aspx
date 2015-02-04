<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Tavisca.Vexiere.oAuthHarness.index" ValidateRequest="false" %>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="/services.js">
   
</script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>oAuth Harness</title>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
    <style type="text/css">
        /* GitHub stylesheet for MarkdownPad (http://markdownpad.com) */
        /* Author: Nicolas Hery - http://nicolashery.com */
        /* Version: b13fe65ca28d2e568c6ed5d7f06581183df8f2ff */
        /* Source: https://github.com/nicolahery/markdownpad-github */

        /* RESET
=============================================================================*/

        html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
        }

        /* BODY
=============================================================================*/
        html {
            min-height: 100%;
            height: 100%;
        }

        .main {
            width: 980px;
            margin-left: auto;
            margin-right: auto;
        }

        .wrapper {
            padding-bottom: 70px;
            clear: both;
        }

        .site-footer, .page-wrap:after {
        }

        .site-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px 0px;
            background-color: #333;
            color: #FFF;
            font-size: 12px;
            font-family: 'Open Sans';
        }

        .wrapper:after {
            content: "";
            display: block;
        }


        body {
            font-family: 'Open Sans';
            font-size: 14px;
            line-height: 1.6;
            color: #333;
            background-color: #fff;
            margin: 0 auto;
            min-height: 100%;
            position: relative;
        }

            body > *:first-child {
                margin-top: 0 !important;
            }

            body > *:last-child {
                margin-bottom: 0 !important;
            }

        /* BLOCKS
=============================================================================*/

        p, blockquote, ul, ol, dl, table, pre {
            margin: 15px 0;
        }

        /* HEADERS
=============================================================================*/

        h1, h2, h3, h4, h5, h6 {
            margin: 20px 0 10px;
            padding: 0;
            font-weight: 300;
            -webkit-font-smoothing: antialiased;
        }

            h1 tt, h1 code, h2 tt, h2 code, h3 tt, h3 code, h4 tt, h4 code, h5 tt, h5 code, h6 tt, h6 code {
                font-size: inherit;
            }

        h1 {
            font-size: 28px;
            color: #000;
        }

        h2 {
            font-size: 24px;
            border-bottom: 1px solid #ccc;
            color: #000;
        }

        h3 {
            font-size: 18px;
        }

        h4 {
            font-size: 16px;
        }

        h5 {
            font-size: 14px;
        }

        h6 {
            color: #777;
            font-size: 14px;
        }

        body > h2:first-child, body > h1:first-child, body > h1:first-child + h2, body > h3:first-child, body > h4:first-child, body > h5:first-child, body > h6:first-child {
            margin-top: 0;
            padding-top: 0;
        }

        a:first-child h1, a:first-child h2, a:first-child h3, a:first-child h4, a:first-child h5, a:first-child h6 {
            margin-top: 0;
            padding-top: 0;
        }

        h1 + p, h2 + p, h3 + p, h4 + p, h5 + p, h6 + p {
            margin-top: 10px;
        }

        /* LINKS
=============================================================================*/

        a {
            color: #4183C4;
            text-decoration: none;
        }

            a:hover {
                text-decoration: underline;
            }

        /* LISTS
=============================================================================*/

        ul, ol {
            padding-left: 30px;
        }

            ul li > :first-child,
            ol li > :first-child,
            ul li ul:first-of-type,
            ol li ol:first-of-type,
            ul li ol:first-of-type,
            ol li ul:first-of-type {
                margin-top: 0px;
            }

            ul ul, ul ol, ol ol, ol ul {
                margin-bottom: 0;
            }

        dl {
            padding: 0;
        }

            dl dt {
                font-size: 14px;
                font-weight: 300;
                font-style: italic;
                padding: 0;
                margin: 15px 0 5px;
            }

                dl dt:first-child {
                    padding: 0;
                }

                dl dt > :first-child {
                    margin-top: 0px;
                }

                dl dt > :last-child {
                    margin-bottom: 0px;
                }

            dl dd {
                margin: 0 0 15px;
                padding: 0 15px;
            }

                dl dd > :first-child {
                    margin-top: 0px;
                }

                dl dd > :last-child {
                    margin-bottom: 0px;
                }

        /* CODE
=============================================================================*/

        pre, code, tt {
            font-size: 12px;
            font-family: Consolas, "Liberation Mono", Courier, monospace;
        }

        code, tt {
            margin: 0 0px;
            padding: 0px 0px;
            white-space: nowrap;
            border: 1px solid #eaeaea;
            background-color: #f8f8f8;
            border-radius: 3px;
        }

        pre > code {
            margin: 0;
            padding: 0;
            white-space: pre;
            border: none;
            background: transparent;
        }

        pre {
            background-color: #f8f8f8;
            border: 1px solid #ccc;
            font-size: 13px;
            line-height: 19px;
            overflow: auto;
            padding: 6px 10px;
            border-radius: 3px;
        }

            pre code, pre tt {
                background-color: transparent;
                border: none;
            }

        kbd {
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            -moz-border-right-colors: none;
            -moz-border-top-colors: none;
            background-color: #DDDDDD;
            background-image: linear-gradient(#F1F1F1, #DDDDDD);
            background-repeat: repeat-x;
            border-color: #DDDDDD #CCCCCC #CCCCCC #DDDDDD;
            border-image: none;
            border-radius: 2px 2px 2px 2px;
            border-style: solid;
            border-width: 1px;
            font-family: 'Open Sans';
            line-height: 10px;
            padding: 1px 4px;
        }

        /* QUOTES
=============================================================================*/

        blockquote {
            border-left: 4px solid #DDD;
            padding: 0 15px;
            color: #777;
        }

            blockquote > :first-child {
                margin-top: 0px;
            }

            blockquote > :last-child {
                margin-bottom: 0px;
            }

        /* HORIZONTAL RULES
=============================================================================*/

        hr {
            clear: both;
            margin: 15px 0;
            height: 0px;
            overflow: hidden;
            border: none;
            background: transparent;
            border-bottom: 4px solid #ddd;
            padding: 0;
        }

        /* TABLES
=============================================================================*/

        table th {
            font-weight: 300;
        }

        table th, table td {
            /*border-bottom: 1px solid #ccc;*/
            padding: 6px 13px;
        }

        table tr {
            border-top: 1px solid #ccc;
            background-color: #fff;
        }

        /* IMAGES
=============================================================================*/

        img {
            max-width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">


        <div id="header" style="padding: 15px 20px; background-color: #333; color: #FFF; font-size: 14px;">
            <div class="main">
                <a href="https://dev-vexiere.tavisca.com/Vexiere3.0/Apis/docs/business/index.html">
                    <img src="Images/vex-logo.png" alt="Vexiere APIs" height="32" style="float: left;">
                </a>
                <div id="headerTitle" style="padding-left: 150px; padding-top: 2px; font-size: 18px; font-family: 'Open Sans';">API Documentation</div>
                <div style="clear: both;"></div>
            </div>
        </div>

        <div class="main wrapper">





            <div>
                <table align="center">
                    <tr>
                        <td>
                            <h1>OAuth Test Harness</h1>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblSvc" runat="server" Text="Select Action : " Font-Bold="True"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddlFlow" AutoPostBack="true" runat="server" Height="35px" TabIndex="1" OnSelectedIndexChanged="ddlFlow_SelectedIndexChanged">
                                <asp:ListItem>AuthorizeCodeFlow</asp:ListItem>
                                <asp:ListItem>GetAccessTokenByCode</asp:ListItem>
                                <asp:ListItem>ImplicitFlow</asp:ListItem>
                                <asp:ListItem>ClientCredentialsFlow</asp:ListItem>
                                <asp:ListItem>ResourceOwnerFlow</asp:ListItem>
                                <asp:ListItem>GetUserInfoByAccessToken</asp:ListItem>
                                <asp:ListItem>GetAccessTokenByRefreshToken</asp:ListItem>
                                <asp:ListItem>RevokeToken</asp:ListItem>
                                <asp:ListItem>EndSession</asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblOperation" runat="server" Text="Endpoint : " Font-Bold="True"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddlEndpoint" AutoPostBack="true" runat="server" Height="28px" TabIndex="1" OnSelectedIndexChanged="ddlEndpoint_SelectedIndexChanged" Enabled="False">
                                <asp:ListItem>Token</asp:ListItem>
                                <asp:ListItem>UserInfo</asp:ListItem>
                                <asp:ListItem>RevokeToken</asp:ListItem>
                                <asp:ListItem>Authorize</asp:ListItem>
                                <asp:ListItem>EndSession</asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <br />
                    <tr>
                        <td>
                            <asp:Label ID="lblUrl" runat="server" Text="Endpoint Url  : " Font-Bold="True"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="tbUrl" runat="server" Width="652px" TextMode="Url" Height="34px"></asp:TextBox></td>
                    </tr>
                </table>
            </div>
            <br />
            &nbsp;Basic Auth :<br />

            <div>
                <table border="1">
                    <tr>
                        <td>
                            <asp:Label ID="Label123" runat="server" Text="ClientId (OrganizationId):-"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="ClinetIdTextBox" runat="server" Width="33px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label124" runat="server" Text="ClientSecret (APIKey):-" Font-Bold="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="ClientSecretTextBox" runat="server" Width="385px"></asp:TextBox>
                        </td>

                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td />
                        <td />
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="GenerateEncodedHeader" runat="server" Height="23px" Style="margin-top: 0px" Text="GenerateEncodedAuthorizationHeader" OnClick="GenerateEncodedHeader_Click" Width="256px" />
                        </td>
                        <td>
                            <asp:TextBox ID="EncodedAuthorizationHeaderTextBox" runat="server" Width="417px" Height="52px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>

            <br />
            <br />
            <div style="float: left">
                <asp:Label ID="lblHeader" runat="server" Text="Request Header:" Font-Bold="True"></asp:Label>
                <br />
                <br />
                <asp:TextBox ID="tbRequestHeader" runat="server" Height="69px" Style="margin-left: 0px; margin-top: 0px;" TextMode="MultiLine" Width="1000px"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblBody" runat="server" Text="Request Body:" Font-Bold="True"></asp:Label><br />
                <br />
                <asp:TextBox ID="tbRequestXml" runat="server" Height="298px" Style="margin-left: 0px" TextMode="MultiLine" Width="1000px"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;
                <br />
            <asp:Button ID="Button1" runat="server" Height="23px" Style="margin-top: 0px" Text="Submit" Width="73px" OnClick="btnPost_Click" />
            <asp:Button ID="Clear" runat="server" Height="23px" Style="margin-top: 0px" Text="Clear" Width="73px" OnClick="Clear_Click" />
                <br />
            </div>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Response:" Font-Bold="True"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbResponseXml" runat="server" Height="391px" Style="margin-top: 0px;" TextMode="MultiLine" Width="1000px"></asp:TextBox>

            <br />
            <br />
            <br />
            Please refer help document <a href="HelperDoc.html" target="_blank">Here</a>

        </div>
        <div id="footer" align="center" class="site-footer">© 2015 Tavisca Solutions Pvt. Ltd.</div>
    </form>
</body>
</html>
