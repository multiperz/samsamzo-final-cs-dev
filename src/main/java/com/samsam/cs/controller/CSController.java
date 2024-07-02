package com.samsam.cs.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.samsam.cs.dto.CSDTO;
import com.samsam.cs.entity.CI;
import com.samsam.cs.service.CSService;

import io.micrometer.common.util.StringUtils;
import jakarta.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

//import lombok.RequiredArgsConstructor;

@Controller
//@RequiredArgsConstructor
public class CSController {
	private static final Logger logger = LogManager.getLogger(CSController.class);

	private final CSService csService;

	@Inject
	public CSController(CSService csService) {
		this.csService = csService;
	}

	@GetMapping("/CSSelect")
	public String list(Model model, @PageableDefault(page = 0, size = 5, sort = "csNumber", direction = Sort.Direction.DESC) Pageable pageable, @RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "searchContent", required = false) String searchContent, @RequestParam(name = "searchKeyword", required = false) String searchKeyword) {

		Pageable adjustedPageable = PageRequest.of(page - 1, pageable.getPageSize(), pageable.getSort());

		Page<CI> list;

		if (StringUtils.isEmpty(searchKeyword) || StringUtils.isEmpty(searchContent)) {
			list = csService.findallCis(adjustedPageable);
		} else if ("title".equals(searchContent)) {
			list = csService.CISearchList(searchKeyword, adjustedPageable);
		} else if ("content".equals(searchContent)) {
			list = csService.CISearchContent(searchKeyword, adjustedPageable);
		} else {
			list = csService.findallCis(adjustedPageable);
		}

		int nowPage = list.getNumber() + 1;
		int totalPageCount = list.getTotalPages();
		int startPage = ((nowPage - 1) / 5) * 5 + 1;
		int endPage = Math.min(startPage + 4, totalPageCount);

		model.addAttribute("list", list);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("hasPrevious", list.hasPrevious());
		model.addAttribute("hasNext", list.hasNext());
		model.addAttribute("previousPage", nowPage - 1);
		model.addAttribute("nextPage", nowPage + 1);
		model.addAttribute("searchContent", searchContent);
		model.addAttribute("searchKeyword", searchKeyword);

		logger.info("list", model);
		return "./cs_view/cs_select_view";
	}

	@GetMapping("/CSSelectDetail")
	public String detail(Model model, @RequestParam("cs_number") Integer cs_number) {
		model.addAttribute("csDTO", csService.findCIById(cs_number));
		return "./cs_view/cs_select_detail_view";
	}

	@GetMapping("/CSInsert")
	public String insert() {
		return "./cs_view/cs_insert_view";
	}

	@PostMapping("/CSInsert")
	public String insert(Model model, CSDTO csDTO) {
		CI ci = new CI();
		ci.setCsNumber(csDTO.getCsNumber());
		ci.setCsTitle(csDTO.getCsTitle());
		ci.setCsDate(csDTO.getCsDate());
		ci.setCsContent(csDTO.getCsContent());
		csService.saveCI(ci);
		return "./cs_view/cs_insert";
	}

	@GetMapping("/CSUpdate")
	public String update(Model model, @RequestParam("cs_number") Integer cs_number) {
		CI ci = csService.findCIById(cs_number);
		if (ci != null) {
			CSDTO csDTO = new CSDTO();
			csDTO.setCsNumber(ci.getCsNumber());
			csDTO.setCsTitle(ci.getCsTitle());
			csDTO.setCsDate(ci.getCsDate());
			csDTO.setCsContent(ci.getCsContent());
			model.addAttribute("csDTO", csDTO);
		}
		return "./cs_view/cs_update_view";
	}

	@PostMapping("/CSUpdate")
	public String update(CSDTO csDTO) {
		CI ci = new CI();
		ci.setCsNumber(csDTO.getCsNumber());
		ci.setCsTitle(csDTO.getCsTitle());
		ci.setCsDate(csDTO.getCsDate());
		ci.setCsContent(csDTO.getCsContent());
		csService.saveCI(ci);
		return "./cs_view/cs_update";
	}

	@GetMapping("/CSDelete")
	public String delete(Model model, @RequestParam("cs_number") Integer cs_number) {
		CI ci = csService.findCIById(cs_number);
		if (ci != null) {
			CSDTO csDTO = new CSDTO();
			csDTO.setCsNumber(ci.getCsNumber());
			csDTO.setCsTitle(ci.getCsTitle());
			csDTO.setCsDate(ci.getCsDate());
			csDTO.setCsContent(ci.getCsContent());
			model.addAttribute("csDTO", csDTO);
		}
		return "./cs_view/cs_delete_view";
	}

	@PostMapping("/CSDelete")
	public String delete(@RequestParam("cs_number") Integer cs_number) {
		csService.deleteCIById(cs_number);
		return "./cs_view/cs_delete";
	}
}