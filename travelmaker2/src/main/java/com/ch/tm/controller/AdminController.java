package com.ch.tm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.tm.model.Board;
import com.ch.tm.model.Member;
import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;
import com.ch.tm.service.BoardService;
import com.ch.tm.service.LikesService;
import com.ch.tm.service.MemberService;
import com.ch.tm.service.PageBean;
import com.ch.tm.service.ReviewService;

@Controller
public class AdminController {

	@Autowired
	private MemberService ms;
	@Autowired
	private LikesService ls;
	@Autowired
	private BoardService bs;
	@Autowired
	private ReviewService rs;

	// 관리자 페이지 메인
	@RequestMapping("admin/adminMain")
	public String adminMain(Board board, String pageNum, Model model, HttpServletRequest request) {
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		List<Board> list = bs.list(board);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		int bno = total - startRow + 1;
		String[] title = {"내용","작성자"};
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		model.addAttribute("title", title);
		model.addAttribute("bno", bno);
		model.addAttribute("pb", pb);
		model.addAttribute("list", list);
		return "admin/adminMain";
	}
		
	// 관리자의 게시글 삭제 기능
	@RequestMapping(value = "admin/adminBdDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> adminBdDelete(@RequestParam("chkbox[]") List<String> checkArr,
		     				 @RequestParam("pageNum") String pageNum) throws Exception {
		int result = 0;
		int bno = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		for(String i : checkArr) {
			bno = Integer.parseInt(i);
			bs.adminDelete(bno);
			ls.deleteAll(bno);
		}
		
		// 삭제 성공
		result = 1;
		
		map.put("result", result);
		map.put("pageNum", pageNum);
		
		return map;
	}
	
	// 회원 관리(전체 회원 목록) 
	@RequestMapping("admin/memberList")
	public String memberList(Model model, String id, String pageNum) {
		
		if(pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int rowPerPage = 15;
		int currentPage = Integer.parseInt(pageNum);
		int total = ms.memberTotal();
		int startRow = (currentPage -1) * rowPerPage +1;
		int endRow = startRow + rowPerPage -1;
		List<Member> list = ms.allMemberList(startRow, endRow);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		model.addAttribute("pb", pb);		
		model.addAttribute("list", list);
		
		return "admin/memberList";
	}
	
	// 회원 정보 상세
	@RequestMapping("admin/memberInfo")
	public String memberInfo(Model model, String id) {
		Member member = ms.select(id);
		model.addAttribute("member", member);
		return "admin/memberInfo";
	}
	
	// 회원 정보 페이지에서 회원 강제 탈퇴 
	@RequestMapping("admin/deleteMember")
	public String deleteMember(Model model, String id) {
		int result = 0;
		Member member = ms.select(id);
		result = ms.deleteMember(id);
		
		model.addAttribute("result", result);
		model.addAttribute("member", member);
		return "admin/deleteMember";
	}
	
	// 회원 전체 목록에서 회원 강제 탈퇴
	@RequestMapping("admin/deleteMember2")
	public String deleteMember2(Model model, String id) {
		int result = 0;
		result = ms.deleteMember(id);
		if (result == 1) {
			result = 2;
		} else {
			result = 0;
		};
		
		model.addAttribute("result", result);
		return "admin/deleteMember";
	}
	
	// 회원별 작성 게시글 목록
	@RequestMapping("admin/memberBoard")
	public String memberBoard(Model model, String id, String pageNum) {
		Member member = ms.select(id);
		int mno = member.getMno();
		
		if(pageNum == null || pageNum.equals("")) pageNum = "1";
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.allMyBoard(mno);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		List<Board> list = bs.myBoardList(mno, startRow, endRow);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		model.addAttribute("pb", pb);
		model.addAttribute("list", list); 
		model.addAttribute("id", id);
		return "admin/memberBoard";
	}
	
	// 회원별 작성 댓글 목록
	@RequestMapping("admin/memberReview")
	public String memberReview(Model model, String id) {
		Member member = ms.select(id);
		int mno = member.getMno();
		
		List<Review> rvList = rs.memberRvList(mno);
		List<ReviewPhoto> rpList = rs.memberRpList(mno);
		
		model.addAttribute("member", member);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rpList", rpList);

		return "admin/memberReview";
	}
	
	// 댓글 강제 삭제
	@RequestMapping("admin/rvDelete")
	public String rvDelete(Model model, int rno, String id) {
		int result = 0;
		result = rs.rvDelete(rno);
		
		model.addAttribute("result", result);
		model.addAttribute("id", id);
		return "admin/rvDelete";
	}
	
}
