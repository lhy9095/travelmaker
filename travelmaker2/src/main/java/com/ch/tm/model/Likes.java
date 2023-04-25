package com.ch.tm.model;

import lombok.Data;

@Data
public class Likes {
	private int lno;	// 좋아요 번호
	private int bno;	// 게시글 번호
	private int mno;	// 회원 번호
}
