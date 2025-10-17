package com.example.jolup.last;

import java.util.regex.Pattern;

public class ValidationUtil {

    // 아이디 검증: 8~12자, 영문과 숫자만
    public static boolean isValidUserId(String userid) {
        if (userid == null || userid.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches("^[a-zA-Z0-9]{8,12}$", userid);
    }

    // 비밀번호 검증: 8~16자, 영문, 숫자, 특수문자 모두 포함
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8 || password.length() > 16) {
            return false;
        }

        boolean hasLetter = Pattern.compile("[a-zA-Z]").matcher(password).find();
        boolean hasDigit = Pattern.compile("[0-9]").matcher(password).find();
        boolean hasSpecial = Pattern.compile("[!@#$%^&*(),.?\":{}|<>]").matcher(password).find();

        return hasLetter && hasDigit && hasSpecial;
    }

    // 이름 검증: 한글 2~10자 또는 영문 2~30자
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        // 한글 패턴
        if (Pattern.matches("^[가-힣]{2,10}$", name)) {
            return true;
        }

        // 영문 패턴 (공백 포함)
        if (Pattern.matches("^[a-zA-Z\\s]{2,30}$", name.trim())) {
            return true;
        }

        return false;
    }

    // 이메일 검증
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        String emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return Pattern.matches(emailPattern, email);
    }

    // 전화번호 검증: 010-0000-0000 형식
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }

        // 하이픈 포함 형식
        String phonePattern = "^01[016789]-\\d{3,4}-\\d{4}$";
        return Pattern.matches(phonePattern, phone);
    }

    // XSS 방지를 위한 HTML 이스케이프
    public static String escapeHtml(String input) {
        if (input == null) {
            return null;
        }

        return input.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;")
                .replace("/", "&#x2F;");
    }

    // SQL Injection 방지를 위한 특수문자 체크 (PreparedStatement 사용 시 불필요하지만 추가 보안)
    public static boolean containsSqlSpecialChars(String input) {
        if (input == null) {
            return false;
        }

        String[] sqlChars = {"--", "/*", "*/", "xp_", "sp_", "0x", "exec", "execute",
                "select", "insert", "update", "delete", "drop", "create",
                "alter", "union", "script"};

        String lowerInput = input.toLowerCase();
        for (String sqlChar : sqlChars) {
            if (lowerInput.contains(sqlChar)) {
                return true;
            }
        }

        return false;
    }

    // 비밀번호 강도 체크
    public static String getPasswordStrength(String password) {
        if (password == null || password.length() < 8) {
            return "weak";
        }

        int strength = 0;

        // 길이 체크
        if (password.length() >= 10) strength++;
        if (password.length() >= 12) strength++;

        // 문자 종류 체크
        if (Pattern.compile("[a-z]").matcher(password).find()) strength++;
        if (Pattern.compile("[A-Z]").matcher(password).find()) strength++;
        if (Pattern.compile("[0-9]").matcher(password).find()) strength++;
        if (Pattern.compile("[!@#$%^&*(),.?\":{}|<>]").matcher(password).find()) strength++;

        if (strength <= 2) return "weak";
        else if (strength <= 4) return "medium";
        else return "strong";
    }
}