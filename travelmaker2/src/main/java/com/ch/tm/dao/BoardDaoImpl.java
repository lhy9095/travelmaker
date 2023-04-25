package com.ch.tm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Board;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	private SqlSessionTemplate sst;

	// 게시글 번호 생성 
	@Override
	public int getMaxNum() {
		return sst.selectOne("boardns.getMaxNum");
	}

	// 게시글 입력
	@Override
	public int insert(Board board) {
		return sst.insert("boardns.insert", board);
	}

	// 조회수 증가
	@Override
	public void updateReadCount(int bno) {
		sst.update("boardns.updateReadCount", bno);
	}

	// 게시글 보기
	@Override
	public Board select(int bno) {
		return sst.selectOne("boardns.select", bno);
	}

	// 게시글 수정 
	@Override
	public int update(Board board) {
		return sst.update("boardns.update", board);
	}

	// 게시글 삭제
	@Override
	public int delete(int bno) {
		return sst.update("boardns.delete", bno);
	}

	// 전체 게시글 수 
	@Override
	public int getTotal(Board board) {
		return sst.selectOne("boardns.getTotal", board);
	}

	// 게시글 전체 목록
	@Override
	public List<Board> list(Board board) {
		return sst.selectList("boardns.list", board);
	}

	// (관리자 기능) 해당 회원이 좋아요한 게시글 목록 
	@Override
	public List<Board> myLikeList(int mno, int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("boardns.myLikeList", map);
	}

	// (관리자 기능) 해당 회원이 쓴 글 수
	@Override
	public int allMyBoard(int mno) {
		return sst.selectOne("boardns.allMyBoard", mno);
	}

	// (관리자 기능) 해당 회원이 쓴 게시글 목록 
	@Override
	public List<Board> myBoardList(int mno, int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("boardns.myBoardList", map);
	}

	// (관리자 기능) 게시글 삭제 기능
	@Override
	public int adminDelete(int bno) {
		return sst.update("boardns.adminDelete", bno);
	}


}
