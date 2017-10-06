### Signing In
1. Sign in the platform portal using your registered credentials

### Accessing your Workspace
1. Click Profile tab on the header
   
    OR
    
    Click the Profile Icon and select Profile

### Uploading Users
1. Click Upload Users. The upload users page is displayed
        	<Image>
1. Enter Provider details. Channel ID of the organization administrator must be entered here
1. Enter External ID. Unique ID of the user that has to be uploaded must be entered here
    
    OR
    
    Enter OrgID. Unique ID of the admin organization must be entered here
1. Download the csv file for reference
1. You can add or upload details of up to 200 users at a time in one csv file
1. The following columns are mandatory:

Column Title | Description
-------------|-----------
FirstName | User’s first name
Email | User’s verified email ID
UserName | User’s place of location of the user
Password | Unique name assigned to the user by the organization. For example, unique username for Ravikumar could be RaviK and for Mohan Shetty could be MohanS etc.

***Note:***
*UserName and FirstName should not be the same*

7. All other columns are optional. These columns include information about the user such as:

Column Title	| Description
-------------|-----------
 Role	| User’s role on DIKSHA. For example; whether the user is a creator, reviewer or administrator.
Grade	| Classes taught by the user
Location | User’s place of location of the user
DOB | User’s date of birth, the value should be entered in DD-MM-YYYY format
Gender | User’s gender
Language | User’s language preferences
Profile summary |User’s profile summary
Subject |Taught by the user

***Note:***
*Columns titled emailVerified, phoneVerfied and provider are conditionally mandatory. Value for emailVerfied and phoneVerified should be True, if details are provided for provider*

8. Click UPLOAD USERS CSV. The explorer window is displayed
9. Select the csv file and click Open
10. The csv file is successfully uploaded
11. On successful file upload, a message intimating you of the same will be displayed, else an error message is displayed.
