package Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {
public static void main(String[] args) { // 여기도 소괄호 뒤에 바로 중괄호가 와야 해요.
        
        // 1. 연결 정보 설정 (본인의 환경에 맞게 수정하세요)
        String url = "jdbc:mysql://localhost:3306/company?serverTimezone=UTC";
        String user = "root";       // MySQL 아이디
        String password = "root1234";   // MySQL 비밀번호 (설정한 비밀번호로 변경)

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // 2. MySQL 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 3. 데이터베이스 연결
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ 데이터베이스 연결에 성공했습니다!");

            // 4. SQL 쿼리 준비 및 실행 (수정된 테이블 구조 반영)
            String sql = "SELECT id, name, age, dept, email FROM employee";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            // 5. 결과 데이터 출력
            System.out.println("--- [사원 명부 조회 결과] ---");
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int age = rs.getInt("age");
                String dept = rs.getString("dept");
                String email = rs.getString("email");

                System.out.printf("번호: %d | 이름: %s | 나이: %d | 부서: %s | 이메일: %s%n", 
                                  id, name, age, dept, email);
            }

        } catch (ClassNotFoundException e) {
            System.out.println("❌ 드라이버를 찾을 수 없습니다. 라이브러리 설정을 확인하세요.");
        } catch (SQLException e) {
            System.out.println("❌ SQL 실행 중 오류 발생: " + e.getMessage());
        } finally {
            // 6. 자원 해제 (사용한 통로 닫기)
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
