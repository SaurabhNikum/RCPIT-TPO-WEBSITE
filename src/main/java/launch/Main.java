package launch;

import java.io.File;
import java.io.FileInputStream;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Properties;

import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.WebResourceSet;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.EmptyResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import services.DynamicPropertyResolver;
import uk.org.lidalia.sysoutslf4j.context.SysOutOverSLF4J;


public class Main {

	final private static Logger log = LoggerFactory.getLogger(Main.class);
	private static File root;
    public static File getRootFolder() {
        try {
        	if(root==null) {
	            String runningJarPath = Main.class.getProtectionDomain().getCodeSource().getLocation().toURI().getPath().replaceAll("\\\\", "/");
	            int lastIndexOf = runningJarPath.lastIndexOf("/target/");
	            if (lastIndexOf < 0) {
	                root = new File("");
	            } else {
	                root = new File(runningJarPath.substring(0, lastIndexOf));
	            }
	            log.info("application resolved root folder: " + root.getAbsolutePath());
        	}
            return root;
        } catch (URISyntaxException ex) {
            throw new RuntimeException(ex);
        }
    }

    public static void main(String[] args) throws Exception {
    	SysOutOverSLF4J.sendSystemOutAndErrToSLF4J();
    	log.info("in Main");
        File root = getRootFolder();
        System.setProperty("org.apache.catalina.startup.EXIT_ON_INIT_FAILURE", "true");
        Tomcat tomcat = new Tomcat();
        Path tempPath = Files.createTempDirectory("tomcat-base-dir");
        tomcat.setBaseDir(tempPath.toString());
        
        Properties prop = DynamicPropertyResolver.getProperty();
        
        //System.setProperties(prop);
        String port = prop.getProperty("server.port");
        
        //The port that we should run on can be set into an environment variable
        //Look for that variable and default to 8080 if it isn't there.
        String webPort = System.getenv("PORT");
        if (webPort == null || webPort.isEmpty()) {
            webPort = port;
        }

        tomcat.setPort(Integer.valueOf(webPort));
        File webContentFolder = new File(root.getAbsolutePath(), "WebContent/");
        if (!webContentFolder.exists()) {
            webContentFolder = Files.createTempDirectory("default-doc-base").toFile();
        }
        StandardContext ctx = (StandardContext) tomcat.addWebapp("", webContentFolder.getAbsolutePath());
        //Set execution independent of current thread context classloader (compatibility with exec:java mojo)
        ctx.setParentClassLoader(Main.class.getClassLoader());

        log.info("configuring app with basedir: " + webContentFolder.getAbsolutePath());

        // Declare an alternative location for your "WEB-INF/classes" dir
        // Servlet 3.0 annotation will work
        File additionWebInfClassesFolder = new File(root.getAbsolutePath(), "target/classes");
        WebResourceRoot resources = new StandardRoot(ctx);

        WebResourceSet resourceSet;
        if (additionWebInfClassesFolder.exists()) {
            resourceSet = new DirResourceSet(resources, "/WEB-INF/classes", additionWebInfClassesFolder.getAbsolutePath(), "/");
            log.info("loading WEB-INF resources from as '" + additionWebInfClassesFolder.getAbsolutePath() + "'");
        } else {
            resourceSet = new EmptyResourceSet(resources);
        }
        resources.addPreResources(resourceSet);
        ctx.setResources(resources);

        tomcat.start();
        log.info("WebApp Started on port : {}", webPort);
        tomcat.getServer().await();
    }
}