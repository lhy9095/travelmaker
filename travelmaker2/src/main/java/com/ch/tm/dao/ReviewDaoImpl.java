package com.ch.tm.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	@Autowired
	private SqlSessionTemplate sst;

	// 해당 게시글의 댓글 목록 
	@Override
	public List<Review> list(int bno) {
		return sst.selectList("reviewns.list", bno);
	}

	// 댓글 입력
	@Override
	public void insert(Review rv) {
		sst.insert("reviewns.insert", rv);
	}

	// 댓글 삭제
	@Override
	public void delete(Review rv) {
		sst.update("reviewns.delete", rv);
	}

	// 댓글 수정 
	@Override
	public void update(Review rv) {
		sst.update("reviewns.update", rv);
	}

	// 댓글 사진 입력
	@Override
	public void insert(ReviewPhoto rp) {
		sst.insert("reviewns.insertPhoto", rp);
	}

	// 댓글 번호 생성
	@Override
	public int getMaxRno() {
		return sst.selectOne("reviewns.getMaxRno");
	}

	// 해당 게시글의 댓글 사진 목록
	@Override
	public List<ReviewPhoto> listphoto(int bno) {
		return sst.selectList("reviewns.listphoto", bno);
	}

	// (관리자 기능) 해당 회원이 작성한 댓글 목록
	@Override
	public List<Review> memberRvList(int mno) {
		return sst.selectList("reviewns.memberRvList", mno);
	}

	// (관리자 기능) 해당 회원이 작성한 댓글 사진 목록 
	@Override
	public List<ReviewPhoto> memberRpList(int mno) {
		return sst.selectList("reviewns.memberRpList", mno);
	}

	// (관리자 기능) 댓글 삭제
	@Override
	public int rvDelete(int rno) {
		return sst.update("reviewns.rvDelete", rno);
	}

	// 해당 게시글의 댓글 수
	@Override
	public int reviewTotal(int bno) {
		return sst.selectOne("reviewns.reviewTotal", bno);
	}

}
