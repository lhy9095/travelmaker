package com.ch.tm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.LikesDao;
import com.ch.tm.model.Likes;

@Service
public class LikesServiceImpl implements LikesService {
	@Autowired
	private LikesDao ld;

	// 좋아요 추가
	@Override
	public void insert(int bno, int mno) {
		ld.insert(bno, mno);		
	}

	// 좋아요 취소
	@Override
	public void delete(int bno, int mno) {
		ld.delete(bno, mno);	
	}

	// 회원이 해당 게시글을 좋아요 했는지 조회
	@Override
	public Likes select(int bno, int mno) {
		return ld.select(bno, mno);
	}

	// 좋아요 수 조회 
	@Override
	public int getLikes(int bno) {
		return ld.getLikes(bno);
	}

	// 해당 회원이 좋아요한 게시글 수
	@Override
	public int likeTotal(int mno) {
		return ld.likesTotal(mno);
	}

	// 좋아요 삭제(게시글 삭제될 때 같이 삭제)
	@Override
	public void deleteAll(int bno) {
		ld.deleteAll(bno);
	}


	
	
}
