package com.ch.tm.model;

import lombok.Data;

@Data
public class ReviewPhoto {
	private int rpno;		// 댓글 사진 번호
	private int mno;		// 회원 번호
	private int rno;		// 댓글 번호
	private String imgName;	// 댓글 사진 이름
	
	private Review review = new Review();
}
