package com.ch.tm.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Review {
	private int rno;				// 댓글 번호
	private String reply_content;	// 내용
	private Date reg_date;			// 등록일
	private Date update_date;		// 수정일
	private String del;				// 삭제 여부
	private int mno;				// 회원 번호
	private int bno;				// 게시글 번호
	
	// join용
	private String nickName;
}
