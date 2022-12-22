package sec02.exam01_statement;

import java.sql.*;
import java.io.*;  // ���� �ܼ� â���� ����� �Է��� �޾Ƶ��̱� ���� BufferedReader 

class  JDBC_Insert_org{
public static void main(String[] args) {

  String driver = "oracle.jdbc.driver.OracleDriver";
  String url = "jdbc:oracle:thin:@localhost:1521:XE";	

  Connection con = null;
  Statement stmt = null;

 // ResultSet  rs   = null;
  String sql;

   String name, email, tel, no ;
  
     try{
    	 // 1. jdbc driver�� jvm�ε� ��Ŵ
      Class.forName(driver);
      
      // 2. Connection ��ü�� ��´�
      con = DriverManager.getConnection(url, "SCOTT", "TIGER" );
      stmt= con.createStatement(); // Statement ��ü ����

      //---JDBC_Insert �߰��� ����-------
      // ���̺� �߰��� ������ ���� �ܼ� â���� ������� �Է��� �޵��� �Ѵ�.
      BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
      // �ܼ�(����Ʈ) -> ��ǲ��Ʈ��(����) -> ���۷� �б�

      System.out.println(" customer ���̺� �� �Է��ϱ� .....");
      System.out.print(" ��ȣ �Է�: ");
      no = br.readLine(); // �Լ��� ���ڿ��� �о��
      System.out.print(" �̸� �Է�: ");
      name = br.readLine();            //���̺� �߰��� name �ʵ� ���� �Է� ����
      System.out.print(" �̸��� �Է�: ");
      email = br.readLine();             //���̺� �߰��� email �ʵ� ���� �Է� ����
      System.out.print(" ��ȭ��ȣ �Է�: ");
      tel = br.readLine();               //���̺� �߰��� tel �ʵ� ���� �Է� ����
      
      // INSERT �������� �ۼ�
      sql = "INSERT into customer(no, name, email, tel) values " ;
      sql += "(" + no + ",'" + name +"','" + email +"','"+ tel +"')" ;
      
      //Statement ��ü�� executeUpdate(sql) �޼��带 �̿��� 
      // 4. stmt.executeUpdate()�� sql�� ����
      int res = stmt.executeUpdate(sql) ;  //�����ͺ��̽� ���Ͽ� ���ο� ���� �߰���Ŵ
	  if(res == 1){
		 System.out.println(" Data insert success!! ");
      }else{
		System.out.println(" Data insert failed ");
	  }
	}
    catch(Exception e){
      System.out.println("�����ͺ��̽� ���� ����!");
    }
    finally{
      try{
 //       if( rs != null )   rs.close();  
    	// 5. resource(stmt,con)�� �ݴ´�.  
        if( stmt != null ) stmt.close();
        if( con != null )  con.close();
      }
      catch(Exception e){ 
        System.out.println( e.getMessage());
      }
    }
  }
} 
