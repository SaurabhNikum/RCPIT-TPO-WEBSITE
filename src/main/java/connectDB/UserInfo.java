package connectDB;

public class UserInfo
{
	static String RollNo;
	static String email;
	static float ssc;
	static float hsc;
	static float cgpa;
	static String name;
	static int activebacklogs;
	static int gaps;
	public static String getName() {
		return name;
	}
	public static void setName(String name) {
		UserInfo.name = name;
	}
	public static int getActiveBacklogs() {
		return activebacklogs;
	}
	public static void setActiveBacklogs(int activebacklogs) {
		UserInfo.activebacklogs = activebacklogs;
	}
	public static int getGaps() {
		return gaps;
	}
	public static void setGaps(int gaps) {
		UserInfo.gaps = gaps;
	}
	public static float getSsc() {
		return ssc;
	}
	public static void setSsc(float ssc) {
		UserInfo.ssc = ssc;
	}
	public static float getHsc() {
		return hsc;
	}
	public static void setHsc(float hsc) {
		UserInfo.hsc = hsc;
	}
	public static float getCgpa() {
		return cgpa;
	}
	public static void setCgpa(float cgpa) {
		UserInfo.cgpa = cgpa;
	}
	public static String getEmail(){
		return email;
	}
	public static void setEmail(String email){
		UserInfo.email = email;
	}
	public static String getRollNo() {
		return RollNo;
	}

	public static void setRollNo(String RollNo) {
		UserInfo.RollNo = RollNo;
	}
	static String Cname;
	
	public static String getCname() {
		return Cname;
	}
	
	public static void setCname(String Cname) {
		UserInfo.Cname = Cname;
	}
	
	static String[] Branch;
	
	public static String[] getBranch() {
		return Branch;
	}
	
	public static void setBranch(String[] Branch) {
		UserInfo.Branch = Branch;
	}	
	
	}

