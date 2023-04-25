package com.ch.tm.dao;

import java.util.List;

import com.ch.tm.model.Member;

public interface MemberDao {

	// 아이디로 회원 검색
	Member select(String id);

	// 회원가입
	int insert(Member member);

	// 별명으로 회원 검색(별명 중복 체크)
	Member selectNickName(String nickName);

	// 아이디 찾기 
	List<Member> selectFindId(Member member);

	// 비밀번호 찾기
	Member selectFindPw(Member member);

	// 비밀번호 변경
	int updatePw(Member member);

	// 회원정보 수정
	int update(Member member);

	// 회원 탈퇴
	int delete(String id);

	// (관리자 기능) 회원 전체 목록 
	List<Member> allMemberList(int startRow, int endRow);

	// (관리자 기능) 전체 회원 수 
	int memberTotal();

	// (관리자 기능) 회원 강제탈퇴
	int deleteMember(String id);


}
