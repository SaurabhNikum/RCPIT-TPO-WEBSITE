package services;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

@WebServlet("/DownloadExcel")
public class DownloadExcel extends HttpServlet {

	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(DownloadExcel.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);		
		try {
			if (!Auth.getRole(request.getSession()).equals("ADMIN")) {
				if (!Auth.getRole(request.getSession()).equals("COMPANY")) {
					response.sendRedirect("index.jsp");
					return;
				}
			}
			//Here we can chage the order of columns except last two
			String[] columns = new String[] {"ROLL_NO", "NAME", "EMAIL_ID", "BRANCH", "DIV", "MOBILE_NO", "CGPA", "SSC_MARKS", "HSC_MARKS", "ACTIVE_BACKLOG", "GAP", "ADDRESS", "SELECTED_IN", "PACKAGE"};
			
			Connection conn = DBconnect.getConnect();
			Statement statement = conn.createStatement();
			String sql = null;
			if(Auth.getRole(request.getSession()).equals("ADMIN")) {
				if(request.getParameter("type")!=null && request.getParameter("type").toString().equals("PLACED"))
					sql = "SELECT * FROM student WHERE SELECTED_IN is NOT NULL ORDER BY BRANCH ASC, ROLL_NO ASC";
				else
					sql = "SELECT * FROM student ORDER BY BRANCH ASC, ROLL_NO ASC";
			}else {
				sql = "select * from company where name = '" + request.getSession().getAttribute("user") + "'";
				ResultSet resultSet = statement.executeQuery(sql);
				String ssc = "60";
				String hsc = "60";
				String degree = "";
				if (resultSet.next()) {
					ssc=resultSet.getString("SSC");
					hsc=resultSet.getString("HSC_DIPLOMA");
					degree=resultSet.getString("DEGREE");
					sql = "SELECT * FROM STUDENT WHERE SELECTED_IN LIKE '%"+request.getSession().getAttribute("user")+"%' UNION  SELECT * FROM STUDENT WHERE SSC_MARKS >= '"+
							ssc+"' AND HSC_MARKS >=  '"+hsc+"' AND CGPA >=  '"+degree+"' AND SELECTED_IN IS NULL ORDER BY BRANCH ASC, ROLL_NO ASC";
				}else {
					sql = null;
				}
				
			}
			ResultSet resultSet = statement.executeQuery(sql);
			Workbook workbook = new XSSFWorkbook(); // new HSSFWorkbook() for generating `.xls` file
			Sheet sheet = workbook.createSheet("Students");
			Font headerFont = workbook.createFont();
			headerFont.setBold(true);
			headerFont.setFontHeightInPoints((short) 12);
			headerFont.setColor(IndexedColors.BROWN.getIndex());
			CellStyle headerCellStyle = workbook.createCellStyle();
			Row headerRow = sheet.createRow(0);
			int i;
			for (i=0; i < columns.length; i++) {
				if(Auth.getRole(request.getSession()).equals("COMPANY") && columns[i].equals("SELECTED_IN")) {
					headerRow.createCell(i).setCellValue("STATUS");
					headerRow.getCell(i).setCellStyle(headerCellStyle);
					i++;
					break;
				}
				headerRow.createCell(i).setCellValue(columns[i]);
				headerRow.getCell(i).setCellStyle(headerCellStyle);
			}
			int columnCount = i;
			int rowNum = 1;
			while (resultSet.next()) {
				Row row = sheet.createRow(rowNum++);
				for (i = 0; i < columnCount; i++) {
					if(Auth.getRole(request.getSession()).equals("COMPANY") && columns[i].equals("SELECTED_IN")) {
						row.createCell(i).setCellValue((resultSet.getString("SELECTED_IN")!=null && resultSet.getString("SELECTED_IN").contains(request.getSession().getAttribute("user").toString()))?"PLACED":"ELIGIBLE");
						break;
					}
					row.createCell(i).setCellValue(resultSet.getString(columns[i]));
				}
			}
			for (i = 0; i < columnCount; i++) {
				sheet.autoSizeColumn(i);
			}
			response.setContentType("text/xls");
			response.setHeader("Content-disposition", "attachment;filename=" + "Students"+System.currentTimeMillis()+".xlsx");
			try (OutputStream outputStream = response.getOutputStream()) {
			     workbook.write(outputStream);
			}
			workbook.close();
		} catch (Exception e) {
			log.error("Could not download file : {}", e);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

}
