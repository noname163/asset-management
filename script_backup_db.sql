SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;

SET default_tablespace = '';


CREATE TABLE public.asset_tbl (
    id bigint NOT NULL,
    asset_code character varying(255),
    installed_date timestamp without time zone,
    is_deleted boolean,
    location character varying(255),
    asset_name character varying(255),
    specification text,
    status character varying(255),
    category_id integer
);
CREATE SEQUENCE public.asset_tbl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.asset_tbl_id_seq OWNED BY public.asset_tbl.id;

CREATE TABLE public.assign_asset_tbl (
    id bigint NOT NULL,
    assigned_date timestamp without time zone,
    is_deleted boolean,
    note text,
    status character varying(255),
    asset_id bigint,
    assigned_by_user_id bigint,
    assigned_to_user_id bigint
);
CREATE SEQUENCE public.assign_asset_tbl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.assign_asset_tbl_id_seq OWNED BY public.assign_asset_tbl.id;

CREATE TABLE public.category_tbl (
    id integer NOT NULL,
    name character varying(255),
    prefix_asset_code character varying(255)
);
CREATE SEQUENCE public.category_tbl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.category_tbl_id_seq OWNED BY public.category_tbl.id;

CREATE TABLE public.return_asset_tbl (
    id bigint NOT NULL,
    is_deleted boolean,
    returned_date timestamp without time zone,
    status character varying(255),
    asset_id bigint,
    assign_asset_id bigint,
    accepted_user_id bigint,
    requested_user_id bigint
);
CREATE SEQUENCE public.return_asset_tbl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.return_asset_tbl_id_seq OWNED BY public.return_asset_tbl.id;

CREATE TABLE public.user_tbl (
    id bigint NOT NULL,
    date_of_birth timestamp without time zone,
    first_name character varying(255),
    gender character varying(255),
    is_deleted boolean,
    joined_date timestamp without time zone,
    last_name character varying(255),
    location character varying(255),
    password character varying(255),
    staff_code character varying(255),
    type character varying(255),
    user_name character varying(255),
    is_first_login boolean
);
CREATE SEQUENCE public.user_tbl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.user_tbl_id_seq OWNED BY public.user_tbl.id;

ALTER TABLE ONLY public.asset_tbl ALTER COLUMN id SET DEFAULT nextval('public.asset_tbl_id_seq'::regclass);
ALTER TABLE ONLY public.assign_asset_tbl ALTER COLUMN id SET DEFAULT nextval('public.assign_asset_tbl_id_seq'::regclass);
ALTER TABLE ONLY public.category_tbl ALTER COLUMN id SET DEFAULT nextval('public.category_tbl_id_seq'::regclass);
ALTER TABLE ONLY public.return_asset_tbl ALTER COLUMN id SET DEFAULT nextval('public.return_asset_tbl_id_seq'::regclass);
ALTER TABLE ONLY public.user_tbl ALTER COLUMN id SET DEFAULT nextval('public.user_tbl_id_seq'::regclass);

ALTER TABLE ONLY public.asset_tbl
    ADD CONSTRAINT asset_tbl_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.assign_asset_tbl
    ADD CONSTRAINT assign_asset_tbl_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.category_tbl
    ADD CONSTRAINT category_tbl_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.return_asset_tbl
    ADD CONSTRAINT return_asset_tbl_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_tbl
    ADD CONSTRAINT uk_59jcghlhbe7f0k68b3wwk4okd UNIQUE (staff_code);
ALTER TABLE ONLY public.category_tbl
    ADD CONSTRAINT uk_idwlxxkiagf179evunqjf1btl UNIQUE (name);
ALTER TABLE ONLY public.category_tbl
    ADD CONSTRAINT uk_j5co9pwjhylr3awrg9x31mq3e UNIQUE (prefix_asset_code);
ALTER TABLE ONLY public.user_tbl
    ADD CONSTRAINT user_tbl_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.assign_asset_tbl
    ADD CONSTRAINT fk6pdnjddxm3rvk3fa6rj8vbboc FOREIGN KEY (asset_id) REFERENCES public.asset_tbl(id);
ALTER TABLE ONLY public.assign_asset_tbl
    ADD CONSTRAINT fk7k98h32pfp97t8we6tt8s6epu FOREIGN KEY (assigned_by_user_id) REFERENCES public.user_tbl(id);
ALTER TABLE ONLY public.return_asset_tbl
    ADD CONSTRAINT fkghwp3dcovgqx2onjv06rnhl51 FOREIGN KEY (accepted_user_id) REFERENCES public.user_tbl(id);
ALTER TABLE ONLY public.assign_asset_tbl
    ADD CONSTRAINT fkhcmmtyqqu88aq1f9p117hodw FOREIGN KEY (assigned_to_user_id) REFERENCES public.user_tbl(id);
ALTER TABLE ONLY public.return_asset_tbl
    ADD CONSTRAINT fkkp04nf5ycbs6c6ixmufckn7v4 FOREIGN KEY (asset_id) REFERENCES public.asset_tbl(id);
ALTER TABLE ONLY public.return_asset_tbl
    ADD CONSTRAINT fklo7kv75i2etxwsfaopt4f1as8 FOREIGN KEY (requested_user_id) REFERENCES public.user_tbl(id);
ALTER TABLE ONLY public.return_asset_tbl
    ADD CONSTRAINT fknvawq0bcidneq289cdcedyiac FOREIGN KEY (assign_asset_id) REFERENCES public.assign_asset_tbl(id);
ALTER TABLE ONLY public.asset_tbl
    ADD CONSTRAINT fkoet3t3yyls9936mbfmi819upt FOREIGN KEY (category_id) REFERENCES public.category_tbl(id);

-- Data: User	
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (1, '1990-01-01 00:00:00', 'Admin', 'MALE', FALSE, '2018-01-01 00:00:00', 'Root', 'HCM', '$2a$12$SotK3nau1KLTL5dklSTphunoyTh02tU6lB4NfyXnXsNH7wn7HwVMe', 'SD0001', 'ADMIN', 'admin', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (2, '1990-01-01 00:00:00', 'An',	'MALE', FALSE, '2018-01-01 00:00:00', 'Nguyen Van', 'HANOI', '$2a$12$RG6CDgUpWkNsTM7g9n95EuX18W20VRAcvmrPHTrIeG/X3Ski4PRqu', 'SD0002', 'ADMIN', 'annv', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (3, '1990-01-01 00:00:00', 'Tang',	'MALE', FALSE, '2018-01-01 00:00:00', 'Nguyen Van', 'DANANG', '$2a$12$/PI70mQvN775AEnmZku/FOW.Q6Bf881i358VqG67YVuI8RpYMRwRC', 'SD0003', 'ADMIN', 'tangnv', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (4, '1990-01-01 00:00:00', 'Binh', 'MALE', FALSE, '2018-01-01 00:00:00', 'Tran Van', 'HCM', '$2a$12$UhImO2U3suvBeR60Ge5fv.8f3JiuNqIU9jLYgchfXHrBEsOhFarcS', 'SD0004', 'STAFF', 'binhtv', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (5, '1990-01-01 00:00:00', 'Hao', 'FEMALE', FALSE, '2018-01-01 00:00:00', 'Cao Gia', 'HCM', '$2a$12$GBLFXReBNkRGTWJS6jtgauXa65twG8NO51o7bA/.rkJCkLNx9xDVO', 'SD0005', 'STAFF', 'haocg', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (6, '1990-01-01 00:00:00', 'Lan', 'FEMALE', FALSE, '2018-01-01 00:00:00', 'Nguyen Phuong', 'HCM', '$2a$12$6UoTdH5TkaAv61hnl8YLueg0GRvW3EyoI5xYmYgjvSsXvdqggbudO', 'SD0006', 'STAFF', 'lannp', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (7, '1990-01-01 00:00:00', 'Minh', 'MALE', FALSE, '2018-01-01 00:00:00', 'Tien Tran', 'HCM', '$2a$12$o3KmZ1wpUMbPzPF7LGbbtOTBjg2eHc8SRl/u/KdJzo7dov8zZ2gAy', 'SD0007', 'STAFF', 'minhtt', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (8, '1990-01-01 00:00:00', 'Cuong', 'MALE', FALSE, '2018-11-01 00:00:00', 'Pham Tan', 'HANOI', '$2a$12$EDbZRK3DTLvzzm2lfBTBWudlrPHIFS1pEuckASdPsDiMCwvD.u1pi', 'SD0008', 'STAFF', 'cuongpt', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (9, '1990-01-01 00:00:00', 'Dung', 'MALE', FALSE, '2018-11-01 00:00:00', 'Thai Cao', 'DANANG', '$2a$12$1.gibt0zf7iG0R/TuXlfQeJaMKBWC3UhKeIJdly79.dEmX7qVEodG', 'SD0009', 'STAFF', 'dungtc', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (10, '1990-01-01 00:00:00', 'Huy', 'MALE', FALSE, '2018-01-01 00:00:00', 'Dinh Pham', 'HCM', '$2a$12$3zaCGTN5JBsnQDCnN9KTJuvRAp6kYbCR4yh1K/U4tHsLGlXKx9oBi', 'SD0010', 'ADMIN', 'huydp', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (11, '1990-01-01 00:00:00', 'Cao', 'MALE', FALSE, '2018-01-01 00:00:00', 'Le Van', 'HCM', '$2a$12$aNdkEJ47QPG.1UiRBheZhuluud6e/GCRZmKVKQaTmVNtKLTVz/Wg6', 'SD0011', 'ADMIN', 'caolv', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (12, '2001-01-01 00:00:00', 'Hau', 'MALE', FALSE, '2022-09-01 00:00:00', 'Doan Trung', 'HCM', '$2a$12$O/R5ogjg6Nepe5wiq0ZEDO.oblyR2nnw63Gqso0s3o84z/soznif6', 'SD0012', 'ADMIN', 'haudt', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (13, '2001-01-01 00:00:00', 'Dat', 'MALE', FALSE, '2022-09-01 00:00:00', 'Dang Huu', 'HCM', '$2a$12$M.CwQ1/wTHVPP6tnEWujkOvk8n7AEbq1Gvp.TIKfmLspWMc6p.loy', 'SD0013', 'STAFF', 'datdh', true);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (14, '2001-01-01 00:00:00', 'Khoa', 'MALE', FALSE, '2022-09-01 00:00:00', 'Hoang Dang', 'HCM', '$2a$12$5WKzs7183JtA9pedbPQSsuyXcjil9Vj64ERIzv2oMnxpSmMF8Xf3G', 'SD0014', 'STAFF', 'khoahd', true);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (15, '2001-01-01 00:00:00', 'Trinh', 'FEMALE', FALSE, '2022-09-01 00:00:00', 'Nguyen Ngoc', 'HCM', '$2a$12$xSIZvrf64BBmmbZpDN91QulidOeyeITR2vSSrNTboveqqAOaSx8XC', 'SD0015', 'STAFF', 'trinhnn', false);
INSERT INTO public.user_tbl (id, date_of_birth, first_name, gender, is_deleted, joined_date, last_name, location, password, staff_code, type, user_name, is_first_login)
VALUES (16, '1970-01-01 00:00:00', 'Hoang', 'MALE', FALSE, '2022-09-01 00:00:00', 'Ngoc Trinh', 'HCM', '$2a$12$4RcNiiq0WMJH/HU035Jem.Mul/lHi.iruXhaxJe5wPEdWigJB2ZUG', 'SD0016', 'ADMIN', 'hoangnt', false);

-- Data: Category
INSERT INTO public.category_tbl (id, name, prefix_asset_code) VALUES (1, 'Bluetooth Mouse', 'BM');
INSERT INTO public.category_tbl (id, name, prefix_asset_code) VALUES (2, 'Headset', 'HE');
INSERT INTO public.category_tbl (id, name, prefix_asset_code) VALUES (3, 'Laptop', 'LA');
INSERT INTO public.category_tbl (id, name, prefix_asset_code) VALUES (4, 'Monitor', 'MO');
INSERT INTO public.category_tbl (id, name, prefix_asset_code) VALUES (5, 'Mobile', 'MB');
INSERT INTO public.category_tbl (id, name, prefix_asset_code) VALUES (6, 'Personal Computer', 'PC');

-- Data: Asset
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (1, 'LA000001', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'AVAILABLE', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (2, 'LA000002', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'AVAILABLE', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (3, 'LA000003', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'AVAILABLE', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (4, 'LA000004', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'NOT_AVAILABLE', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (5, 'LA000005', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'ASSIGNED', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (6, 'LA000006', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'WAITING_FOR_RECYCLING', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (7, 'LA000007', 'Laptop HP Probook 450 G1', '2022-11-01 00:00:00', 'Core i5, 8GB RAM, 750GB HDD, Windows 10', 'RECYCLED', 'HCM', FALSE, 3);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (8, 'MO000001', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'AVAILABLE', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (9, 'MO000002', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'AVAILABLE', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (10, 'MO000003', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'AVAILABLE', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (11, 'MO000004', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'NOT_AVAILABLE', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (12, 'MO000005', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'NOT_AVAILABLE', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (13, 'MO000006', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'ASSIGNED', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (14, 'MO000007', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'ASSIGNED', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (15, 'MO000008', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'WAITING_FOR_RECYCLING', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (16, 'MO000009', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'WAITING_FOR_RECYCLING', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (17, 'MO000010', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'RECYCLED', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (18, 'MO000011', 'Monitor Dell UltraSharp', '2022-11-01 00:00:00', 'FullHD, 27inch', 'RECYCLED', 'HCM', FALSE, 4);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (19, 'PC000001', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'AVAILABLE', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (20, 'PC000002', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'AVAILABLE', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (21, 'PC000003', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'NOT_AVAILABLE', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (22, 'PC000004', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'ASSIGNED', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (23, 'PC000005', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'ASSIGNED', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (24, 'PC000006', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'ASSIGNED', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (25, 'PC000007', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'WAITING_FOR_RECYCLING', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (26, 'PC000008', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'WAITING_FOR_RECYCLING', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (27, 'PC000009', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'RECYCLED', 'HCM', FALSE, 6);
INSERT INTO public.asset_tbl (id, asset_code, asset_name, installed_date, specification, status, location, is_deleted, category_id)
VALUES (28, 'PC000010', 'Personal Computer', '2022-11-01 00:00:00', 'Core i9, 32GB RAM, 1TB SDD NVME, Windows 11', 'RECYCLED', 'HCM', FALSE, 6);

-- Data: Assignment
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (1, '2019-02-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 1, 4, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (2, '2020-01-12 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 1, 5, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (3, '2021-02-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 1, 6, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (4, '2022-10-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 5, 12, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (5, '2022-10-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 13, 4, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (6, '2022-10-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 14, 5, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (7, '2022-10-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 22, 6, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (8, '2022-10-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 23, 7, 1);
INSERT INTO public.assign_asset_tbl (id, assigned_date, note, status, is_deleted, asset_id, assigned_to_user_id, assigned_by_user_id)
VALUES (9, '2022-10-01 00:00:00', 'Lend accessories for work', 'ACCEPTED', FALSE, 24, 4, 1);

-- Data: Returning
INSERT INTO public.return_asset_tbl (id, returned_date, status, is_deleted, asset_id, assign_asset_id, accepted_user_id, requested_user_id)
VALUES (1, '2020-01-01 00:00:00', 'COMPLETED', FALSE, 1, 1, 1, 4);
INSERT INTO public.return_asset_tbl (id, returned_date, status, is_deleted, asset_id, assign_asset_id, accepted_user_id, requested_user_id)
VALUES (2, '2021-01-01 00:00:00', 'COMPLETED', FALSE, 1, 2, 1, 5);
INSERT INTO public.return_asset_tbl (id, returned_date, status, is_deleted, asset_id, assign_asset_id, accepted_user_id, requested_user_id)
VALUES (3, '2022-01-01 00:00:00', 'COMPLETED', FALSE, 1, 3, 1, 6);
