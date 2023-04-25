package com.ch.tm.controller;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.tm.model.Board;
import com.ch.tm.model.Member;
import com.ch.tm.service.BoardService;
import com.ch.tm.service.LikesService;
import com.ch.tm.service.MemberService;
import com.ch.tm.service.PageBean;

@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender jMailSender;
	@Autowired
	private LikesService ls;
	@Autowired
	private BoardService bs;

	// 로그인 입력
	@RequestMapping("member/loginForm")
	public String loginForm() {
		return "member/loginForm";
	}

	// 로그인 결과
	@RequestMapping("member/login")
	public String login(Member member, Model model, HttpSession session) {
		int result = 0; // 암호가 다름
		Member member2 = ms.select(member.getId());
		if (member2 == null || member2.getDel().equals("y"))
			result = -1; // 없는 아이디
		else if (passwordEncoder.matches(member.getPassword(), member2.getPassword())) {
			if (member.getId().equals("master")) {
				result = 2; // 관리자 로그인 성공
			} else {
				result = 1; // 로그인 성공
			}
			session.setAttribute("id", member.getId());
		}
		model.addAttribute("result", result);
		return "member/login";
	}

	// 회원가입 입력
	@RequestMapping("member/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}

	// 아이디 중복체크
	@RequestMapping(value = "member/idChk", produces = "text/html;charset=utf-8")
	@ResponseBody // jsp를 통하지않고 직접 문자를 전달
	public String idChk(String id) {
		String msg = "";
		Member member = ms.select(id);
		if (member == null) {
			msg = "사용가능한 아이디입니다.";
		} else {
			msg = "이미 사용 중인 아이디입니다.";
		}
		return msg;
	}

	// 별명 중복체크
	@RequestMapping(value = "member/nickNameChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String nickNameChk(String nickName) {
		String msg = "";
		Member member = ms.selectNickName(nickName);
		if (member == null)
			msg = "사용가능한 별명입니다.";
		else
			msg = "이미 사용 중인 별명입니다.";
		return msg;
	}

	// 회원가입 결과
	@RequestMapping("member/join")
	public String join(Member member, Model model, HttpSession session) throws IOException {
		int result = 0;
		Member member2 = ms.select(member.getId());
		Member member3 = ms.selectNickName(member.getNickName());
		if (member2 == null && member3 == null) {
			// BCryptPasswordEncoder를 이용한 암호화
			String encPassword = passwordEncoder.encode(member.getPassword());
			member.setPassword(encPassword);
			result = ms.insert(member);
		} else if (member2 != null) {
			result = -1; // 이미 가입된 아이디
		} else if (member3 != null) {
			result = -2; // 이미 가입된 닉네임
		}
		model.addAttribute("result", result);
		return "member/join";
	}

	// 아이디 찾기 입력
	@RequestMapping("member/findIdForm")
	public String findIdForm() {
		return "member/findIdForm";
	}

//	// 아이디 찾기 결과(같은 이름과 전화번호로 하나의 아이디만 가입 가능한 경우)
//	@RequestMapping("member/findId")
//	public String findId(Member member, Model model) {
//		int result = 0;
//		Member member2 = ms.selectFindId(member);
//		if (member2 != null) {
//			result = 1;
//			model.addAttribute("member", member2);
//		} else {
//			result = -1;
//		}
//		model.addAttribute("result", result);
//		return "member/findId";
//	}

	// 아이디 찾기 결과(같은 이름과 전화번호로 여러 아이디 가입 가능한 경우)
	@RequestMapping("member/findId")
	public String findId(Member member, Model model) {
		int result = 0;
		List<Member> list = ms.selectFindId(member);
		if (!list.isEmpty()) {
			result = 1;
			model.addAttribute("list", list);
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "member/findId";
	}

	// 비밀번호 찾기 입력
	@RequestMapping("member/findPwForm")
	public String findPwForm() {
		return "member/findPwForm";
	}

	// 비밀번호 찾기 결과
	@RequestMapping("member/findPw")
	public String findPw(Member member, Model model) {
		int result = 0;
		Member member2 = ms.selectFindPw(member);
		if (member2 != null) {
			// 일치하는 회원 계정 존재
			result = 1;
			model.addAttribute("member", member2);

			// 임시 비밀번호 생성
			String msg = "";
			String code = "";
			Random random = new Random();
			for (int i = 0; i < 3; i++) {
				int index = random.nextInt(25) + 65; // A~Z까지 랜덤 알파멧 생성
				code += (char) index;
			}
			int numIndex = random.nextInt(8999) + 1000; // 4자리 랜덤 정수 생성
			code += numIndex;
			msg = (String) code;

			MimeMessage mm = jMailSender.createMimeMessage();
			try {
				MimeMessageHelper mmh = new MimeMessageHelper(mm, true, "utf-8");
				mmh.setSubject("[트래블메이커] 트래블메이커 임시비밀번호 입니다.");
				mmh.setText("임시비밀번호 : " + msg);
				mmh.setTo(member2.getEmail());
				mmh.setFrom("jshee1028@naver.com");
				jMailSender.send(mm);

				// BCryptPasswordEncoder를 이용한 암호화
				String encPassword = passwordEncoder.encode(msg);
				// 이메일이 성공적으로 보내졌으면 멤버 비밀번호 임시 비밀번호로 변경
				member2.setPassword(encPassword);
				int resultUpdatePw = ms.updatePw(member2);
				model.addAttribute("resultUpdatePw", resultUpdatePw);
			} catch (Exception e) {
				result = 0;
				model.addAttribute("msg", e.getMessage());
			}
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "member/findPw";
	}

	// 로그아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "member/logout";
	}

	// 회원 정보 수정 입력
	@RequestMapping("mypage/myUpdateForm")
	public String myUpdateForm(Model model, HttpSession session) {
		String id = (String) session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		return "mypage/myUpdateForm";
	}

	// 회원 정보 수정 결과
	@RequestMapping("mypage/myUpdate")
	public String myUpdate(Member member, Model model, HttpSession session) {
		int result = 0;
		Member member2 = ms.selectNickName(member.getNickName());
		Member member3 = ms.select(member.getId());
		if ((member2 == null) || (member3.getNickName().equals(member.getNickName()))) {
			// BCryptPasswordEncoder를 이용한 암호화
			String encPassword = passwordEncoder.encode(member.getPassword());
			member.setPassword(encPassword);
			result = ms.update(member);
		} else {
			result = -1; // 이미 가입된 닉네임
		}
		model.addAttribute("result", result);
		return "mypage/myUpdate";
	}

	// 회원 탈퇴
	@RequestMapping("mypage/delete")
	public String delete(Model model, HttpSession session) {
		String id = (String) session.getAttribute("id");
		int result = ms.delete(id);
		if (result > 0)
			session.invalidate();
		model.addAttribute("result", result);
		return "mypage/delete";
	}

	// 마이페이지 - 내가 쓴 글
	@RequestMapping("mypage/myBoard")
	public String myBoard(Model model, String id, String pageNum) {
		Member member = ms.select(id);
		int mno = member.getMno();

		if (pageNum == null || pageNum.equals(""))
			pageNum = "1";
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.allMyBoard(mno);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		List<Board> list = bs.myBoardList(mno, startRow, endRow);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);

		model.addAttribute("pb", pb);
		model.addAttribute("list", list);

		return "mypage/myBoard";
	}

	// 마이페이지 - 좋아요 목록
	@RequestMapping("mypage/likesList")
	public String likeList(String id, String pageNum, Model model) {
		Member member = ms.select(id);
		int mno = member.getMno();

		if (pageNum == null || pageNum.equals(""))
			pageNum = "1";
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = ls.likeTotal(mno);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		List<Board> list = bs.myLikeList(mno, startRow, endRow);

		PageBean pb = new PageBean(currentPage, rowPerPage, total);

		model.addAttribute("pb", pb);
		model.addAttribute("list", list);

		return "mypage/likesList";
	}

}
