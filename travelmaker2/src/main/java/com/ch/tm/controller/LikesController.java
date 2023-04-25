package com.ch.tm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.tm.model.Likes;
import com.ch.tm.model.Member;
import com.ch.tm.service.LikesService;
import com.ch.tm.service.MemberService;

@Controller
public class LikesController {
	@Autowired
	private LikesService ls;
	@Autowired
	private MemberService ms;

	// 좋아요 조회
	@RequestMapping(value = "board/likesSelect.do", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String likesSelect(int bno, String id) {
		Member member = ms.select(id);
		int mno = member.getMno();

		String result = "";
		Likes likes = ls.select(bno, mno);

		if (likes != null) {
			result = "red_heart.png";
		} else {
			result = "heart.png";
			;
		}

		return result;
	}

	// 좋아요 기능
	@RequestMapping(value = "board/likesUpdate.do", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String likesUpdate(int bno, String id) {
		String result = "";

		Member member = ms.select(id);
		int mno = member.getMno();
		Likes likes = ls.select(bno, mno);

		if (likes == null) {
			ls.insert(bno, mno); // 좋아요 추가
			result = "red_heart.png";
		} else {
			ls.delete(bno, mno); // 좋아요 취소
			result = "heart.png";
		}

		return result;
	}

	// 좋아요 수 조회
	@RequestMapping(value = "board/likesCount.do")
	@ResponseBody
	public String likesCount(int bno) {
		String result = Integer.toString(ls.getLikes(bno));
		return result;
	}

}
