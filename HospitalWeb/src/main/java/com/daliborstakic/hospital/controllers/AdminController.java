package com.daliborstakic.hospital.controllers;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daliborstakic.hospital.repositories.DepartmanRepository;
import com.daliborstakic.hospital.repositories.SpecijalizacijaRepository;

import model.Departman;
import model.Specijalizacija;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	@Autowired
	DepartmanRepository departmanRepository;

	@Autowired
	SpecijalizacijaRepository specijalizacijaRepository;

	@GetMapping(value = "pocetna")
	public String redirectToPocetna() {
		return "admin/adminHome";
	}

	@GetMapping(value = "unesiDepartman")
	public String redirectToUnesiDepartman(Model model) {
		Departman departman = new Departman();

		model.addAttribute("departman", departman);

		return "admin/unesiDepartman";
	}

	@PostMapping(value = "sacuvajDepartman")
	public ModelAndView saveDepartman(@ModelAttribute("departman") Departman departman) {
		departman.setNaziv(departman.getNaziv());

		departmanRepository.save(departman);

		return new ModelAndView("redirect:/admin/pocetna");
	}

	@GetMapping(value = "unesiSpecijalizaciju")
	public String redirectToUnesiSpecijalizaciju(Model model) {
		Specijalizacija specijalizacija = new Specijalizacija();

		model.addAttribute("specijalizacija", specijalizacija);

		return "admin/unesiSpecijalizaciju";
	}

	@PostMapping(value = "sacuvajSpecijalizaciju")
	public ModelAndView saveSpecijalizacija(@ModelAttribute("specijalizacija") Specijalizacija specijalizacija) {
		specijalizacija.setNaziv(specijalizacija.getNaziv());

		specijalizacijaRepository.save(specijalizacija);

		return new ModelAndView("redirect:/admin/pocetna");
	}
}
