package com.ch.tm.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ch.tm.model.Board;
import com.ch.tm.model.Member;
import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;
import com.ch.tm.service.BoardService;
import com.ch.tm.service.MemberService;
import com.ch.tm.service.ReviewService;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService rs;
	@Autowired
	private MemberService ms;
	@Autowired
	private BoardService bs;

	// 댓글 목록
	@RequestMapping("board/rvList")
	public String replyList(int bno, Model model, HttpServletRequest request) {
		Board board = bs.select(bno);
		List<Review> rvList = rs.list(bno);
		List<ReviewPhoto> rpList = rs.listphoto(bno);

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		model.addAttribute("id", id);

		model.addAttribute("board", board);
		model.addAttribute("rvList", rvList);
		model.addAttribute("rpList", rpList);
		return "board/rvList";
	}

	// 댓글 삭제
	@RequestMapping("board/rDelete")
	public String rDelete(Review rv) {
		rs.delete(rv);
		return "redirect:/board/rvList.do?bno=" + rv.getBno();
	}

	// 댓글 입력
	@RequestMapping("board/rInsert")
	public String rInsert(Review rv, HttpSession session, MultipartHttpServletRequest mhr) throws IOException {
		int maxRno = rs.getMaxRno();
		rv.setRno(maxRno);
		rs.insert(rv);
		List<MultipartFile> list = mhr.getFiles("file");
		List<ReviewPhoto> photos = new ArrayList<ReviewPhoto>();
		String real = session.getServletContext().getRealPath("/resources/upload");
		for (MultipartFile mf : list) {
			ReviewPhoto rp = new ReviewPhoto();
			String imgName = mf.getOriginalFilename();
			rp.setImgName(imgName);
			rp.setRno(maxRno);
//			rp.setId(member.getId());
			photos.add(rp);
			FileOutputStream fos = new FileOutputStream(new File(real + "/" + imgName));
			fos.write(mf.getBytes());
			fos.close();
		}
		rs.insertPhoto(photos);
		// redirect나 forward는 jsp가 아니라 Controller 내부의 다른 메서드를 호출
		// 댓글 입력한 후에 결과를 바로 보여주기 위해서
		return "redirect:/board/rvList.do?bno=" + rv.getBno();
	}

	// 댓글 수정
	@RequestMapping("board/rUpdate")
	public String rUpdate(Review rv) {
		rs.update(rv);
		return "redirect:/board/rvList.do?bno=" + rv.getBno();
	}

	// 댓글 수 조회
	@RequestMapping(value = "board/reviewCount.do")
	@ResponseBody
	public int reviewCount(int bno) {
		int result = rs.reviewTotal(bno);
		return result;
	}
}
