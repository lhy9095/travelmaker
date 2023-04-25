package com.ch.tm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.MemberDao;
import com.ch.tm.model.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao md;
	
	// 아이디로 회원 검색
	@Override
	public Member select(String id) {
		return md.select(id);
	}

	// 회원가입
	@Override
	public int insert(Member member) {
		return md.insert(member);
	}

	// 별명으로 회원 검색(별명 중복 체크)
	@Override
	public Member selectNickName(String nickName) {
		return md.selectNickName(nickName);
	}

	// 아이디 찾기 
	@Override
	public List<Member> selectFindId(Member member) {
		return md.selectFindId(member);
	}

	// 비밀번호 찾기
	@Override
	public Member selectFindPw(Member member) {
		return md.selectFindPw(member);
	}

	// 비밀번호 변경
	@Override
	public int updatePw(Member member) {
		return md.updatePw(member);
	}

	// 회원정보 수정
	@Override
	public int update(Member member) {
		return md.update(member);
	}

	// 회원 탈퇴
	@Override
	public int delete(String id) {
		return md.delete(id);
	}

	// (관리자 기능) 회원 전체 목록 
	@Override
	public List<Member> allMemberList(int startRow, int endRow) {
		return md.allMemberList(startRow, endRow);
	}

	// (관리자 기능) 전체 회원 수 
	@Override
	public int memberTotal() {
		return md.memberTotal();
	}

	// (관리자 기능) 회원 강제탈퇴
	@Override
	public int deleteMember(String id) {
		return md.deleteMember(id);
	}

}
