package services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Properties {
	final private static Logger log = LoggerFactory.getLogger(Properties.class);
	private static String uploadDir = null;
	private static String TPOEMail = null;
	private static String TPOPassword = null;
	private static String GoogleAccountEmail = null;
	private static String GoogleAccountPassword = null;

	private Properties() {
		java.util.Properties prop = DynamicPropertyResolver.getProperty();
		Properties.uploadDir = prop.getProperty("upload.dir");
		Properties.TPOEMail = prop.getProperty("tpo.email");
		Properties.TPOPassword = prop.getProperty("tpo.password");
		Properties.GoogleAccountEmail = prop.getProperty("google.account.email");
		Properties.GoogleAccountPassword = prop.getProperty("google.account.password");
	}

	public static String getDir() {
		if (uploadDir == null) {
			try {
				new Properties();
				return Properties.uploadDir;
			} catch (Exception e) {
				log.error("Something error : {}", e);
			}
		}
		return Properties.uploadDir;
	}

	public static String getTPOEMail() {
		if (TPOEMail == null) {
			try {
				new Properties();
				return Properties.TPOEMail;
			} catch (Exception e) {
				log.error("Something error : {}", e);
			}
		}
		return Properties.TPOEMail;
	}

	public static String getTPOPassword() {
		if (TPOPassword == null) {
			try {
				new Properties();
				return Properties.TPOPassword;
			} catch (Exception e) {
				log.error("Something error : {}", e);
			}
		}
		return Properties.TPOPassword;
	}

	public static String getGoogleAccountEmail() {
		if (GoogleAccountEmail == null) {
			try {
				new Properties();
				return Properties.GoogleAccountEmail;
			} catch (Exception e) {
				log.error("Something error : {}", e);
			}
		}
		return Properties.GoogleAccountEmail;
	}

	public static String getGoogleAccountPassword() {
		if (GoogleAccountPassword == null) {
			try {
				new Properties();
				return Properties.GoogleAccountPassword;
			} catch (Exception e) {
				log.error("Something error : {}", e);
			}
		}
		return Properties.GoogleAccountPassword;
	}

}
