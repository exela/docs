# Setting Cookie Configurations

One common service customization is to add the `HttpOnly` and `Secure` flags onto `JSESSIONID` cookie at the application level for requests.  This can be done through customizing the Liferay service and Tomcat via scripts or through updating NGINX configurations on the webserver service.

## Setting Cookie Configurations on the Liferay Service

1) Create a `cookie-config.sh` script.

```
#!/bin/bash

show-files /lcp-container/config
cp -r /lcp-contaiiner/config/$LC_PROJECT_ENVIRONMENT/tomcat/conf/* /opt/liferay/tomcat/conf
```

2) Run `chmod +x cookie-config.sh` to make the script executable.

3) Place `cookie-config.sh` into the environment where it needs to be run: `/lcp/liferay/script/{env}`

4) The script uses a DXPC entrypoint, `show-files`.  The script is environment-friendly, meaning it will recognize the environment which it is run in.  `show-files` is used to print the directory structure of a given directory to the logs.  In this case, it prints the `/lcp-container/config` directory structure.  Entrypoint scripts may be found by accessing the service shell and looking in the `/usr/local/bin` directory.  The script also takes advantage of the environment variable `LCP_PROJECT_ENVIRONMENT`, which is a string that tells which environment the service lives.

5) Once the script is in place, we will update Tomcat's `/tomcat/conf/web.xml`.  Find the default `web.xml` file that matches with the Liferay Tomcat bundle of your DXPC instance.  (e.g., if using Liferay DXP 7.3, you need the `web.xml` of a Liferay DXP 7.3 Tomcat bundle).

>**NOTE:** This can be found in 1 of 2 ways:
> -In the DXPC Console, go to *Services > Liferay > Shell* and copy the `web.xml` from the Tomcat directory.
> -Download a separate Liferay Tomcat bundle (which matches the version on DXPC) and copy the `web.xml` from the bundle

6) In the `web.xml` replace the `<session-config> tag with this snippet:

```
<session-config>
    <session-timeout>30</session-timeout>
    <cookie-config>
        <http-only>true</http-only>
        <secure>true</secure>
    </cookie-config>
</session-config>
```

7) This file should then be placed in the `/lcp/liferay/config/{env}/tomcat/conf` directory.

When the Liferay service is deployed, the file is copied to Tomcat's `/conf` directory (due to the `cookie-config.sh` script).

>**NOTE:** If you ever need to upgrade Tomcat and the Tomcat upgrade includes changes to the `web.xml`, make sure to merge your `web.xml` customizations with the `web.xml` changes made by the Tomcat update.

8) We can confirm that these changes took place by accessing the webserver endpoint and inspecting the `JSESSIONID` cookie.  Upon cookie inspection, `HttpOnly` and `secure` flags should be checked.

## Setting Cookie Configurations on the Webserver Service

Through the webserver service, we will be adding a `proxy_cookie_path` directive within the `ssl.conf` file. 

1) Create an `ssl.conf` file in the `/lcp/webserver/config/{env}` directory.

```
# Adds HttpOnly and Secure flags to cookie
proxy_cookie_path / "/; HTTPOnly; Secure";
```

2) Once the service has been deployed, we can confirm this by inspecting the `SERVER_ID` cookie and seeing that `HttpOnly` and `Secure` flags have been marked.