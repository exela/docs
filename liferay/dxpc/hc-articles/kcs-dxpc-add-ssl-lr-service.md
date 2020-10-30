# Adding SSL certificate to the JVM (Exercise and POC)

## TODO
# Need updated `move-certs.sh` script

---
**NOTE:** Although this request does not occur frequently, this does demonstrate useful workarounds that come in handy when using DXPC.  DXPC permission issues arise frequently due to a lack of root access.
---

Suppose a client is looking to setup two-way SSL.  One half of this requires placing the SSL Certificate in the JVM's keystore.  In a typical environment, we would add the certificate directly in the keystore and the job would be finished.  For DXPC, we do not have root access and cannot add files to or modify files in certain directories.

1) *Optional* Generate a self-signed certificate.  Password of at least 6 characters.

```
openssl req -x509 -newkey rsa -keyout lrkey.pem -out lrcert.pem
```

2) We will point the JVM to a certificate using JVM configurations through environment variables.  In the Liferay service `LCP.json` file (located at `/lcp/liferay/LCP.json`), add to the `environments` block:

```
"environments": {
        "uat": {
            "env":{
                "LIFERAY_JAVA_OPTS": "-Djavax.net.ssl.trustStore=/opt/liferay/data/cacerts"
            }
        }
}
```

This scopes the environment variable changes to the `uat` environment.

3) Next, we need to copy the private key onto the DXP Cloud Liferay service container.  Create a `/lcp/liferay/certificates` directory and copy your `lrcert.pem` file there.

4) Create a `move-certs.sh` script in the `/lcp/liferay/script/{env}` directory.  This script will copy the original keystore to a writable directory (this is the permission workaround).  The script will copy the original keystore to a writeable directory.

```
#!/bin/bash
# Copy the default keystore a new, writeable one
cp -f /opt/jdk/jre/lib/security/cacerts /opt/liferay/data/cacerts

# Import certificate to the newly created JKS
keytool -import -alias certificate-sa -keystore /opt/liferay/data/cacerts -file /lcp-container/certificates/lrcert.pem -keypass {PASSPHRASE}
```

>**NOTE:** Make sure to replace the `{PASSPHRASE}` argument in the `keytool` command with your keystore password.  By default, the password is `changeit`.  This is **NOT** the same passphrase created when we generated the self-signed certificate.

5) Make the `move-certs.sh` script executable, using `chmod +x move-certs.sh`.

6) To confirm everything worked, check the JVM system properties for the correct `trustStore` directory and ensure the keytool reports the key was successfully imported in the logs.  The JVM system properties can be checked using the following command:

```
jcmd {TOMCAT_PID} VM.system_properties | grep Store
```

**NOTE:** `TOMCAT_PID` can be found using `ps aux`.  The command starting with `/opt/jdk/jre/bin/java` is the Tomcat process.  `jcmd` checkes the process' JVM system properties.  Make sure that `javax.net.ssl.trustStore=/opt/liferaydata/cacerts` is seen as output.  This confirms that the JVM trustStore is pointed at the correct location.

7) To check that the certificate was successfully added, check the build and deployment logs of the Liferay service on the DXPC console.  Underneath the script running section of the logs, the script should report the certificate was successfully added to the keystore.