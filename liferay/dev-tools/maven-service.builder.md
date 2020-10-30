# Service Builder Module Maven

Used for LR 7.2

1) Create a custom service-builder using a blade template, this time flagging it maven:

blade create -b maven -t service-builder maven-sb

2) Navigate to your project's ROOT POM.xml - found here /maven-sb/POM.xml, edit the XML to include the plugin artifacts for com.liferay.portal.tools.service.builder and com.liferay.portal.tools.wsdd.builder. Here is what my POM.xml looks like, the plugins were added towards the end:

<?xml version="1.0"?>

<project
	xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"
>
	<modelVersion>4.0.0</modelVersion>
	<groupId>maven.sb</groupId>
	<artifactId>maven-sb</artifactId>
	<version>1.0.0</version>
	<packaging>pom</packaging>
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
	</properties>
	<build>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>3.1</version>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-jar-plugin</artifactId>
				<version>3.1.2</version>
				<configuration>
					<archive>
						<manifestFile>${project.build.outputDirectory}/META-INF/MANIFEST.MF</manifestFile>
					</archive>
				</configuration>
			</plugin>
			<plugin>
				<groupId>biz.aQute.bnd</groupId>
				<artifactId>bnd-maven-plugin</artifactId>
				<version>4.2.0</version>
				<executions>
					<execution>
						<goals>
							<goal>bnd-process</goal>
						</goals>
					</execution>
				</executions>
				<dependencies>
					<dependency>
						<groupId>biz.aQute.bnd</groupId>
						<artifactId>biz.aQute.bndlib</artifactId>
						<version>4.2.0</version>
					</dependency>
					<dependency>
						<groupId>com.liferay</groupId>
						<artifactId>com.liferay.ant.bnd</artifactId>
						<version>3.1.0</version>
					</dependency>
				</dependencies>
			</plugin>
			<plugin>
				<groupId>com.liferay</groupId>
				<artifactId>com.liferay.portal.tools.service.builder</artifactId>
				<version>1.0.174</version>
				<configuration>
					<apiDirName>../blade.servicebuilder.api/src/main/java</apiDirName>
					<autoImportDefaultReferences>true</autoImportDefaultReferences>
					<autoNamespaceTables>true</autoNamespaceTables>
					<buildNumberIncrement>true</buildNumberIncrement>
					<hbmFileName>src/main/resources/META-INF/module-hbm.xml</hbmFileName>
					<implDirName>src/main/java</implDirName>
					<inputFileName>service.xml</inputFileName>
					<mergeModelHintsConfigs>src/main/resources/META-INF/portlet-model-hints.xml</mergeModelHintsConfigs>
					<modelHintsFileName>src/main/resources/META-INF/portlet-model-hints.xml</modelHintsFileName>
					<osgiModule>true</osgiModule>
					<propsUtil>com.liferay.blade.samples.servicebuilder.service.util.PropsUtil</propsUtil>
					<resourcesDirName>src/main/resources</resourcesDirName>
					<springFileName>src/main/resources/META-INF/spring/module-spring.xml</springFileName>
					<springNamespaces>beans,osgi</springNamespaces>
					<sqlDirName>src/main/resources/META-INF/sql</sqlDirName>
					<sqlFileName>tables.sql</sqlFileName>
					<testDirName>src/main/test</testDirName>
				</configuration>
			</plugin>
			<plugin>
    			<groupId>com.liferay</groupId>
    			<artifactId>com.liferay.portal.tools.wsdd.builder</artifactId>
    			<version>1.0.8</version>
    			<configuration>
      		  	<inputFileName>service.xml</inputFileName>
     		   	<outputDirName>src/main/java</outputDirName>
      		  	<serverConfigFileName>src/main/resources/server-config.wsdd</serverConfigFileName>
				</configuration>
			</plugin>
		</plugins>
	</build>
	<modules>
		<module>maven-sb-api</module>
		<module>maven-sb-service</module>
	</modules>
</project>
3) Navigate to /maven-sb-service/service.xml and verify that remote-services is set to true in the service.xml

4) Navigate to your project's service directory /maven-sb/maven-sb-service. Build out your service with:

mvn service-builder:build

5) Because we are using a template, the default entity setup is Foo. Navigate to /maven-sb/maven-sb-service/src/main/java/maven/sb/service/impl/FooServiceImpl.java

5) Edit the FooServiceImpl.java file, adding some code AFTER this line

public class FooServiceImpl extends FooServiceBaseImpl {
ADD THIS:

	public String helloWorld(String worldName) {
		return "Hello World: " + worldName;
	}
6) Rebuild the service. Remember, be inside the service directory! /maven-sb/maven-sb-service

mvn service-builder:build

7) Now, we can build out the deployable jar files. This time go to your project's ROOT directory /maven-sb

mvn package

8) Copy both the jar files from

*.api/target/*.jar
and

*.service/target/*.jar
into your Liferay deploy folder.

9) Startup Liferay. (Deploying the .jar files)

10) Navigate to liferay localhost:8080/api/jsonws

11) Click the Context Name dropdown and see that foo is there. Look, the helloWorld api is available!

https://portal.liferay.dev/docs/7-0/tutorials/-/knowledge_base/t/creating-modules-with-blade-cli
https://portal.liferay.dev/docs/7-0/tutorials/-/knowledge_base/t/using-service-builder-in-a-maven-project
https://portal.liferay.dev/docs/7-0/tutorials/-/knowledge_base/t/running-service-builder-and-understanding-the-generated-code
