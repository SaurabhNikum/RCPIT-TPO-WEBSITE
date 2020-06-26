package services;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Collections;
import java.util.Enumeration;
import java.util.LinkedHashSet;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import launch.Main;

public class DynamicPropertyResolver {
	final private static Logger log = LoggerFactory.getLogger(DynamicPropertyResolver.class);
	private final static String[] passwordProperties = new String[] {"tpo.password", "google.account.password", "db.password"};
	private static StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();

	public static Properties getProperty() {
		
		if(!encryptor.isInitialized())
			encryptor.setPassword("google.account.password");
		
		Properties prop = new Properties() {
			private static final long serialVersionUID = 1L;
			private final LinkedHashSet<Object> keyOrder = new LinkedHashSet<>();

		    @Override
		    public synchronized Enumeration<Object> keys() {
		        return Collections.enumeration(keyOrder);
		    }

		    @Override
		    public synchronized Object put(Object key, Object value) {
		        keyOrder.add(key);
		        return super.put(key, value);
		    }
		};

		try {
			prop.load(new FileInputStream(new File(Main.getRootFolder().getAbsolutePath(), "application.properties")));
			prop = reloadPasswordProperties(prop);
			return prop;
		} catch (Exception e) {
			log.error("Something error : {}", e);
		}
		return prop;
	}
	private static Properties setProperties(Properties prop) {
		try {
			prop.store(new FileOutputStream(new File(Main.getRootFolder().getAbsolutePath(), "application.properties")), null);
			return prop;
		} catch (Exception e) {
			log.error("Something error : {}", e);
		}
		return prop;
	}

	
	private static Properties reloadPasswordProperties(Properties prop) {
		int iterator = 0;
		for(String key : passwordProperties) {
			switch(iterator){
				case 0:
						if(prop.getProperty(key).length()!=64) 
							prop.setProperty(key, Utility.getSHA256(prop.getProperty(key)));
						break;
				default:
					if(!StringUtils.isEmpty(prop.getProperty(key))) {
						try{
							encryptor.decrypt(prop.getProperty(key));
						}catch (Exception e) {
							log.info("Encrypting Password Value");
							prop.setProperty(key, getEncryptedPassword(prop.getProperty(key)));
						}
					}
					break;
			}
			iterator++;
		}
		prop = setProperties(prop);
		if(!StringUtils.isEmpty(prop.getProperty(passwordProperties[1])))
			prop.setProperty(passwordProperties[1], getDecryptedPassword(prop.getProperty(passwordProperties[1])));
		if(!StringUtils.isEmpty(prop.getProperty(passwordProperties[2])))
			prop.setProperty(passwordProperties[2], getDecryptedPassword(prop.getProperty(passwordProperties[2])));
		return prop;
	}
	
	private static String getEncryptedPassword(String password){
		return encryptor.encrypt(password);
	}
	
	private static String getDecryptedPassword(String password){
		return encryptor.decrypt(password);
	}
	
}