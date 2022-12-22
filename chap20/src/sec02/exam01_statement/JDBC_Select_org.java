package sec02.exam01_statement;

import java.sql.*;

class  JDBC_Select_org{
  public static void main(String[] args)  {

	String driver = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@localhost:1521:XE";

    Connection con  = null;
    Statement  stmt = null;
    //---JDBC_Select �߰��� ���� -------
    ResultSet  rs   = null;
	int no = 0; 
    String name, email, tel;  //�����ͺ��̽����� ���� �ʵ尪 ������ ���� ����
    String sql;               //SQL���� ������ ���� ����

    try{
      // 1. jdbc ���̺귯���� �ε��Ѵ�.
      Class.forName(driver);
      
      // 2. Connection ��ü�� ��´�
      con = DriverManager.getConnection(url, "SCOTT", "TIGER" );
      
      // 3. Statement ��ü�� ��´�.
      stmt= con.createStatement();
      //---JDBC_Select �߰��� ���� -------
      sql = "SELECT * FROM customer";
      System.out.printf("��ȣ \t �̸� \t\t �̸��� \t\t ��ȭ��ȣ \n");
      System.out.printf("-----------------------------------------------------------------\n");
      
      // 4. ResultSet rs = stmt.executeQuery()�� select���� �����Ѵ�.
      //	��� �������̶� ResultSet Ÿ������ ��.
      //	int res = stmt.executeUpdate()�� insert/ update/ delete���� ����
      rs = stmt.executeQuery(sql);  //����� ���ڵ带 ������

      while( rs.next() ){ // Ŀ���� ���� �ϳ��� ���������� 1�� -> 2�� -> ...
		 no = rs.getInt("no"); // int������
         name = rs.getString("name"); // String������..  
         email = rs.getString("email");     
         tel   = rs.getString("tel"); 
        System.out.printf(" %d \t %s \t %s \t %s\n", no, name,email,tel);
      } 
    }
    catch(Exception e){
      System.out.println("�����ͺ��̽� ���� ����!");
    }
    finally{
      try{//rs, stmt, con ��ü�� close() �޼��带 ȣ���� ����
        if( rs != null )      rs.close();        
        if( stmt != null )    stmt.close();
        if( con != null )     con.close();
      }
      catch(Exception e){
        System.out.println( e.getMessage( ));  
      }
    }
  }
}  

