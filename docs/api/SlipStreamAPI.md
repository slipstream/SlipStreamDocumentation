FORMAT: 1A
HOST: https://www.sixsq.com

# SlipStream API
This document describe the full **API** of [SlipStream](https://www.sixsq.com/slipstream).

### Basics
The full API is stateless and use HTTP transport.
This API uses XML format to represent and transfer data.

### Use the API
The first thing to do is to authenticate yourself with a username and a password.
This will return you a encrypted cookie. Use this cookie to all of your next requests.

# Group Authentication and registration
This group contain all ressources related to authentication and registration process.
You need to have a valid account to uses SlipStream.
If you forgot your password you can reset it.
If you don't have an account, you can ask for an account.
Depending on the configuration of SlipStream your account can be created directly or you will have to wait a validation from an admin.

## Login [/login{?redirectURL}]

### Authenticate [POST]
Generate a cookie if the provided username and password are valid.

+ Parameters
    + redirectURL = `/` (optional, relative URI, `/dashboard`) ... Relative URI where to redirect after a successful login.
    + username (required, string, `toto`) ... Username
    + password (required, string, `totopass`) ... Password

+ Request (application/x-www-form-urlencoded; charset=UTF-8)

    + Body

            username=toto&password=totopass

+ Response 200

    + Headers

            Set-Cookie: com.sixsq.slipstream.cookie=com.sixsq.idtype=local&com.sixsq.identifier=toto&com.sixsq.expirydate=1393968383734&com.sixsq.signature=k3fvfj4oe53f41o04k786fk90zvxpbnhk7fx5jdeg9aaeb6oiof3nix2d2yiug9gqzbjgumf4llqvsmgpwco5hci0q2o399v6wz; Path=/



+ Response 303

    + Headers

            Location: http://129.194.184.188:8182/
            Set-Cookie: com.sixsq.slipstream.cookie=com.sixsq.idtype=local&com.sixsq.identifier=toto&com.sixsq.expirydate=1393968383734&com.sixsq.signature=k3fvfj4oe53f41o04k786fk90zvxpbnhk7fx5jdeg9aaeb6oiof3nix2d2yiug9gqzbjgumf4llqvsmgpwco5hci0q2o399v6wz; Path=/

+ Response 401 (text/plain; charset=UTF-8)

    + Body

            Error: Username/password combination not valid (401 - Unauthorized)


## Logout [/logout]

### Invalidate the cookie [DELETE]
Invalidate the cookie and delete it from the browser cache.

+ Response 303

    + Headers

            Location: http://129.194.184.188:8182/login
            Set-Cookie: com.sixsq.slipstream.cookie=INVALID; Path=/; Expires=Now

            
## Registration [/register]

### Register [POST]
Register a new user if self registration is enabled.

+ Parameters
    + username (required, string, `toto`) ... Unique username
    + firstname (required, string, `Jack`) ... User's first name
    + lastname (required, string, `Bauer`) ... User's last name
    + organization (required, string, `CTU`) ... Company's name
    + email (required, string, `toto@ctu.usgov`) ... Em@il
    + agreement (required, string, `yes`) ... Must be set to any value to confirm that you agree to the Terms of Service.

+ Request (application/x-www-form-urlencoded; charset=UTF-8)

    + Body

            username=toto&firstname=Jack&lastname=Bauer&organization=CTU&email=toto%40ctu.usgov&agreement=yes

+ Response 201 (text/plain; charset=UTF-8)

    + Body

            An email has been sent to the address you have given.
            Please visit the link in that email to activate your account.

+ Response 403 (text/plain; charset=UTF-8)

    + Body

            Self registration disabled

+ Response 409 (text/plain; charset=UTF-8)

    + Body
    
            An error occured.
            
+ Response 500 (text/plain; charset=UTF-8)

    + Body
    
            Internal Server Error.

## Reset Password [/reset]

### reset password [POST]
Send an email to the email address of the user to allow it to reset his password.

+ Parameters
    + username (required, string, `toto`) ... Unique username
    
+ Response 201 ()

    + Body

            A password reset validation email has been sent to the address
            in your account profile.  Please visit the link in that email 
            to confirm this request.

+ Response 500 (text/plain; charset=UTF-8)

    + Body

            An error message.
            
+ Response 400 (text/plain; charset=UTF-8)

    + Body
    
            An error message.

# Group Users
This group contain all ressources related to users managment.

## Users List [/user]
List all users.
*Only priviledged users can access this ressource*

### Get users [GET]

+ Response 200

    + Body

            <list>
                <item name="toto" resourceUri="user/toto" firstName="Jack" lastName="Bauer" state="NEW" online="false"/>
                <item name="sixsq" resourceUri="user/sixsq" firstName="SixSq" lastName="Administrator" state="ACTIVE" online="false"/>
                <item name="super" resourceUri="user/super" firstName="Super" lastName="User" state="ACTIVE" lastOnline="2014-03-04 15:22:38.332 CET" online="true"/>
                <item name="test" resourceUri="user/test" firstName="Test" lastName="User" state="ACTIVE" online="false"/>
            </list>

## User details [/user/{username}]

+ Parameters
    + username (required, string, `toto`) ... UserName

### Get user details [GET]

+ Response 200

    + Body

            <user deleted="false" resourceUri="user/toto" name="toto" email="toto@ctu.usgov" firstName="Jack" lastName="Bauer" organization="CTU" issuper="true" state="NEW" creation="2013-12-09 11:36:07.389 CET">
               <parameters class="org.hibernate.collection.PersistentMap">
                  <entry>
                     <string><![CDATA[General.default.cloud.service]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="General.default.cloud.service" description="Select which cloud you want to use." category="General" mandatory="true" type="Enum" readonly="false">
                        <enumValues length="3">
                           <string>HPcloud</string>
                           <string>Exoscale</string>
                           <string>AmazonEC2-EU</string>
                        </enumValues>
                        <value><![CDATA[Exoscale]]></value>
                     </parameter>
                  </entry>
	              <entry>
                     <string><![CDATA[General.Timeout]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="General.Timeout" description="Minutes - When this timeout is reached, the execution is forcefully terminated." category="General" mandatory="true" type="String" readonly="false">
                        <value><![CDATA[30]]></value>
                     </parameter>
                  </entry>
	              <entry>
                     <string><![CDATA[General.On Success Run Forever]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="General.On Success Run Forever" description="If no errors occur, keep the execution running. Useful for deployment or long tests." category="General" mandatory="true" type="Boolean" readonly="false">
                        <value><![CDATA[false]]></value>
                     </parameter>
                  </entry>
	              <entry>
                     <string><![CDATA[General.On Error Run Forever]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="General.On Error Run Forever" description="If an error occurs, keep the execution running for investigation." category="General" mandatory="true" type="Boolean" readonly="false">
                        <value><![CDATA[true]]></value>
                     </parameter>
                  </entry>
	              <entry>
                     <string><![CDATA[General.Verbosity Level]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="General.Verbosity Level" description="Level of verbosity. 0 - Actions, 1 - Steps, 2 - Details data, 3 - Debugging." category="General" mandatory="true" type="Enum" readonly="false">
                        <enumValues length="4">
                           <string>0</string>
                           <string>1</string>
                           <string>2</string>
                           <string>3</string>
                        </enumValues>
                        <value><![CDATA[1]]></value>
                     </parameter>
                  </entry>
	              <entry>
                     <string><![CDATA[General.ssh.public.key]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="General.ssh.public.key" description="SSH Public Key(s) (keys must be separated by new line)" category="General" mandatory="true" type="RestrictedText" readonly="false"/>
                  </entry>
	              <entry>
                     <string><![CDATA[AmazonEC2-EU.access.id]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="AmazonEC2-EU.access.id" description="Access id (required to submit to EC2)" category="AmazonEC2-EU" mandatory="true" type="String" readonly="false">
                        <instructions><![CDATA[You can find the 'access id' by logging into the <a href='http://aws.amazon.com/console/'>AWS Console</a> and going to the <a href='https://aws-portal.amazon.com/gp/aws/developer/account?ie=UTF8&action=access-key'>Security Credentials</a> page. Here is a screenshot showing where to retrieve the information: <img src='/images/aws-access-id.png' />.]]></instructions>
                     </parameter>
                  </entry>
                  <entry>
                     <string><![CDATA[AmazonEC2-EU.secret.key]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="AmazonEC2-EU.secret.key" description="Secret key (required to submit to EC2)" category="AmazonEC2-EU" mandatory="true" type="Password" readonly="false">
                        <instructions><![CDATA[You can find the 'secret key' by logging into the <a href='http://aws.amazon.com/console/'>AWS Console</a> and going to the <a href='https://aws-portal.amazon.com/gp/aws/developer/account?ie=UTF8&action=access-key'>Security Credentials</a> page. Here is a screenshot showing where to retrieve the information: <img src='/images/aws-secret-key.png' />.]]></instructions>
                     </parameter>
                  </entry>
                  <entry>
                     <string><![CDATA[AmazonEC2-EU.keypair.name]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="AmazonEC2-EU.keypair.name" description="Keypair Name (required to submit to EC2)" category="AmazonEC2-EU" mandatory="true" type="String" readonly="false"/>
                  </entry>
                  <entry>
                     <string><![CDATA[Exoscale.username]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="Exoscale.username" description="Key" category="Exoscale" mandatory="true" type="String" readonly="false"/>
                  </entry>
                  <entry>
                     <string><![CDATA[Exoscale.password]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="Exoscale.password" description="Secret" category="Exoscale" mandatory="true" type="Password" readonly="false"/>
                  </entry>
                  <entry>
                     <string><![CDATA[HPcloud.username]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="HPcloud.username" description="Username" category="HPcloud" mandatory="true" type="String" readonly="false"/>
                  </entry>
	              <entry>
                     <string><![CDATA[HPcloud.password]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="HPcloud.password" description="Password" category="HPcloud" mandatory="true" type="Password" readonly="false"/>
                  </entry>
                  <entry>
                     <string><![CDATA[HPcloud.tenant.name]]></string>
                     <parameter class="com.sixsq.slipstream.persistence.UserParameter" name="HPcloud.tenant.name" description="Project name (sometime it&apos;s called Tenant name)" category="HPcloud" mandatory="true" type="String" readonly="false"/>
                  </entry>
               </parameters>
            </user>
            

### Update user [PUT]


### Delete user [DELETE]


### 


# Group Modules
Get or set tags on notes

## GET /tags
Get a list of bars

+ Response 200

## Get one tag [/tags/{id}]
Get a single tag

### GET




# Group Runs


## /run

### List of Runs [GET]

## Run ressource [/run/{run_id}]

### Create a run [POST]

### Get run details [GET]

### Terminate a run [DELETE]










