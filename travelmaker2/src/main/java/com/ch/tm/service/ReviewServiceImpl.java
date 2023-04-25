package com.ch.tm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.ReviewDao;
import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private ReviewDao rd;

	// 해당 게시글의 댓글 목록 
	@Override
	public List<Review> list(int bno) {
		return rd.list(bno);
	}

	// 댓글 입력
	@Override
	public void insert(Review rv) {
		rd.insert(rv);
	}

	// 댓글 삭제
	@Override
	public void delete(Review rv) {
		rd.delete(rv);
	}

	// 댓글 수정 
	@Override
	public void update(Review rv) {
		rd.update(rv);
	}

	// 댓글 사진 입력
	@Override
	public void insertPhoto(List<ReviewPhoto> photos) {
		for (ReviewPhoto rp : photos) {
			rd.insert(rp);
		}
	}

	// 댓글 번호 생성
	@Override
	public int getMaxRno() {
		return rd.getMaxRno();
	}

	// 해당 게시글의 댓글 사진 목록
	@Override
	public List<ReviewPhoto> listphoto(int bno) {
		return rd.listphoto(bno);
	}

	// (관리자 기능) 해당 회원이 작성한 댓글 목록
	@Override
	public List<Review> memberRvList(int mno) {
		return rd.memberRvList(mno);
	}

	// (관리자 기능) 해당 회원이 작성한 댓글 사진 목록 
	@Override
	public List<ReviewPhoto> memberRpList(int mno) {
		return rd.memberRpList(mno);
	}

	// (관리자 기능) 댓글 삭제
	@Override
	public int rvDelete(int rno) {
		return rd.rvDelete(rno);
	}

	// 해당 게시글의 댓글 수
	@Override
	public int reviewTotal(int bno) {
		return rd.reviewTotal(bno);
	}
}
