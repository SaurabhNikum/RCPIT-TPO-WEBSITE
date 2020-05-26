package services;

import javax.servlet.http.HttpSession;

public class Auth {

	public static boolean isValidUser(HttpSession session) {
		return session.getAttribute("user") != null ? true : false;
	}

	public static String getRole(HttpSession session) {
		return session.getAttribute("role") == null ? "" : session.getAttribute("role").toString();
	}

}
