ALTER TABLE users MODIFY COLUMN password VARCHAR(100) NOT NULL;
ALTER TABLE users ADD CONSTRAINT uq_users_userid UNIQUE (userid);

이거 2개 console에 ㄱㄱ하고 ㄱㄱ

지금 한거가 아이디 비밀번호찾기인데 비번찾기가 좀 꼬임
