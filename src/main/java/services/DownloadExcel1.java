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

@WebServlet("/DownloadExcel1")
public class DownloadExcel1 extends HttpServlet {

	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(DownloadExcel1.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);				
		try {
			if (!Auth.getRole(request.getSession()).equals("ADMIN")) {
				
					response.sendRedirect("index.jsp");
					return;
				}
			
			//Here we can chage the order of columns except last two
			String[] columns = new String[] {"NAME", "INFORMATION", "EMAIL_ID", "DRIVE_DATE", "DRIVE_LOCATION", "PACKAGE", "DEGREE", "HSC_DIPLOMA", "SSC", "ACTIVE_BACKLOG", "GAP", "SELECTION_PROCESS", "REQUIREMENT", "ADDRESS", "CONTACT_NUMBER", "ELIGIBLE_BRANCH"};
			
			Connection conn = DBconnect.getConnect();
			Statement statement = conn.createStatement();
			String sql = null;
			if(Auth.getRole(request.getSession()).equals("ADMIN")) {
					sql = "SELECT * FROM company";
			}
			
			ResultSet resultSet = statement.executeQuery(sql);
			Workbook workbook = new XSSFWorkbook(); // new HSSFWorkbook() for generating `.xls` file
			Sheet sheet = workbook.createSheet("Company");
			Font headerFont = workbook.createFont();
			headerFont.setBold(true);
			headerFont.setFontHeightInPoints((short) 12);
			headerFont.setColor(IndexedColors.BROWN.getIndex());
			CellStyle headerCellStyle = workbook.createCellStyle();
			Row headerRow = sheet.createRow(0);
			int i;
			for (i=0; i < columns.length; i++) {
				headerRow.createCell(i).setCellValue(columns[i]);
				headerRow.getCell(i).setCellStyle(headerCellStyle);
			}
			int rowNum = 1;
			while (resultSet.next()) {
				Row row = sheet.createRow(rowNum++);
				for (i = 0; i < columns.length; i++) {
					row.createCell(i).setCellValue(resultSet.getString(columns[i]));
				}
			}
			for (i = 0; i < columns.length; i++) {
				sheet.autoSizeColumn(i);
			}
			response.setContentType("text/xls");
			response.setHeader("Content-disposition", "attachment;filename=" + "CompanyDetails"+System.currentTimeMillis()+".xlsx");
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
