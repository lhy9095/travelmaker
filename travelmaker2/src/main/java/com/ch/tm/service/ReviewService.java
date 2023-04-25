package com.ch.tm.service;

import java.util.List;

import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

public interface ReviewService {

	// 해당 게시글의 댓글 목록 
	List<Review> list(int bno);

	// 댓글 입력
	void insert(Review rv);

	// 댓글 삭제
	void delete(Review rv);

	// 댓글 수정 
	void update(Review rv);

	// 댓글 사진 입력
	void insertPhoto(List<ReviewPhoto> photos);

	// 댓글 번호 생성
	int getMaxRno();

	// 해당 게시글의 댓글 수
	int reviewTotal(int bno);

	// 해당 게시글의 댓글 사진 목록
	List<ReviewPhoto> listphoto(int bno);

	// (관리자 기능) 해당 회원이 작성한 댓글 목록
	List<Review> memberRvList(int mno);

	// (관리자 기능) 해당 회원이 작성한 댓글 사진 목록 
	List<ReviewPhoto> memberRpList(int mno);

	// (관리자 기능) 댓글 삭제
	int rvDelete(int rno);

}
