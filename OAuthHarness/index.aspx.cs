using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tavisca.Vexiere.oAuthHarness
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string url = GetEndpointUrl("Authorize");
                tbUrl.Text = url;
                ddlEndpoint.SelectedIndex = 3;
                LoadRequestHeaderAndBody();
                PopulateClinetIdAndSecret();
            }

            var value = this.Request.Params["Id"];
            if (value != null)
            {
                ddlFlow.SelectedIndex = Convert.ToInt32(value);
                LoadValues();
            }
        }

        private void PopulateClinetIdAndSecret()
        {
            string clientId = ConfigurationManager.AppSettings["ClinetId"];
            string clientSecret = ConfigurationManager.AppSettings["ClinetSecret"];
            ClinetIdTextBox.Text = clientId;
            ClientSecretTextBox.Text = clientSecret;
        }

        protected void ddlEndpoint_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadRequestHeaderAndBody();
            var endpointValue = ddlEndpoint.SelectedValue;

            string url = GetEndpointUrl(endpointValue);
            tbUrl.Text = url;
        }

        protected void ddlFlow_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadValues();
        }

        private void LoadValues()
        {
            var flowValue = ddlFlow.SelectedValue;
            var endpointValue = ddlEndpoint.SelectedValue;

            var endpoint = "Token";
            if (flowValue.Equals("GetUserInfoByAccessToken"))
            {
                ddlEndpoint.SelectedIndex = 1;
                endpointValue = ddlEndpoint.SelectedValue;
            }
            else if (flowValue.Equals("RevokeToken"))
            {
                ddlEndpoint.SelectedIndex = 2;
                endpointValue = ddlEndpoint.SelectedValue;
            }
            else if (flowValue.Equals("AuthorizeCodeFlow") || flowValue.Equals("ImplicitFlow"))
            {
                ddlEndpoint.SelectedIndex = 3;
                endpointValue = ddlEndpoint.SelectedValue;
            }
            else if (flowValue.Equals("EndSession"))
            {
                ddlEndpoint.SelectedIndex = 4;
                endpointValue = ddlEndpoint.SelectedValue;
            }
            else
            {
                ddlEndpoint.SelectedIndex = 0;
                endpointValue = ddlEndpoint.SelectedValue;
            }

            string url = GetEndpointUrl(endpointValue);
            tbUrl.Text = url;
            LoadRequestHeaderAndBody();
        }

        public string GetEndpointUrl(string endpointName)
        {
            string keyName = endpointName + "Endpoint";
            return ConfigurationManager.AppSettings[keyName];
        }

        private void LoadRequestHeaderAndBody()
        {
            string header = string.Empty;
            string body = string.Empty;
            var flowValue = ddlFlow.SelectedValue;


            var _textStreamReader = GetTextStream(flowValue);
            var fileContent = _textStreamReader.ReadToEnd().ToString(CultureInfo.CurrentCulture);

            if (!(flowValue.Equals("ImplicitFlow") || flowValue.Equals("AuthorizeCodeFlow") || flowValue.Equals("EndSession")))
            {
                if (!string.IsNullOrEmpty(fileContent))
                {
                    var tokens = fileContent.Split(new string[] { "\r\n\r\n" }, StringSplitOptions.RemoveEmptyEntries);
                    if (tokens.Length >= 2)
                    {
                        header = tokens[0];
                        body = tokens[1];
                    }
                    else if (tokens.Length == 1)
                        header = tokens[0];
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(fileContent))
                {
                    tbUrl.Text = tbUrl.Text + fileContent;
                }
            }

            tbRequestHeader.Text = header;
            tbRequestXml.Text = body;
        }

        private StreamReader GetTextStream(string flowValue)
        {
            var _assembly = Assembly.GetExecutingAssembly();
            if (flowValue.Equals("ClientCredentialsFlow"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.ClientCredentialsFlow.txt"));
            else if (flowValue.Equals("ResourceOwnerFlow"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.ResourceOwnerFlow.txt"));
            else if (flowValue.Equals("GetUserInfoByAccessToken"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.GetUserInfo.txt"));
            else if (flowValue.Equals("GetAccessTokenByRefreshToken"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.GetAccessTokenByRefreshToken.txt"));
            else if (flowValue.Equals("RevokeToken"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.RevokeToken.txt"));
            else if (flowValue.Equals("AuthorizeCodeFlow"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.AuthorizeCodeFlow.txt"));
            else if (flowValue.Equals("ImplicitFlow"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.ImplicitFlow.txt"));
            else if (flowValue.Equals("GetAccessTokenByCode"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.GetAccessTokenByCode.txt"));
            else if (flowValue.Equals("EndSession"))
                return new StreamReader(_assembly.GetManifestResourceStream("Tavisca.Vexiere.oAuthHarness.RequestXmls.EndSession.txt"));

            else
                return null;
        }


        public string SendToServer(string requestBody, string url, List<KeyValuePair<string, string>> headers)
        {
            try
            {
                var flowValue = ddlFlow.SelectedValue;

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                //HttpWebRequest class is used to Make a request to a Uniform Resource Identifier (URI).  
                if (headers != null)
                    foreach (var entry in headers)
                    {
                        try
                        {
                            request.Headers.Add(entry.Key, entry.Value);
                        }
                        catch
                        {
                        }
                    }

                // Set the ContentType property of the WebRequest. 
                request.ContentType = "application/x-www-form-urlencoded";
                request.Method = "POST";
                if (flowValue.Equals("GetUserInfoByAccessToken") || flowValue.Equals("AuthorizeCodeFlow") || flowValue.Equals("ImplicitFlow") || flowValue.Equals("EndSession"))
                    request.Method = "GET";
                if (!string.IsNullOrEmpty(requestBody))
                {
                    byte[] byteArray = Encoding.UTF8.GetBytes(requestBody);
                    // Set the ContentLength property of the WebRequest. 
                    request.ContentLength = byteArray.Length;
                    //Get the stream that holds request data by calling the GetRequestStream method. 
                    Stream dataStream = request.GetRequestStream();
                    // Write the data to the request stream. 
                    dataStream.Write(byteArray, 0, byteArray.Length);
                    // Close the Stream object. 
                    dataStream.Close();
                }
                WebResponse response = request.GetResponse();
                // Get the stream containing content returned by the server.
                //Send the request to the server by calling GetResponse. 
                var dtStream = response.GetResponseStream();
                // Open the stream using a StreamReader for easy access. 
                StreamReader reader = new StreamReader(dtStream);
                // Read the content. 
                string Response = reader.ReadToEnd();
                //return the response 
                return Response;
            }
            catch (Exception ex)
            {
                return "Error Occured ! " + ex.Message;
            }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            List<KeyValuePair<string, string>> headers = GetHeaders();
            tbResponseXml.Text = SendToServer(tbRequestXml.Text.Trim(), tbUrl.Text.Trim(), headers);
        }

        private List<KeyValuePair<string, string>> GetHeaders()
        {
            List<KeyValuePair<string, string>> headers = new List<KeyValuePair<string, string>>();

            string header = tbRequestHeader.Text;
            if (!string.IsNullOrEmpty(header))
            {
                var tokens = header.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
                if (tokens != null)
                {
                    foreach (var token in tokens)
                    {
                        var kvTokens = token.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                        if (kvTokens != null && kvTokens.Length == 2)
                        {
                            headers.Add(new KeyValuePair<string, string>(kvTokens[0].Trim(), kvTokens[1].Trim()));
                        }
                    }
                }
            }
            return headers;
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            tbRequestHeader.Text = string.Empty;
            tbRequestXml.Text = string.Empty;
            tbResponseXml.Text = string.Empty;
        }

        protected void GenerateEncodedHeader_Click(object sender, EventArgs e)
        {
            string clientId = ClinetIdTextBox.Text;
            string clientSecret = ClientSecretTextBox.Text;
            var encodedHeader = GenerateAuthorizationHeader(clientId, clientSecret);
            EncodedAuthorizationHeaderTextBox.Text = encodedHeader;
        }

        private string GenerateAuthorizationHeader(string clientId, string clientSecret)
        {
            string authInfo = clientId + ":" + clientSecret;
            authInfo = Convert.ToBase64String(Encoding.Default.GetBytes(authInfo));
            return "Authorization: Basic " + authInfo;
        }
    }
}