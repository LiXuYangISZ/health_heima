package com.rg.test;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;

import java.io.*;

// public class POITest {
//     @Test
//     public void test01() throws IOException {
//         //加载指定文件,创建一个Excel对象(工作簿)
//         XSSFWorkbook excel = new XSSFWorkbook(new FileInputStream(new File("d:\\poi.xlsx")));
//         //读取Excel文件第一个Sheet标签页
//         XSSFSheet sheet = excel.getSheetAt(0);
//         //遍历sheet标签页,获得每一行数据
//         for (Row row : sheet) {
//             //遍历行,获得每一个单元格数据
//             for (Cell cell : row) {
//                 System.out.println(cell.getStringCellValue());
//             }
//
//         }
//         //关闭资源
//         excel.close();
//
//     }
//
//     @Test
//     public void test02() throws IOException {
//         //加载指定文件,创建一个Excel对象(工作簿)
//         XSSFWorkbook excel = new XSSFWorkbook(new FileInputStream(new File("d:\\poi.xlsx")));
//         XSSFSheet sheet = excel.getSheetAt(0);
//         //获得当前工作表中最后一个行号,需要注意,行号是从0开始
//         int lastRowNum = sheet.getLastRowNum();//1
//         for(int i = 0;i <= lastRowNum;i++){
//             XSSFRow row = sheet.getRow(i);//根据行号获得每一行
//             //获得当前行最后一个单元格索引
//             short lastCellNum = row.getLastCellNum();//2
//             for(int j = 0;j < lastCellNum;j++){//
//                 XSSFCell cell = row.getCell(j);//根据单元格索引获得单元格对象
//                 System.out.println(cell.getStringCellValue());
//             }
//         }
//         //关闭资源
//         excel.close();
//     }
//
//     // 使用POI向Excel文件中写入数据,并且通过输出流将创建的Excel文件保存到本地磁盘
//     @Test
//     public void test3() throws IOException {
//         //在内存中创建一个Excel对象(工作簿)
//         XSSFWorkbook excel = new XSSFWorkbook();
//         //创建一个工作表对象
//         XSSFSheet sheet = excel.createSheet("河科大大李子");
//         //在工作表中创建行对象
//         XSSFRow title = sheet.createRow(0);
//         //在行中创建单元格对象
//         title.createCell(0).setCellValue("姓名");
//         title.createCell(1).setCellValue("地址");
//         title.createCell(2).setCellValue("年龄");
//
//         XSSFRow dataRow = sheet.createRow(1);
//         dataRow.createCell(0).setCellValue("小明");
//         dataRow.createCell(1).setCellValue("背景");
//         dataRow.createCell(2).setCellValue("20");
//
//         //创建一个输出流,通过输出流将内存中的Excel文件写到磁盘.
//         FileOutputStream out = new FileOutputStream(new File("d:\\hello.xlsx"));
//         excel.write(out);
//         out.flush();
//         excel.close();
//
//     }
//
//
// }
