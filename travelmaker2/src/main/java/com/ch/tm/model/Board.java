package com.ch.tm.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Board {
	private int bno;		// 게시글 번호
	private String title;	// 제목
	private Date s_date;	// 출발일
	private Date e_date;	// 도착일
	private String loc;		// 지역
	private String content;	// 내용
	private Date reg_date;	// 게시글 등록일
	private int readcount;	// 조회수
	private String del;		// 삭제 여부
	private int mno;		// 회원 번호
	private String courseImg; // 여행코스 이미지
	// paging용
	private int startRow;
	private int endRow;
	// 검색용
	private String search;
	private String keyword;
	// join용
	private String nickName;
	private String id;
	// upload용
	private MultipartFile file;
}
