package com.example.jolup.last;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * UserDAO - 비밀번호 해시(BCrypt) 적용 버전
 * ---------------------------------------
 * - 회원가입 시: 평문 비밀번호를 받아 BCrypt 해시로 변환하여 저장
 * - 로그인 시: DB에 저장된 해시와 비교하여 인증
 *              (기존 평문이 남아 있으면 로그인 성공 시 해시로 자동 교체)
 *
 * 주의:
 * 1. build.gradle에 다음 의존성이 포함되어야 합니다.
 *    implementation 'org.mindrot:jbcrypt:0.4'
 * 2. DB의 users.password 컬럼 길이는 최소 VARCHAR(100) 이상이어야 합니다.
 *    예: ALTER TABLE users MODIFY COLUMN password VARCHAR(100) NOT NULL;
 */

public class UserDAO {

    // BCrypt 해시 강도 (워크팩터)
    private static final int BCRYPT_ROUNDS = 12;

    /**
     * 회원가입: 전달받은 평문 비밀번호를 BCrypt 해시로 변환해 저장
     */
    public boolean registerUser(String userid, String password, String name, String email, String phone) {
        String sql = "INSERT INTO users (userid, password, name, email, phone) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 평문 비밀번호를 해시로 변환
            String hashed = BCrypt.hashpw(password, BCrypt.gensalt(BCRYPT_ROUNDS));

            pstmt.setString(1, userid);
            pstmt.setString(2, hashed);
            pstmt.setString(3, name);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);

            int r = pstmt.executeUpdate();
            return r == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 로그인: 입력한 평문 비밀번호와 DB에 저장된 해시(또는 평문) 비교
     * - bcrypt 형식이면 BCrypt.checkpw로 비교
     * - 평문이면 입력 평문과 비교 후 성공 시 즉시 해시로 업데이트
     */
    public boolean loginUser(String userid, String inputPassword) {
        String stored = getStoredPassword(userid);
        if (stored == null) return false;

        // bcrypt 형식이면 안전하게 해시 비교
        if (isBcryptHash(stored)) {
            return BCrypt.checkpw(inputPassword, stored);
        }

        // 기존 평문 비밀번호일 경우 (마이그레이션 처리)
        if (inputPassword.equals(stored)) {
            // 로그인 성공 → 즉시 해시로 교체
            String newHash = BCrypt.hashpw(inputPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
            updatePasswordHash(userid, newHash);
            return true;
        }

        return false;
    }

    /**
     * 아이디 중복 확인
     */
    public boolean isUserIdExist(String userid) {
        String sql = "SELECT userid FROM users WHERE userid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userid);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 내부 유틸: userid로 저장된 password(해시 또는 평문) 반환
     */
    private String getStoredPassword(String userid) {
        String sql = "SELECT password FROM users WHERE userid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userid);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("password");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 내부 유틸: userid의 password 컬럼에 새 해시로 업데이트
     */
    private void updatePasswordHash(String userid, String newHashed) {
        String sql = "UPDATE users SET password=? WHERE userid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newHashed);
            pstmt.setString(2, userid);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 내부 유틸: 문자열이 bcrypt 해시인지 판별
     */
    private boolean isBcryptHash(String s) {
        if (s == null) return false;
        // bcrypt 해시는 $2a$, $2b$, $2y$ 로 시작
        return s.startsWith("$2a$") || s.startsWith("$2b$") || s.startsWith("$2y$");
    }
    // 아이디 찾기: 이름 + 이메일 + 전화번호 일치 시 userid 반환
    public String findUserId(String name, String email, String phone) {
        String sql = "SELECT userid FROM users WHERE name=? AND email=? AND phone=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name != null ? name.trim() : "");
            pstmt.setString(2, email != null ? email.trim() : "");
            pstmt.setString(3, phone != null ? phone.trim() : "");

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("userid");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    // 본인 확인: userid + name + email + phone 모두 일치하는지
    public boolean verifyUserIdentity(String userid, String name, String email, String phone) {
        String sql = "SELECT 1 FROM users WHERE userid=? AND name=? AND email=? AND phone=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid != null ? userid.trim() : "");
            pstmt.setString(2, name   != null ? name.trim()   : "");
            pstmt.setString(3, email  != null ? email.trim()  : "");
            pstmt.setString(4, phone  != null ? phone.trim()  : "");

            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 임시 비밀번호(평문)를 받아 bcrypt로 해시 저장
    public boolean updatePasswordWithTemp(String userid, String tempPlain) {
        String newHash = BCrypt.hashpw(tempPlain, BCrypt.gensalt(BCRYPT_ROUNDS));
        String sql = "UPDATE users SET password=? WHERE userid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newHash);
            pstmt.setString(2, userid);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
