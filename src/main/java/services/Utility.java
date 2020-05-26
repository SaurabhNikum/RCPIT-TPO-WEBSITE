package services;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import static org.apache.commons.lang3.StringEscapeUtils.escapeHtml4;

public class Utility {

	public static RequestMap getSafeParams(HttpServletRequest request) {
		RequestMap paramsMap = new RequestMap();
		Enumeration<String> params = request.getParameterNames(); 
		while(params.hasMoreElements()){
		 String paramName = params.nextElement();
		 paramsMap.put(paramName, getSafeParam(request.getParameter(paramName)));
		}
		paramsMap.setSession(request.getSession());
		return paramsMap;
	}

	@SuppressWarnings("deprecation")
	public static String getSafeParam(String string) {
		return escapeHtml4(string);
	}
}
