package sec02.exam01_statement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
// import java.sql.*; ������ �������� �ѹ��� �̷��� ���� ��

public class JDBC_Insert {

	public static void main(String[] args) {
		// java���� oracle db ���� ���
		// 1. ������Ʈ�� ojdbc.jar ���̺귯���� ���Խ�Ų��.(�ش� ������Ʈ �����н� -> ����)
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE"; // � ������ � �ν��Ͻ� ����
		String sql;
		Connection con = null;
		Statement stmt = null;
		
		// 2. oracleDriver Ŭ������ JVM�� �ε��Ų��. (Class.forName(...))
		try {
			Class.forName(driver); // driver�� �ּҸ� �߸������� �ֱ� ������ ����ó���� ���
			System.out.println("JDBC Driver Loading ����~");
			
			// 3. java.sql.DriverManager.getConnection()�� Connection ��ü�� ����.
			//    Connection con = DriverMAnager.getConnection(url, 'SCOTT', 'TIGER');
			con = DriverManager.getConnection(url, "SCOTT", "TIGER");
			System.out.println("�����ͺ��̽� ���� ����~");
			
			// 4. Connection ��ü���� Statement ��ü�� ��´�.
			stmt = con.createStatement();
			sql = "INSERT INTO CUSTOMER(NO, NAME, EMAIL, TEL) VALUES";
			sql += "(2, '�ҿ�', 'lskfk@ndk.nfk', '0112444222')";
			
			// 5. Statement.executeQuery()�� sql���� �����Ѵ�.
			int res = stmt.executeUpdate(sql); // int������ �ٲ���
			// executeUpdate : INSERT / DELETE / UPDATE ���� ���������� �ݿ��� ���ڵ��� �Ǽ��� ��ȯ�մϴ�.
			if(res==1) {
				System.out.println("������ �Է� ����");
			} else {
				System.out.println("������ �Է� ����");
			}
			
		} catch (Exception e) {
			System.out.println("JDBC Driver Loading ���Ф̤�");
			e.printStackTrace();
		} finally {
			try {
				// 6. Statement.Close(), Connection.Close()
				stmt.close();
				con.close(); // �굵 ���� �߻� �� ���� �־ ó������
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		
		

	}

}
