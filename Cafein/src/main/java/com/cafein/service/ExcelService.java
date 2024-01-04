package com.cafein.service;

import java.util.List;

public interface ExcelService {
	
	public void ExcelConverter(List<List<String>> data, String filePath) throws Exception;

}
