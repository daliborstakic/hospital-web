package com.daliborstakic.hospital.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daliborstakic.hospital.repositories.DoktorRepository;

import model.Doktor;

@Controller
@RequestMapping(value = "/doktori")
public class DoktorController {
	@Autowired
	DoktorRepository dr;

	@GetMapping(value = "/prikazDoktora")
	public String prikaziDoktore(HttpServletRequest request) {
		System.out.println("Jovan Miric");

		List<Doktor> doktori = dr.findAll();

		request.setAttribute("doktori", doktori);

		return "prikaz/PrikazDoktora";
	}
}
