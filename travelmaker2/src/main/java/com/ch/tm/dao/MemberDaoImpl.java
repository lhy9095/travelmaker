package com.ch.tm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Member;
@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	// 아이디로 회원 검색
	@Override
	public Member select(String id) {
		return sst.selectOne("memberns.select", id);
	}

	// 회원가입
	@Override
	public int insert(Member member) {
		return sst.insert("memberns.insert", member);
	}

	// 별명으로 회원 검색(별명 중복 체크)
	@Override
	public Member selectNickName(String nickName) {
		return sst.selectOne("memberns.selectNickName", nickName);
	}

	// 아이디 찾기 
	@Override
	public List<Member> selectFindId(Member member) {
		return sst.selectList("memberns.selectFindId", member);
	}

	// 비밀번호 찾기
	@Override
	public Member selectFindPw(Member member) {
		return sst.selectOne("memberns.selectFindPw", member);
	}

	// 비밀번호 변경
	@Override
	public int updatePw(Member member) {
		return sst.update("memberns.updatePw", member);
	}

	// 회원정보 수정
	@Override
	public int update(Member member) {
		return sst.update("memberns.update", member);
	}

	// 회원 탈퇴
	@Override
	public int delete(String id) {
		return sst.update("memberns.delete", id);
	}
	
	// (관리자 기능) 회원 전체 목록 
	@Override
	public List<Member> allMemberList(int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("memberns.allMemberList", map);
	}

	// (관리자 기능) 전체 회원 수 
	@Override
	public int memberTotal() {
		return sst.selectOne("memberns.memberTotal");
	}

	// (관리자 기능) 회원 강제탈퇴
	@Override
	public int deleteMember(String id) {
		return sst.update("memberns.deleteMember", id);
	}


}
