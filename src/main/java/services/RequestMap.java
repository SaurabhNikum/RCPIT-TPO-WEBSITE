package services;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

public class RequestMap extends HashMap<String, String>{
	
	private static final long serialVersionUID = 1L;
	
	private HttpSession session;

	public String getParameter(String key) {
		return this.get(key);
	}

	public HttpSession getSession() {
		return this.session;
	}
	
	public void setSession(HttpSession session) {
		this.session = session;
	}
	
}
