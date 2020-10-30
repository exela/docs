# Service Builder Modules Gradle

I created a custom test-service-builder with the foo entity from our blade samples and was able to deploy and confirm that my api shows up in /api/jsonws - so this looks like it may be an issue with how the client is building out their customization.

Here are the steps I performed (so you can test).

1) Create a custom service-builder using a blade template:

blade create -t service-builder test-service-builder

2) Navigate to /test-service-builder-service and verify that remote-services is set to true in the service.xml

3) Navigate back to your project's root directory. Build out your service.

blade gw buildService

4) Because we are using a template, the default entity setup is Foo. Navigate to test-service-builder/test-service-builder-service/src/main/java/test/service/builder/service/impl/FooServiceImpl.java

5) Edit the FooServiceImpl.java file, adding some code AFTER this line

public class FooServiceImpl extends FooServiceBaseImpl {
ADD THIS:

	public String helloWorld(String worldName) {
		return "Hello World: " + worldName;
	}
6) Rebuild the service.

blade gw buildService

7) Build out the deployable jar files.

blade gw jar

8) Copy both the jar files from

*.api/build/libs/*.jar
and

*.service/build/libs/*.jar
into your Liferay deploy folder.

9) Startup Liferay. (Deploying the .jar files)

10) Navigate to liferay localhost:8080/api/jsonws

11) Click the Context Name dropdown and see that foo is there. Look, the helloWorld api is available!

https://portal.liferay.dev/docs/7-0/tutorials/-/knowledge_base/t/registering-json-web-services
https://portal.liferay.dev/docs/7-0/tutorials/-/knowledge_base/t/portal-configuration-of-json-web-services
https://portal.liferay.dev/docs/7-1/tutorials/-/knowledge_base/t/service-builder
