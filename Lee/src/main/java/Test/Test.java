package Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Test {
public static void main(String[] args) { // 여기도 소괄호 뒤에 바로 중괄호가 와야 해요.
        
        // 1. 연결 정보 설정 (본인의 환경에 맞게 수정하세요)
	String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
    String user = "root";       // MySQL 계정명
    String password = "root1234";   // MySQL 비밀번호

    Connection conn = null;

    try {
        // 2. JDBC 드라이버 로드 (MySQL 8.0 이상 기준)
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 3. 실제 연결 시도
        conn = DriverManager.getConnection(url, user, password);
        
        if (conn != null) {
            System.out.println("✅ MySQL 연결 성공! 통로가 열렸습니다.");
        }

    } catch (ClassNotFoundException e) {
        System.out.println("❌ 드라이버를 찾을 수 없습니다. (jar 파일 확인 필요)");
    } catch (SQLException e) {
        System.out.println("❌ 연결 실패: " + e.getMessage());
    } finally {
        // 4. 사용이 끝난 연결은 꼭 닫아줘야 합니다.
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
  }
}
