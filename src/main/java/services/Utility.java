package services;

import java.security.MessageDigest;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.apache.commons.lang3.StringEscapeUtils.escapeHtml4;

public class Utility {

	final private static Logger log = LoggerFactory.getLogger(Utility.class);
	
	public static RequestMap getSafeParams(HttpServletRequest request) {
		RequestMap paramsMap = new RequestMap();
		Enumeration<String> params = request.getParameterNames(); 
		while(params.hasMoreElements()){
		 String paramName = params.nextElement();
		 if(paramName.contains("password")) {
			 paramsMap.put(paramName, getSHA256(request.getParameter(paramName)));
			 continue;
		 }
		 paramsMap.put(paramName, getSafeParam(request.getParameter(paramName)));
		}
		paramsMap.setSession(request.getSession());
		return paramsMap;
	}

	@SuppressWarnings("deprecation")
	public static String getSafeParam(String string) {
		return escapeHtml4(string);
	}
	
	public static String getSHA256(String password) {
        MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(password.getBytes("UTF-8"));
	        StringBuffer hexString = new StringBuffer();
	
	        for (int i = 0; i < hash.length; i++) {
	            String hex = Integer.toHexString(0xff & hash[i]);
	            if(hex.length() == 1) hexString.append('0');
	            hexString.append(hex);
	        }
	        return hexString.toString();
		} catch (Exception e) {
			log.error("Cannot convert password : {}", e);
		}
		return null;
	}
}
