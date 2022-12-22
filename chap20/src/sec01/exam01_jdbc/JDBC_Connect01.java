package sec01.exam01_jdbc;

import java.sql.*;

public class JDBC_Connect01 {

	public static void main(String[] args) {

		/** ORACLE JDBC Driver Test ***************************/
		String driver = "oracle.jdbc.driver.OracleDriver";
		// �ڹٿ��� DB�� �����ϱ� ���� �������̽� ���
		// OJDBC7�� �־����
		// ������ ��ư BUILE PATH EDIT OJDBC7 �־��ְ�, DEFALUT WORKSPACE~~�� ����
		/******************************************************/

		/** My-SQL JDBC Driver Test **************************/
		// String driver ="com.mysql.jdbc.Driver";
		/*****************************************************/

		try {
			Class.forName(driver); // Ŭ���� ��ü�� ����
			System.out.println("JDBC Driver Loading ����~!!");

		} catch (Exception e) {
			System.out.println("JDBC Driver Loading ����~!!");
			e.printStackTrace();
		}
	}
}
