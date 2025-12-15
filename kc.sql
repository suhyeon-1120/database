--member 테이블
CREATE TABLE MEMBER (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(200),
    join_date DATE NOT NULL
);

--child CREATE TABLE CHILD (
    child_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1),
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

--reservation 테이블
CREATE TABLE RESERVATION (
    reservation_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    reservation_time TIMESTAMP NOT NULL,
    people_count INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

--ticket 테이블
CREATE TABLE TICKET (
    ticket_id INT PRIMARY KEY,
    reservation_id INT NOT NULL,
    child_id INT NOT NULL,
    entry_time TIMESTAMP,
    exit_time TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES RESERVATION(reservation_id),
    FOREIGN KEY (child_id) REFERENCES CHILD(child_id)
);

--product 테이블
CREATE TABLE PRODUCT (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    price INT NOT NULL,
    category VARCHAR(100),
    stock INT NOT NULL
);

--order 테이블
CREATE TABLE "ORDER" (
    order_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    order_time TIMESTAMP NOT NULL,
    total_amount INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

--order_detail 테이블
CREATE TABLE ORDER_DETAIL (
    order_detail_id INT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price INT NOT NULL,
    PRIMARY KEY (order_detail_id, order_id), -- 복합 키 설정
    FOREIGN KEY (order_id) REFERENCES "ORDER"(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

--=====================DML===========================================
INSERT INTO MEMBER (member_id, name, phone, email, join_date) VALUES (1, '김철수', '010-1234-5678', 'chulsoo@example.com', DATE '2025-01-10');
INSERT INTO MEMBER (member_id, name, phone, email, join_date) VALUES (2, '이영희', '010-9876-5432', 'younghee@example.com', DATE '2025-03-22');
INSERT INTO MEMBER (member_id, name, phone, email, join_date) VALUES (3, '박민수', NULL, 'minsu@example.com', DATE '2025-05-01');

INSERT INTO CHILD (child_id, member_id, name, birth_date, gender) VALUES (101, 1, '김민지', DATE '2019-07-15', 'F');
INSERT INTO CHILD (child_id, member_id, name, birth_date, gender) VALUES (102, 1, '김준혁', DATE '2022-04-20', 'M');
INSERT INTO CHILD (child_id, member_id, name, birth_date, gender) VALUES (201, 2, '이서연', DATE '2018-11-30', 'F');

INSERT INTO RESERVATION (reservation_id, member_id, reservation_time, people_count, status, amount) VALUES (1001, 1, TIMESTAMP '2025-12-10 14:00:00', 3, '확정', 30000);
INSERT INTO RESERVATION (reservation_id, member_id, reservation_time, people_count, status, amount) VALUES (1002, 2, TIMESTAMP '2025-12-11 10:30:00', 2, '확정', 20000);
INSERT INTO RESERVATION (reservation_id, member_id, reservation_time, people_count, status, amount) VALUES (1003, 1, TIMESTAMP '2025-12-05 16:00:00', 4, '취소', 40000);

-- 예약 1001 (김철수: 자녀 2명 + 성인 1명)
INSERT INTO TICKET (ticket_id, reservation_id, child_id, entry_time, exit_time) VALUES (5001, 1001, 101, TIMESTAMP '2025-12-10 14:15:00', NULL); -- 김민지 입장
INSERT INTO TICKET (ticket_id, reservation_id, child_id, entry_time, exit_time) VALUES (5002, 1001, 102, TIMESTAMP '2025-12-10 14:15:00', NULL); -- 김준혁 입장

-- 예약 1002 (이영희: 자녀 1명 + 성인 1명)
INSERT INTO TICKET (ticket_id, reservation_id, child_id, entry_time, exit_time) VALUES (5003, 1002, 201, TIMESTAMP '2025-12-11 10:45:00', NULL); -- 이서연 입장

-- 이미 퇴장한 티켓
INSERT INTO TICKET (ticket_id, reservation_id, child_id, entry_time, exit_time) VALUES (5004, 1003, 101, TIMESTAMP '2025-12-05 16:10:00', TIMESTAMP '2025-12-05 18:00:00');

INSERT INTO PRODUCT (product_id, product_name, price, category, stock) VALUES (201, '오렌지 주스', 4500, '음료', 150);
INSERT INTO PRODUCT (product_id, product_name, price, category, stock) VALUES (202, '프렌치프라이', 6000, '스낵', 80);
INSERT INTO PRODUCT (product_id, product_name, price, category, stock) VALUES (203, '어린이 도시락', 12000, '식사', 50);

INSERT INTO "ORDER" (order_id, member_id, order_time, total_amount) VALUES (3001, 3, TIMESTAMP '2025-12-10 15:30:00', 10500);

-- 오렌지 주스 (ID: 201) 1개, 프렌치프라이 (ID: 202) 1개
INSERT INTO ORDER_DETAIL (order_detail_id, order_id, product_id, quantity, unit_price) VALUES (4001, 3001, 201, 1, 4500);
INSERT INTO ORDER_DETAIL (order_detail_id, order_id, product_id, quantity, unit_price) VALUES (4002, 3001, 202, 1, 6000);