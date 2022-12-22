package sec01.exam01_jdbc;

import java.sql.*;

public class JDBC_Connect01 {

	public static void main(String[] args) {

		/** ORACLE JDBC Driver Test ***************************/
		String driver = "oracle.jdbc.driver.OracleDriver";
		// 자바에서 DB를 연결하기 위한 인터페이스 모듈
		// OJDBC7이 있어야함
		// 오른쪽 버튼 BUILE PATH EDIT OJDBC7 넣어주고, DEFALUT WORKSPACE~~로 설정
		/******************************************************/

		/** My-SQL JDBC Driver Test **************************/
		// String driver ="com.mysql.jdbc.Driver";
		/*****************************************************/

		try {
			Class.forName(driver); // 클래스 객체를 생성
			System.out.println("JDBC Driver Loading 성공~!!");

		} catch (Exception e) {
			System.out.println("JDBC Driver Loading 실패~!!");
			e.printStackTrace();
		}
	}
}
