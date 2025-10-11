<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전시</title>
    <link rel="stylesheet" href="css/detail.css">
</head>
<body>
<header class="top-header">
    <div class="nav">
        <a href="detail.jsp" class="exhibition-link">전시</a>
        <div class="right-menu">
            <a href="index.jsp">홈</a>
            <a href="logout.jsp">로그아웃</a>

            <!-- 🌙 다크모드 토글 버튼 -->
            <button id="themeToggle" class="theme-btn">🌙</button>
        </div>
    </div>
</header>


<div class="container">
    <h1 class="page-title">전시</h1>

    <div class="filter-buttons">
        <button class="filter active">전체</button>
        <button class="filter">현재전시</button>
        <button class="filter">예정전시</button>
        <button class="filter">과거전시</button>
    </div>

    <div class="exhibit-grid">
        <div class="exhibit-card">
            <img src="images/anfrka.jpg" alt="전시1">
            <div class="info">
                <h3>졸업이</h3>
                <p>연성</p>
                <p>2025.03.11 – 2025.04.06</p>
            </div>
        </div>

        <div class="exhibit-card">
            <img src="images/ckdpdy.jpg" alt="전시2">
            <div class="info">
                <h3>하고</h3>
                <p>연성</p>
                <p>2025.02.27 – 2025.07.06</p>
            </div>
        </div>

        <div class="exhibit-card">
            <img src="images/dutjtro.jpg" alt="전시3">
            <div class="info">
                <h3>싶어요</h3>
                <p>연성</p>
                <p>2024.09.05 – 2024.12.29</p>
            </div>
        </div>
    </div>
</div>

<!-- 🌙 다크모드 스크립트 -->
<script>
    const toggleBtn = document.getElementById('themeToggle');
    const currentTheme = localStorage.getItem('theme');

    // 페이지 로드 시 저장된 모드 적용
    if (currentTheme === 'dark') {
        document.documentElement.setAttribute('data-theme', 'dark');
        toggleBtn.textContent = '☀️';
    }

    toggleBtn.addEventListener('click', () => {
        const theme = document.documentElement.getAttribute('data-theme');
        if (theme === 'dark') {
            document.documentElement.removeAttribute('data-theme');
            toggleBtn.textContent = '🌙';
            localStorage.setItem('theme', 'light');
        } else {
            document.documentElement.setAttribute('data-theme', 'dark');
            toggleBtn.textContent = '☀️';
            localStorage.setItem('theme', 'dark');
        }
    });
</script>
</body>
</html>
