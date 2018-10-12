-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 18-10-04 17:21
-- 서버 버전: 5.7.21-log
-- PHP 버전: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `miso`
--

-- --------------------------------------------------------



--
-- 테이블 구조 `article`
--

CREATE TABLE `article` (
  `article_id` int(11) NOT NULL,
  `article_writer` varchar(20) NOT NULL,
  `article_title` varchar(100) NOT NULL,
  `article_content` text NOT NULL,
  `reg_date` datetime NOT NULL,
  `article_hits` int(10) NOT NULL DEFAULT '0',
  `article_gets` int(10) NOT NULL DEFAULT '0',
  `article_file` varchar(50) DEFAULT NULL COMMENT '첨부파일',
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `article`
--

INSERT INTO `article` (`article_id`, `article_writer`, `article_title`, `article_content`, `reg_date`, `article_hits`, `article_gets`, `article_file`, `category`) VALUES
(15, 'asdf', 'zz', 'sdfsdfsdf', '2018-09-27 01:17:47', 2, 0, NULL, 'talk'),
(16, 'asdf', 'df', 'sdfsdfsdf', '2018-09-27 01:17:54', 0, 0, NULL, 'movietmi'),
(17, 'asdf', 'dfsd', 'sdfsdfsd', '2018-09-27 01:18:49', 7, 0, NULL, 'movietalk'),
(18, 'asdf', 'gg', 'gsdfsdfsdf', '2018-09-27 01:18:57', 16, 0, NULL, 'boast'),
(19, 'asdf', 'ㅇㅇㅇ', 'dsfsdfsdfsdf', '2018-09-27 01:19:01', 29, 0, NULL, 'talk'),
(20, 'asdf', 'dd', 'ㄴㅇ\r\nㅇ\r\nㅇ\r\nㄹㅇ\r\n', '2018-09-27 01:19:08', 70, 0, NULL, 'movietmi'),
(21, 'asdf', 'ㅇㅇㅇ', 'ㅇㅇ\r\nㅇ\r\nㅇㅇㅇ\r\nㅇ\r\nㅇ\r\nㅇ\r\nㅇ\r\n\r\n', '2018-10-04 22:32:02', 10, 0, 'Desert.jpg', 'boast'),
(22, 'asdf', '글쓰기 테스트입니다', '글쓰기 테스트입니다글쓰기 테스트입니다글쓰기 테스트입니다글쓰기 테스트입니다글쓰기 테스트입니다\r\n글쓰기 테스트입니다\r\n글쓰기 테스트입니다', '2018-10-04 22:44:19', 51, 0, NULL, 'talk'),
(23, 'ㅎㅎㅎ', '정말', '뭐지 ??', '2018-10-04 23:04:00', 30, 0, NULL, 'spoiler'),
(24, 'ㅎㅎㅎ', 'ㄴㅇㄹㄴㅇ', 'ㄹㄴㅇㄹㄴㅇㄹㄴㅇㄹ', '2018-10-05 01:47:35', 0, 0, NULL, 'talk'),
(25, 'ㅎㅎㅎ', '영화스포일러에요', 'ㅋㅋㅋㅋㅋㅋㅋㅋㅋ', '2018-10-05 01:47:48', 4, 0, NULL, 'spoiler');

-- --------------------------------------------------------

--
-- 테이블 구조 `article_like`
--

CREATE TABLE `article_like` (
  `board_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `mem_id` varchar(20) NOT NULL,
  `like_type` char(1) NOT NULL DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시글 좋아요 테이블';

--
-- 테이블의 덤프 데이터 `article_like`
--

INSERT INTO `article_like` (`board_id`, `article_id`, `mem_id`, `like_type`) VALUES
(1, 15, 'bb', 'Y'),
(1, 18, 'aa', 'Y'),
(1, 20, 'aa', 'Y'),
(1, 20, 'bb', 'Y'),
(1, 21, 'aa', 'Y'),
(1, 22, 'aa', 'Y'),
(1, 22, 'bb', 'Y'),
(1, 23, 'bb', 'N'),
(1, 25, 'bb', 'Y');

-- --------------------------------------------------------

--
-- 테이블 구조 `board`
--

CREATE TABLE `board` (
  `board_id` int(11) NOT NULL COMMENT '게시판 기본키',
  `board_name` varchar(20) NOT NULL COMMENT '게시판 이름'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `board`
--

INSERT INTO `board` (`board_id`, `board_name`) VALUES
(1, '자유게시판'),
(2, '영화관 맛집'),
(3, '영화굿즈 정보'),
(4, '시사회'),
(5, '영화 이슈');

-- --------------------------------------------------------

--
-- 테이블 구조 `comment`
--

CREATE TABLE `comment` (
  `cmt_id` int(11) NOT NULL COMMENT '댓글 기본키',
  `cmt_writer` varchar(30) NOT NULL COMMENT '댓글 작성자',
  `cmt_content` varchar(300) NOT NULL COMMENT '댓글 내용',
  `cmt_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '댓글 작성일',
  `cmt_ref` int(11) NOT NULL COMMENT '부모글',
  `cmt_parent` int(11) DEFAULT NULL COMMENT '부모댓글'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `comment`
--

INSERT INTO `comment` (`cmt_id`, `cmt_writer`, `cmt_content`, `cmt_date`, `cmt_ref`, `cmt_parent`) VALUES
(1, 'aa', 'ㅋㅋㅋ', '2018-09-27 23:30:56', 19, 0),
(3, 'aa', 'zfdsfsdfsdf', '2018-09-27 23:40:04', 20, 0);

-- --------------------------------------------------------

--
-- 테이블 구조 `follow`
--

CREATE TABLE `follow` (
  `fol_id` int(11) NOT NULL COMMENT '팔로우 기본키',
  `mem_id` int(11) NOT NULL COMMENT '팔로우 하는 사람',
  `target_mem_id` int(11) NOT NULL COMMENT '팔로우 당하는 사람',
  `fol_datetime` datetime NOT NULL COMMENT '팔로우 한 날짜'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='팔로우테이블';

-- --------------------------------------------------------

--
-- 테이블 구조 `issue`
--

CREATE TABLE `issue` (
  `article_id` int(11) NOT NULL COMMENT '게시글 기본키',
  `article_title` varchar(100) NOT NULL COMMENT '게시글 제목',
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
  `original_url` varchar(256) NOT NULL COMMENT '원본글 주소',
  `article_file` varchar(100) NOT NULL COMMENT '영화 포스터'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='영화 이슈';

--
-- 테이블의 덤프 데이터 `issue`
--

INSERT INTO `issue` (`article_id`, `article_title`, `reg_date`, `original_url`, `article_file`) VALUES
(1, 'sdsd', '2018-09-22 20:58:30', 'hi.html', 'Jellyfish1.jpg');

-- --------------------------------------------------------
--
-- 테이블 구조 `evenement`
--

CREATE TABLE`evenement` (
  `id` int (11) NOT NULL AUTO_INCREMENT,
  `title` varchar (255) COLLATE utf8_bin NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `url` varchar (255) COLLATE utf8_bin NOT NULL,
  `allDay` varchar (255) COLLATE utf8_bin NOT NULL 기본값 'false',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin AUTO_INCREMENT = 7;

--
-- 테이블 구조 `member`
--

CREATE TABLE `member` (
  `mem_id` int(11) NOT NULL COMMENT '회원기본키',
  `mem_status` int(1) NOT NULL COMMENT '회원상태',
  `mem_userid` varchar(15) NOT NULL COMMENT '회원아이디',
  `mem_pwd` varchar(20) NOT NULL COMMENT '회원비밀번호',
  `mem_email` varchar(30) NOT NULL COMMENT '회원이메일',
  `mem_name` varchar(10) NOT NULL COMMENT '회원이름',
  `mem_birth` varchar(8) NOT NULL COMMENT '회원생년월일',
  `mem_gender` int(1) NOT NULL COMMENT '회원성별',
  `mem_nickname` varchar(20) NOT NULL COMMENT '회원닉네임',
  `mem_postcode` char(5) DEFAULT NULL COMMENT '회원 우편번호',
  `mem_address` varchar(100) DEFAULT NULL COMMENT '회원 주소',
  `join_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '회원가입일',
  `mem_type` int(1) NOT NULL COMMENT '회원구분'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원테이블';

--
-- 테이블의 덤프 데이터 `member`
--

INSERT INTO `member` (`mem_id`, `mem_status`, `mem_userid`, `mem_pwd`, `mem_email`, `mem_name`, `mem_birth`, `mem_gender`, `mem_nickname`, `mem_postcode`, `mem_address`, `join_date`, `mem_type`) VALUES
(1, 0, 'admin', 'misoadmin', 'hy5oo@naver.com', '관리자', '19980224', 1, '관리자', '06027', '서울 강남구 압구정로 102 (신사동, 형지제2빌딩)', '2018-09-17 20:38:41', 1),
(2, 0, 'gg', '1234', 'asd@asd.asd', '하이', '19980813', 1, 'gg', '44257', '울산 북구 아랫율동1길 1 (양정동)', '2018-09-13 20:28:31', 0),
(3, 0, 'bb', '1234', 'aaa@aaa.aaa', 'ㅁㄴㅇㄹ', '19990609', 0, 'ㅎㅎㅎ', '06313', '서울 강남구 양재대로 333 (개포동)', '2018-09-13 20:29:51', 0),
(4, 0, 'aass', '1234', 'aaa@aaa.aaa', 'fgfsdf', '20000414', 0, 'gfdsf', '06027', '서울 강남구 압구정로 102 (신사동, 형지제2빌딩)', '2018-09-13 22:32:38', 0),
(5, 0, 'aa', '1234', 'asd@asd.asd', 'asd', '20001212', 1, 'asdf', '34672', '대전 동구 판암동 497-3', '2018-09-17 20:38:46', 0);

-- --------------------------------------------------------

--
-- 테이블 구조 `message`
--

CREATE TABLE `message` (
  `msg_id` int(11) NOT NULL COMMENT '메시지 기본키',
  `msg_content` varchar(200) NOT NULL COMMENT '메시지 내용',
  `msg_type` int(1) NOT NULL COMMENT '메시지 구분',
  `send_mem_id` varchar(20) NOT NULL COMMENT '보낸 회원 아이디',
  `recv_mem_id` varchar(20) NOT NULL COMMENT '받는 회원 아이디',
  `msg_datetime` datetime NOT NULL COMMENT '메시지 보낸 날짜',
  `msg_read_datetime` datetime NOT NULL COMMENT '메시지 읽은 날짜',
  `related_msg_id` int(11) NOT NULL COMMENT '관련 메시지'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메시지 테이블';

-- --------------------------------------------------------

--
-- 테이블 구조 `movielike`
--

CREATE TABLE `movielike` (
  `movie_like_id` int(11) NOT NULL COMMENT '좋아요 기본키',
  `movieCd` varchar(8) NOT NULL COMMENT '좋아요 한 영화',
  `mem_id` int(11) NOT NULL COMMENT '좋아요 한 회원'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='영화 좋아요 테이블';

-- --------------------------------------------------------

--
-- 테이블 구조 `preview`
--

CREATE TABLE `preview` (
  `article_id` int(11) NOT NULL COMMENT '게시글 기본키',
  `article_title` varchar(100) NOT NULL COMMENT '게시글 제목',
  `preview_date` varchar(10) NOT NULL COMMENT '일시',
  `preview_region` varchar(200) NOT NULL COMMENT '지역',
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
  `original_url` varchar(256) NOT NULL COMMENT '원본글 주소',
  `article_file` varchar(100) NOT NULL COMMENT '영화 포스터',
  `cinema` varchar(20) NOT NULL COMMENT '영화관'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='시사회 테이블';

--
-- 테이블의 덤프 데이터 `preview`
--

INSERT INTO `preview` (`article_id`, `article_title`, `preview_date`, `preview_region`, `reg_date`, `original_url`, `article_file`, `cinema`) VALUES
(1, 'sdfsdf', '2018-09-27', 'dsfsdf', '2018-09-22 20:39:00', 'hi.html', 'Hydrangeas1.jpg', 'cgv');

-- --------------------------------------------------------

--
-- 테이블 구조 `quiz`
--

CREATE TABLE `quiz` (
  `episode` int(11) NOT NULL,
  `mem_userid` varchar(30) NOT NULL,
  `radio1` varchar(1) NOT NULL,
  `radio2` varchar(1) NOT NULL,
  `radio3` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='퀴즈 테이블';

-- --------------------------------------------------------

--
-- 테이블 구조 `restaurant`
--

CREATE TABLE `restaurant` (
  `article_id` int(11) NOT NULL COMMENT '게시글 기본키',
  `article_writer` varchar(20) NOT NULL COMMENT '게시글 작성자',
  `article_title` varchar(100) NOT NULL COMMENT '게시글 제목',
  `article_content` text NOT NULL COMMENT '게시글 내용',
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
  `article_hits` int(10) NOT NULL DEFAULT '0' COMMENT '조회수',
  `article_gets` int(10) NOT NULL DEFAULT '0' COMMENT '추천수',
  `article_file` varchar(100) DEFAULT NULL COMMENT '첨부 파일',
  `search_loc` varchar(256) NOT NULL COMMENT '장소',
  `start_lat` float(10,6) NOT NULL,
  `start_lon` float(10,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='맛집 테이블';

-- --------------------------------------------------------
--
-- 테이블의 덤프 데이터 `restaurant`
--

INSERT INTO `restaurant` (`article_id`, `article_writer`, `article_title`, `article_content`, `reg_date`, `article_hits`, `article_gets`, `article_file`, `search_loc`, `start_lat`, `start_lon`) VALUES
(1, 'asdf', 'ㅇㅇㅇ', 'ㅇㄹㄴㅇㄹ', '2018-09-17 20:34:37', 0, 0, NULL, '한양', 0.000000, 0.000000),
(2, 'asdf', 'ㅇㅇㅇ', 'ㅅㄷㄴㅅ', '2018-09-22 22:10:21', 0, 0, NULL, '한양', 0.000000, 0.000000),
(3, 'asdf', 'ㅇㅇ', '', '2018-10-04 20:19:23', 0, 0, NULL, '한양각', 0.000000, 0.000000),
(4, 'ㅎㅎㅎ', 'test', 'ㄴㅇㄹㄴㅇㄹㄴㅇ', '2018-10-05 00:47:58', 0, 0, NULL, '한양각', 0.000000, 0.000000),
(5, 'ㅎㅎㅎ', 'ㄴㅇㄹㄴ', 'ㅇㅇㄹㅇ', '2018-10-05 01:16:24', 0, 0, NULL, '쭈피랑', 0.000000, 0.000000),
(6, 'ㅎㅎㅎ', 'ㅋㅋㅋ', 'ㄴㅇㄹㄴㅇ', '2018-10-05 01:17:45', 0, 0, NULL, '한양각', 0.000000, 0.000000),
(7, 'ㅎㅎㅎ', 'ㅇㅇㅇ', 'ㅇㄴㄹㄴㅇㄹ', '2018-10-05 01:19:38', 0, 0, NULL, '한양식당', 0.000000, 0.000000);

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`episode`);

--
-- 테이블의 인덱스 `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`article_id`);

--
-- 테이블의 인덱스 `article_like`
--
ALTER TABLE `article_like`
  ADD PRIMARY KEY (`board_id`,`article_id`,`mem_id`);

--
-- 테이블의 인덱스 `board`
--
ALTER TABLE `board`
  ADD PRIMARY KEY (`board_id`);

--
-- 테이블의 인덱스 `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`cmt_id`);

--
-- 테이블의 인덱스 `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`fol_id`);

--
-- 테이블의 인덱스 `issue`
--
ALTER TABLE `issue`
  ADD PRIMARY KEY (`article_id`);

--
-- 테이블의 인덱스 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`mem_id`);

--
-- 테이블의 인덱스 `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`msg_id`);

--
-- 테이블의 인덱스 `movielike`
--
ALTER TABLE `movielike`
  ADD PRIMARY KEY (`movie_like_id`);

--
-- 테이블의 인덱스 `preview`
--
ALTER TABLE `preview`
  ADD PRIMARY KEY (`article_id`);

--
-- 테이블의 인덱스 `restaurant`
--
ALTER TABLE `restaurant`
  ADD PRIMARY KEY (`article_id`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `article`
--
ALTER TABLE `article`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- 테이블의 AUTO_INCREMENT `board`
--
ALTER TABLE `board`
  MODIFY `board_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시판 기본키', AUTO_INCREMENT=6;

--
-- 테이블의 AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `cmt_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '댓글 기본키', AUTO_INCREMENT=4;

--
-- 테이블의 AUTO_INCREMENT `follow`
--
ALTER TABLE `follow`
  MODIFY `fol_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '팔로우 기본키';

--
-- 테이블의 AUTO_INCREMENT `issue`
--
ALTER TABLE `issue`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 기본키', AUTO_INCREMENT=2;

--
-- 테이블의 AUTO_INCREMENT `member`
--
ALTER TABLE `member`
  MODIFY `mem_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '회원기본키', AUTO_INCREMENT=6;

--
-- 테이블의 AUTO_INCREMENT `message`
--
ALTER TABLE `message`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '메시지 기본키';

--
-- 테이블의 AUTO_INCREMENT `movielike`
--
ALTER TABLE `movielike`
  MODIFY `movie_like_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '좋아요 기본키';

--
-- 테이블의 AUTO_INCREMENT `preview`
--
ALTER TABLE `preview`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 기본키', AUTO_INCREMENT=2;

--
-- 테이블의 AUTO_INCREMENT `restaurant`
--
ALTER TABLE `restaurant`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 기본키', AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
