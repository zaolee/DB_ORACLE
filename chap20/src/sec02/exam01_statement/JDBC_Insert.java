package sec02.exam01_statement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
// import java.sql.*; 일일히 쓰지말고 한번에 이렇게 쓰면 돼

public class JDBC_Insert {

	public static void main(String[] args) {
		// java에서 oracle db 연결 방법
		// 1. 프로젝트에 ojdbc.jar 라이브러리를 포함시킨다.(해당 프로젝트 빌드패스 -> 에딧)
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 어떤 서버에 어떤 인스턴스 쓸지
		String sql;
		Connection con = null;
		Statement stmt = null;
		
		// 2. oracleDriver 클래스를 JVM에 로드시킨다. (Class.forName(...))
		try {
			Class.forName(driver); // driver의 주소를 잘못쓸수도 있기 때문에 예외처리문 사용
			System.out.println("JDBC Driver Loading 성공~");
			
			// 3. java.sql.DriverManager.getConnection()로 Connection 객체를 생성.
			//    Connection con = DriverMAnager.getConnection(url, 'SCOTT', 'TIGER');
			con = DriverManager.getConnection(url, "SCOTT", "TIGER");
			System.out.println("데이터베이스 연결 성공~");
			
			// 4. Connection 객체에서 Statement 객체를 얻는다.
			stmt = con.createStatement();
			sql = "INSERT INTO CUSTOMER(NO, NAME, EMAIL, TEL) VALUES";
			sql += "(2, '소연', 'lskfk@ndk.nfk', '0112444222')";
			
			// 5. Statement.executeQuery()로 sql문을 실행한다.
			int res = stmt.executeUpdate(sql); // int형으로 바꿔줌
			// executeUpdate : INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환합니다.
			if(res==1) {
				System.out.println("데이터 입력 성공");
			} else {
				System.out.println("데이터 입력 실패");
			}
			
		} catch (Exception e) {
			System.out.println("JDBC Driver Loading 실패ㅜㅜ");
			e.printStackTrace();
		} finally {
			try {
				// 6. Statement.Close(), Connection.Close()
				stmt.close();
				con.close(); // 얘도 예외 발생 할 수도 있어서 처리해줌
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		
		

	}

}
