# OAuth Harness
---

###Endpoints -:
- /authorize  
- /token  
- /userinfo  
- /end_session  
- /revoke   

---


### Actions/Flows-:
1. Authorize code flow  
1. Implicit flow  
1. Client credentials flow  
1. Resource owner flow  
1. Get UserInfo by Access token  
1. Get Access token by Refresh token  
1. Revoke token  
1. End session  

----------




- **Authorize code flow**  
This is two step process.  
**Step 1**:- Call is made to authorize endpoint, if session is not present then authorize endpoint will redirect request to common login page.  
After successful authentication, code is returned to the calling application.  
**Step 2**:-  Access token is generated by exchanging the code with token endpoint.  
**Note** -: As oAuth harness does not have capability of redirection, both above steps can not be made simultaneously.  
You have to make first step, then copy the required data from response which will be required in second step.
     
	**How do I use OAuth harness?**  
Select '_AuthorizeCodeFlow_ ' from Select Actions dropdown.  
A dummy request will be populated. You can change request parameters if you want.  
Post this request. (As above stated, response of this call is View, so it will redirect you to login page and after successful login it will return Code in response).    
Now, select '_GetAccessTokenByCode_' from Actions dropdown.  
Modifiy dummy populated request and use above generated Code in order to get Access token.    
 
 	**Example-:**  
	**Step 1**:  
	Request Url  

	     GET https://www.vexiereidentity.com/apis/issue/oidc/authorize?client_id=1&scope=openid offline_access http://www.vexiere.com/oauth/app_name/Root_Default_App&redirect_uri=http://www.vexiereidentity.com/apis/&state=af22cde30e1d418f99674b11856cd28f&response_type=coded       
 
	Request Header - NA
		
	Request Body  - NA
	
	Response     

		<html><head><title>Object moved</title></head><body><h2>Object moved to <a href="http://www.vexiereidentity.com/apis:58352/Login.aspx?code=997726b5d49346bdb5de3be17a19c3f5&amp;state=af22cde30e1d418f99674b11856cd28f&amp;session_state=3fd7cd34-5bc9-4c6f-9c48-eea9adb27857">here</a>.</h2></body></html>

	<a href="Index.aspx?&Id=0" target="_blank"><b>Try It Out</b></a>

	**Step 2**:  
	Request Url    

		POST https://idp.vexiere.com:4443/issue/oidc/token  
	Request Header  

		Authorization: Basic MTpYWVpNd09HUTNZall0TlRka1lTMDBZakpqTFRnMFpUTXRNREF3TUROa01qVTRaalhZWg==  
	Request Body  

		grant_type=authorization_code&code=997726b5d49346bdb5de3be17a19c3f5&redirect_uri=http://www.vexiereidentity.com/apis/Login.aspx  
	Response
   
		{"id_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiIxIiwibmJmIjoxNDE5NTc1NzQ4LCJleHAiOjE0MTk1NzkzNDgsImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMTAwMDAwMSIsImFwcGxpY2F0aW9uX2lkIjoiMSIsInN1YiI6IjEjZWIwOGJhOTUtMDYwYS00OGNkLWJiNjgtZjM2Y2IyYWI4ZjI0I1N1cGVyQWRtaW4iLCJpYXQiOiIxNDE5NTc1NzQ5In0.jD7buZXCwGGItGFJuNHiEznyaKeaw1ZBpVi3EB7OUZkG1bM-Vt71RmU2GjtMM8vT6gx9rEyGcLLwcfKaMUuE08fAnewZvjA7_b9M82kKBFcThS51t-rEXS7JgvbFEwrAEWXJc9oEfPOPknFPnN_DEsC0BpetJ3rAhZY8GGKoLYY6JO29KqwE-k81Sb-BDKixl_zY6SZUK4Y-_ObSQ2Bs2JllbOh21MktpthfmcmIvXxBCpuSHN0p9vM7t2nVWC9899H3T3aVHTVPvDy1LB7NylacwYwLzYaHZqfRTYo9B11jP1dFwri8Mxp7RapotHfGxmwUsg0Kpjxk9Jj7KHMKmg","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzU3NDgsImV4cCI6MTQxOTY2MjE0OCwic2NvcGUiOlsib3BlbmlkIiwib2ZmbGluZV9hY2Nlc3MiLCIiXSwic3ViIjoiMSNlYjA4YmE5NS0wNjBhLTQ4Y2QtYmI2OC1mMzZjYjJhYjhmMjQjU3VwZXJBZG1pbiIsImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMTAwMDAwMSIsImFwcGxpY2F0aW9uX2lkIjoiMSJ9.fonIy4u3nooEgOti9zNV-ND-zfyNArOSAf272OEYGw3Z2cvjEsxyidK1am7Ej0bnyFH98ucSlD86bfUBtkZiQouEw-7mcWtUjL9tvgLvbUOfAUu3PsjFJSbk0HwWGFTByofQrF07Hhtp_eZiOuNHAohBWT3FzhoC6YkA8jHJho_6pGSPIbrvRCZquuQ8dHblcbXRJv0DcRaGmFeY_Php_CI_UYKNf9CoinkNIt6rvq1kBBSBdJJ5HaLVUnkJXPSCyKLxC6dk8ECFAxXssnl3S7OKdaWGEJ6UcdCgZTMDjDST96iVAS-InFMQpxjEweQqjvyMvPlBKYj0ME-X-wvjFQ","token_type":"Bearer","expires_in":86400,"refresh_token":"5e2c6f21ca5745c5849e2868cea6e8a9"}

	<a href="Index.aspx?&Id=1" target="_blank"><b>Try It Out</b></a>


- **Implicit flow**    
 Like authorize code flow, this flow also require redirection and cannot be done in one step form OAuth harness.  
**How do I use OAuth harness?**  
 Select '_ImplicitFlow_' from Select Actions dropdown.  
A dummy request will be populated. You can change request parameters if you want.    
You will get access token in response.    
**Example-:**  
	Request Url  

		GET https://www.vexiereidentity.com/apis/issue/oidc/authorize?client_id=1&redirect_uri=http://www.vexiereidentity.com/apis/&response_type=token&scope=openid profile http://www.vexiere.com/oauth/app_name/Root_Default_App&state=5770680743829823&realm=vexieredb&display=popup&nonce=5837139665691129  
	Request Header - NA    

	Request Body - NA

	Response  
 
		<html><head><title>Object moved</title></head><body><h2>Object moved to <a href="https://www.vexiereidentity.com/apis:3000/callback.html#access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzQ3NzgsImV4cCI6MTQxOTY2MTE3OCwic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsIiJdLCJzdWIiOiIxIzAwMmQ3NDEyLTg1YzQtNDc2ZC05MzQyLTkxODNkZGZlMGM5MiNTdXBlckFkbWluIiwiY2xpZW50X2lkIjoiMSIsInVzZXJfaWQiOiIxMDAwMDAxIiwiYXBwbGljYXRpb25faWQiOiIxIn0.jRJ2bGLKH06sOcadU8gdBpdC6dnz6Uw-VlpirHf_g-w9toGi6m8muIunoQ4qihPkDVyXWoj0VZYOF_QpxeE_Ibm5mdhdEc58yuS0tyXF-gzm9Z7e2X-RnB-N_OoeHLK_Khmb7TCTTzTh9MYJjwWxkfUT1nLyG51o8wHo_rHKkb9NtmW593_NaYXXyPmb27FOzhKzxOKNiD1i_JfYxkW5cFLvGaNLKQNRpk-mgi__rN7VKrHEnu-0TZ_X15XbqXOFSgvYMkIeeF-N0_oRLS-H-qnQ1jK0eZtKjZFEty5IFhypmeTLe5d-360IGn-_CFIQX9oA94dsPh5uML6REbV8qw&amp;token_type=Bearer&amp;expires_in=86400&amp;state=5770680743829823&amp;nonce=5837139665691129&amp;session_state=c54b1e2e-b6d1-4678-b15c-ad834c500df2">here</a>.</h2></body></html>

	<a href="Index.aspx?&Id=2" target="_blank"><b>Try It Out</b></a>


- **Client credentials flow**  
This will return access token on behalf of client.  
**How do I use OAuth harness?**    
Select '_ClientCredentialsFlow_' from Select Actions dropdown.  
A dummy request will be populated. You can change request parameters if you want.    
You will get access token in response.  

	**Example-:** 	   
	Request Url   
 
		POST https://www.vexiereidentity.com/apis/issue/oidc/token  
	Request Header  

		Authorization: Basic MTpYWVpNd09HUTNZall0TlRka1lTMDBZakpqTFRnMFpUTXRNREF3TUROa01qVTRaalhZWg==  
	Request Body  

		grant_type=client_credentials&scope=openid offline_access 
	Response 
  
		"id_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiIxIiwibmJmIjoxNDE5NTc2ODE5LCJleHAiOjE0MTk1ODA0MTksImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMCIsImFwcGxpY2F0aW9uX2lkIjoiMCIsInN1YiI6IjEiLCJpYXQiOiIxNDE5NTc2ODIwIn0.sRTBU7wOpTF-7qih4ji0VS4gubsI5R9JVC_9G6VD1g46siFZqsljZZcyvikRdZ256KTyV9tcD8oUqTWje4bLwWfTjAUlBrXa0e3XZ_k9VblA-a0MvRL8kMjlr82yGtHqM0asDZJObVg4SIy96TPdmtJqkCqc57G3gKm_MlEToXtfWg7yxSqeLaaeqxd7gpKIO4cFaEU2USyEKVNOfUFnuFK4E9cklq8Kh0RsNZt_cxARRyOs4odI91uFU5QwHHSOe4A_ZVB0MF9MFU1CcJj4e24J3HpPiQKE2mPxXAAiYZzuLBtAQA-jcq1PUhHX-1cMNJmEmc8JDmFdf0Tg8s4Wlw","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzY4MTksImV4cCI6MTQxOTY2MzIxOSwic2NvcGUiOlsib3BlbmlkIiwib2ZmbGluZV9hY2Nlc3MiXSwic3ViIjoiMSIsImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMCIsImFwcGxpY2F0aW9uX2lkIjoiMCJ9.j2VfyLRd1eUTddj3NFjesKlB4pbTe0P6b-1wu8O-4bkQU6fRnegtrgUf7AFL8vCbFzIy8kpWxeQdIptga9Bb8NiXh6RGufB_kDbJfpMYKqrRPX8no9nloteMwxmXsBlGLiy-9rLHw0InYTXf1a31aOId8uIbGes8PZfQy4C4wtTr4CU7QJJZxLuOiY92MpDEMKBbLfVMpvyADxPiOXHZ6AxYsUF1zvXBQ0Z2mBcvffQp3ermre3E_ezYpozNTWdA8efnuV5YRBIqP4uPH1S7EY42d5cR5UzrDAuI-fV4YYIJQgh7xTJ6RCNWcfDBKGEJYNOHlxodfn1ux05ODYeoaQ","token_type":"Bearer","expires_in":86400,"refresh_token":"6bc5514fc6b1451288f69e0e75ebc9ab"}    

 	  <a href="Index.aspx?&Id=3" target="_blank"><b>Try It Out</b></a>


- **Resource owner flow**  
 This will return access token on behalf of client as well as user.  
**How do I use OAuth harness?**    
Select '_ResourceOwnerFlow_' from Select Actions dropdown.  
A dummy request will be populated. You can change request parameters if you want.    
You will get access token in response.  

	**Example-:** 	   
	Request Url 
   
		POST https://www.vexiereidentity.com/apis/issue/oidc/token  
	Request Header  

		Authorization: Basic MTpYWVpNd09HUTNZall0TlRka1lTMDBZakpqTFRnMFpUTXRNREF3TUROa01qVTRaalhZWg==
	Request Body  

		grant_type=password&username=SuperAdmin&password=zaq1ZAQ!&scope=openid profile full_control offline_access  
	Response 
  
		"id_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiIxIiwibmJmIjoxNDE5NTc2ODE5LCJleHAiOjE0MTk1ODA0MTksImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMCIsImFwcGxpY2F0aW9uX2lkIjoiMCIsInN1YiI6IjEiLCJpYXQiOiIxNDE5NTc2ODIwIn0.sRTBU7wOpTF-7qih4ji0VS4gubsI5R9JVC_9G6VD1g46siFZqsljZZcyvikRdZ256KTyV9tcD8oUqTWje4bLwWfTjAUlBrXa0e3XZ_k9VblA-a0MvRL8kMjlr82yGtHqM0asDZJObVg4SIy96TPdmtJqkCqc57G3gKm_MlEToXtfWg7yxSqeLaaeqxd7gpKIO4cFaEU2USyEKVNOfUFnuFK4E9cklq8Kh0RsNZt_cxARRyOs4odI91uFU5QwHHSOe4A_ZVB0MF9MFU1CcJj4e24J3HpPiQKE2mPxXAAiYZzuLBtAQA-jcq1PUhHX-1cMNJmEmc8JDmFdf0Tg8s4Wlw","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzY4MTksImV4cCI6MTQxOTY2MzIxOSwic2NvcGUiOlsib3BlbmlkIiwib2ZmbGluZV9hY2Nlc3MiXSwic3ViIjoiMSIsImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMCIsImFwcGxpY2F0aW9uX2lkIjoiMCJ9.j2VfyLRd1eUTddj3NFjesKlB4pbTe0P6b-1wu8O-4bkQU6fRnegtrgUf7AFL8vCbFzIy8kpWxeQdIptga9Bb8NiXh6RGufB_kDbJfpMYKqrRPX8no9nloteMwxmXsBlGLiy-9rLHw0InYTXf1a31aOId8uIbGes8PZfQy4C4wtTr4CU7QJJZxLuOiY92MpDEMKBbLfVMpvyADxPiOXHZ6AxYsUF1zvXBQ0Z2mBcvffQp3ermre3E_ezYpozNTWdA8efnuV5YRBIqP4uPH1S7EY42d5cR5UzrDAuI-fV4YYIJQgh7xTJ6RCNWcfDBKGEJYNOHlxodfn1ux05ODYeoaQ","token_type":"Bearer","expires_in":86400,"refresh_token":"6bc5514fc6b1451288f69e0e75ebc9ab"}   

	   <a href="Index.aspx?&Id=4" target="_blank"><b>Try It Out</b></a>

- **Get UserInfo by Access token**  
This endpoint will return user information by accepting access token.  
**How do I use OAuth harness?**    
Select '_GetUserInfoByAccessToken_' from Select Actions dropdown.  
A dummy request will be populated. Change request parameters if you want.    
You will get user info related to that access token in response.  

	**Example-:** 	   
	Request Url 
   
		POST https://www.vexiereidentity.com/apis/issue/oidc/userinfo  
	Request Header 
 
		Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzQ3NzgsImV4cCI6MTQxOTY2MTE3OCwic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsIiJdLCJzdWIiOiIxIzAwMmQ3NDEyLTg1YzQtNDc2ZC05MzQyLTkxODNkZGZlMGM5MiNTdXBlckFkbWluIiwiY2xpZW50X2lkIjoiMSIsInVzZXJfaWQiOiIxMDAwMDAxIiwiYXBwbGljYXRpb25faWQiOiIxIn0.jRJ2bGLKH06sOcadU8gdBpdC6dnz6Uw-VlpirHf_g-w9toGi6m8muIunoQ4qihPkDVyXWoj0VZYOF_QpxeE_Ibm5mdhdEc58yuS0tyXF-gzm9Z7e2X-RnB-N_OoeHLK_Khmb7TCTTzTh9MYJjwWxkfUT1nLyG51o8wHo_rHKkb9NtmW593_NaYXXyPmb27FOzhKzxOKNiD1i_JfYxkW5cFLvGaNLKQNRpk-mgi__rN7VKrHEnu-0TZ_X15XbqXOFSgvYMkIeeF-N0_oRLS-H-qnQ1jK0eZtKjZFEty5IFhypmeTLe5d-360IGn-_CFIQX9oA94dsPh5uML6REbV8qw  
	Request Body -NA

	Response   

		{"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name":"1#002d7412-85c4-476d-9342-9183ddfe0c92#SuperAdmin","client_id":"1"}    

  	 <a href="Index.aspx?&Id=5" target="_blank"><b>Try It Out</b></a>
  


- **Get Access token by Refresh token**  
This endpoint lets you get new access token by providing refresh token.    
**How do I use OAuth harness?**    
Select '_GetAccessTokenByRefreshToken_' from Select Actions dropdown.  
A dummy request will be populated. Change request parameters if you want.    
You will get new access token in response.  

	**Example-:** 	   
	Request Url    

		POST https://www.vexiereidentity.com/apis/issue/oidc/token  
	Request Header  

		Authorization: Basic MTpYWVpNd09HUTNZall0TlRka1lTMDBZakpqTFRnMFpUTXRNREF3TUROa01qVTRaalhZWg==  
	Request Body 
 
		grant_type=refresh_token&refresh_token=45e9e8d4562d4c7d9314af4194b47e79  
	Response 
  
		{"id_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiIxIiwibmJmIjoxNDE5NTc2NTEwLCJleHAiOjE0MTk1ODAxMTAsImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMTAwMDAwMSIsImFwcGxpY2F0aW9uX2lkIjoiMCIsInN1YiI6IjEjNDc4OTBhM2UtYjkyZS00MjYzLTgyMzItM2Y4NGQyODM4YzYzI1N1cGVyQWRtaW4iLCJpYXQiOiIxNDE5NTc2NTExIn0.t7KDYHvpEIFnJjJwF8EFLTGdqdnLb3oTG-xgD8t6ZG6OGZZzreRJMib1PSIeyoVQ98Xl40BudvyUBnzGZiBd0TZeHXSyBUc4_xKVkXOLXU5RTSI3gJoTq6GiNCDRvE-kqdoWrm-ibKaIHPGJhtZfZzKUgb-pt9kkJvqLW09uxGmD0zd9Q6nm-xwAEkbEffsxyFx5mDEj1w2VrRW8D73Mo8UVnSCCgMLVhrzKj2GPbaWJ5tDQ4Wz582-EIQke9LCRdVpZJtsLHnKpgzFkMksPHR_HHRW9F0znXMxP7pO50fGifwuLKX4K4DTpefdkP_hxvlcuOLghQIanvdfsG5RAsQ","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzY1MTAsImV4cCI6MTQxOTY2MjkxMCwic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsImZ1bGxfY29udHJvbCIsIm9mZmxpbmVfYWNjZXNzIl0sInN1YiI6IjEjNDc4OTBhM2UtYjkyZS00MjYzLTgyMzItM2Y4NGQyODM4YzYzI1N1cGVyQWRtaW4iLCJjbGllbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEwMDAwMDEiLCJhcHBsaWNhdGlvbl9pZCI6IjAifQ.sWbc3GI27xojXSGWgIdZR01-bvuTGnKzHRHG_B1e1uOzoFuXvXd6gUq6NEqribkSwTbgre1hoie8tpJDJvncQ8pB2bNCbDhoYxknqwDN7Fkv6a3c_SIX14mkqoQ3RBsMd_Oc-g9NCQtXacTgwT7m3WIv_g3eKo7PbSTJUQ5GG_Rbe2gXEQIhCK8k2zrjNr22hVC1ULm2gRupB1DTni6xcLlcOQoIgk75agSUiWr06r4tDuwL5p-hem57OL3JZsXLaUiD_yDsSo2M9eslF2cHANJ_FNCSUHtHHE07cumd4TPBsuQP6jdLg7eSMXZzcSP6xx8ePx7JjaeXjjESzHJl6Q","token_type":"Bearer","expires_in":86400,"refresh_token":"45e9e8d4562d4c7d9314af4194b47e79"}    

  	 <a href="Index.aspx?&Id=6" target="_blank"><b>Try It Out</b></a>

- **Revoke token**  
This endpoint lets revoke access token.    
**How do I use OAuth harness?**    
Select '_RevokeToken_' from Select Actions dropdown.  
A dummy request will be populated. Change request parameters if you want.    
It will only return success code in response.  

	**Example-:** 	   
	Request Url  
  
		POST https://www.vexiereidentity.com/apis/issue/oidc/revoke  
	Request Header 
 
		Authorization: Basic MTpYWVpNd09HUTNZall0TlRka1lTMDBZakpqTFRnMFpUTXRNREF3TUROa01qVTRaalhZWg==  
	Request Body  

		token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAvdXNlcmluZm8iLCJuYmYiOjE0MTk1NzY3MDcsImV4cCI6MTQxOTY2MzEwNywic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsImZ1bGxfY29udHJvbCIsIm9mZmxpbmVfYWNjZXNzIl0sInN1YiI6IjEjNGQxYjE0NjctM2NlMC00MDE1LTkyNDMtMzBiODQ2MjkxZjExI1N1cGVyQWRtaW4iLCJjbGllbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEwMDAwMDEiLCJhcHBsaWNhdGlvbl9pZCI6IjAifQ.Om-8mfY5B4hTKGgZ-6e9bVEuEdMjGKLMP_t9xkD30gi5lW7AwR6JpARpnSQXlx4o3ignu1Z2fybY6Pv3SRIj4dtsnUnX050jtcVRoAOWPLug0xhmzsTTjDdpq1cOlutiEY0KBfRkzfokQ3a2qPNCJJsKJtfHX4qK-H9LMvzwdL0BKgwZKTIxtp5PK6AVF4fiDv1MEDT_usPo3OlcLHALM86lF68FpE6WgFO6T-U_SnANUKEpfRZ8YJuUMinq01Gp1BzX9XHV3iPgiGfsxlwjpMyNB9HXD1c2_dP3KkZGjpE9oDSeXxxZHyfKluoVfBAvUEa4N0sDfuiJTjT4gfU1QQ&token_type_hint=access_token 
	Response   

		200 OK    

  	 <a href="Index.aspx?&Id=7" target="_blank"><b>Try It Out</b></a>




- **End session**  
This endpoint lets you destroy current active session.    
**How do I use OAuth harness?**   
Select '_EndSession_' from Select Actions dropdown.  
A dummy request will be populated. Change request parameters if you want.    
It will only return success code in response.    

	**Example-:** 	   
	Request Url 
   
		GET http://www.vexiereidentity.com/apis/issue/oidc/end_session?id_token_hint=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImhiSjItdTBSdHNpX0cxTW56SlFyVnVmQjllcyJ9.eyJpc3MiOiJodHRwOi8vdmV4aWVyZS52Mi50YXZpc2NhLmNvbS9pZHAiLCJhdWQiOiIxIiwibmJmIjoxNDE5NTc3MTA1LCJleHAiOjE0MTk1ODA3MDUsImNsaWVudF9pZCI6IjEiLCJ1c2VyX2lkIjoiMTAwMDAwMSIsImFwcGxpY2F0aW9uX2lkIjoiMSIsInN1YiI6IjEjZWIwOGJhOTUtMDYwYS00OGNkLWJiNjgtZjM2Y2IyYWI4ZjI0I1N1cGVyQWRtaW4iLCJpYXQiOiIxNDE5NTc3MTA2In0.IAAgR_jQ1eDQilCFCYTboYibHUDaoA5KGMFXsfTTE-gBDA4RjYS-yLnP9GjeS5Z7nUdPnSHcxwRQvneN5f_5kA7JF2KiBIp3p5RhopKsU5lLMv0xXXGAYH4rqqO-p67WdnmSNMvqm52AuxfQz1bdlvdtd_zX8o9ZwfL5DTKr5fljvlXUF63s5-uaYPJPOg_sqFMcqTcOjGKMApSXUeV7GWv5kc59295EwWeEwcjO0Fbduj5dBLp60IW_mVQAoWs8GoDpDbnI8f8qkzRuZma-TOlizwnOPu_Zv4gxNB8fxwYV6m0S-IYHzgmuwwc8VoAJRJi2bvIcaH01yByIcb5ZDA&post_logout_redirect_uri=https://www.vexiereidentity.com/apis/
  
	Request Header- NA

	Request Body - NA
  
	Response
   
		<html><head><title>Object moved</title></head><body><h2>Object moved to <a href="https://www.vexiereidentity.com/apis:6443/logout">here</a>.</h2></body></html>    

  	 <a href="Index.aspx?&Id=8" target="_blank"><b>Try It Out</b></a>

***Important Note*** :--   
In above all endpoints, **Authorization header** content is encoded by base64 encoding.  
So, encode it first if you are changing dummy populated request headers.





