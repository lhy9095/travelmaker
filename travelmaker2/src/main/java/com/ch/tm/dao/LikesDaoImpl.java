package com.ch.tm.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Likes;

@Repository
public class LikesDaoImpl implements LikesDao {
	@Autowired
	private SqlSessionTemplate sst;

	// 좋아요 추가
	@Override
	public void insert(int bno, int mno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("bno", bno);
		map.put("mno", mno);
		sst.insert("likesns.insert", map);
	}

	// 좋아요 취소
	@Override
	public void delete(int bno, int mno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("bno", bno);
		map.put("mno", mno);
		sst.delete("likesns.delete", map);
	}

	// 회원이 해당 게시글을 좋아요 했는지 조회
	@Override
	public Likes select(int bno, int mno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("bno", bno);
		map.put("mno", mno);
		return sst.selectOne("likesns.select", map);		
	}

	// 좋아요 수 조회 
	@Override
	public int getLikes(int bno) {
		return sst.selectOne("likesns.getLikes", bno);
	}

	// 해당 회원이 좋아요한 게시글 수
	@Override
	public int likesTotal(int mno) {
		return sst.selectOne("likesns.likesTotal", mno);
	}

	// 좋아요 삭제(게시글 삭제될 때 같이 삭제)
	@Override
	public void deleteAll(int bno) {
		sst.delete("likesns.deleteAll", bno);		
	}
	

}
