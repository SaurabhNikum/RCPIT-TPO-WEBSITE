package services;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import launch.Main;

public class DynamicPropertyResolver {
	final private static Logger log = LoggerFactory.getLogger(DynamicPropertyResolver.class);
	public static Properties getProperty() {

		Properties prop = new Properties();
		try {
			prop.load(new FileInputStream(new File(Main.getRootFolder().getAbsolutePath(), "application.properties")));
			return prop;
		} catch (Exception e) {
			log.error("Something error : {}", e);
		}
		return prop;
	}
}
