package com.ch.tm.dao;

import com.ch.tm.model.Likes;

public interface LikesDao {

	// 좋아요 추가
	void insert(int bno, int mno);

	// 좋아요 취소
	void delete(int bno, int mno);

	// 회원이 해당 게시글을 좋아요 했는지 조회
	Likes select(int bno, int mno);

	// 좋아요 수 조회 
	int getLikes(int bno);

	// 해당 회원이 좋아요한 게시글 수
	int likesTotal(int mno);

	// 좋아요 삭제(게시글 삭제될 때 같이 삭제)
	void deleteAll(int bno);

}
