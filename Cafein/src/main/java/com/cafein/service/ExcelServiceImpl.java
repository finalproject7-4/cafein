package com.cafein.service;

import java.io.FileOutputStream;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class ExcelServiceImpl implements ExcelService {

	private static final Logger logger = LoggerFactory.getLogger(ExcelServiceImpl.class);

	@Override
	public void ExcelConverter(List<List<String>> data, String filePath) throws Exception {
	    Workbook workbook = new XSSFWorkbook();
	    FileOutputStream outputStream = new FileOutputStream(filePath);

	    Sheet sheet = workbook.createSheet("Data");

	    int rowNum = 0; // 헤더가 있는 경우 rowNum을 1부터 시작
	    for (List<String> rowData : data) {
	        if (rowData == null) {
	            continue;
	        }

	        Row row = sheet.createRow(rowNum++);
	        int colNum = 0;
	        for (String cellData : rowData) {
	            if (cellData == null) {
	                continue;
	            }

	            Cell cell = row.createCell(colNum++);
	            cell.setCellValue(cellData);
	        }
	    }

	    workbook.write(outputStream);
	    workbook.close();
	}
}
