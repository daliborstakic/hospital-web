package com.daliborstakic.hospital.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daliborstakic.hospital.repositories.DepartmanRepository;
import com.daliborstakic.hospital.repositories.DoktorRepository;
import com.daliborstakic.hospital.repositories.KorisnikRepository;
import com.daliborstakic.hospital.repositories.LekRepository;
import com.daliborstakic.hospital.repositories.SpecijalizacijaRepository;
import com.daliborstakic.hospital.repositories.TehnicarRepository;
import com.daliborstakic.hospital.repositories.UlogaRepository;

import model.Departman;
import model.Doktor;
import model.Korisnik;
import model.Lek;
import model.Specijalizacija;
import model.Tehnicar;
import model.Uloga;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	@Autowired
	DepartmanRepository departmanRepository;

	@Autowired
	SpecijalizacijaRepository specijalizacijaRepository;

	@Autowired
	KorisnikRepository korisnikRepository;

	@Autowired
	DoktorRepository doktorRepository;

	@Autowired
	UlogaRepository ulogaRepository;

	@Autowired
	LekRepository lekRepository;

	@Autowired
	TehnicarRepository tehnicarRepository;

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
		specijalizacijaRepository.save(specijalizacija);

		return new ModelAndView("redirect:/admin/pocetna");
	}

	@GetMapping(value = "unesiDoktora")
	public String redirectToUnesiDoktora(HttpServletRequest request, ModelMap map) {
		Doktor doktor = new Doktor();
		Korisnik korisnik = new Korisnik();

		map.addAttribute("korisnik", korisnik);
		map.addAttribute("doktor", doktor);

		List<Specijalizacija> specijalizacije = specijalizacijaRepository.findAll();
		List<Departman> departmani = departmanRepository.findAll();

		departmani.sort((d1, d2) -> d1.getNaziv().compareTo(d2.getNaziv()));
		specijalizacije.sort((s1, s2) -> s1.getNaziv().compareTo(s2.getNaziv()));

		request.getSession().setAttribute("departmani", departmani);
		request.getSession().setAttribute("specijalizacije", specijalizacije);

		return "admin/unesiDoktora";
	}

	@PostMapping(value = "sacuvajDoktora")
	public ModelAndView saveDoktor(HttpServletRequest request, @ModelAttribute("doktor") Doktor doktor,
			@ModelAttribute("korisnik") Korisnik korisnik) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		korisnik.setPassword(passwordEncoder.encode(korisnik.getPassword()));

		Integer idSpecijalizacija = Integer.parseInt(request.getParameter("specijalizacija"));
		Specijalizacija specijalizacija = specijalizacijaRepository.findById(idSpecijalizacija).get();

		Integer idDepartman = Integer.parseInt(request.getParameter("departman"));
		Departman departman = departmanRepository.findById(idDepartman).get();

		Uloga uloga = ulogaRepository.findByNaziv("DOKTOR");

		korisnik.setUloga(uloga);

		doktor.setDepartman(departman);
		doktor.setSpecijalizacija(specijalizacija);
		doktor.setKorisnik(korisnik);

		departman.addDoktor(doktor);
		specijalizacija.addDoktor(doktor);

		korisnikRepository.save(korisnik);
		doktorRepository.save(doktor);

		return new ModelAndView("redirect:/admin/pocetna");
	}

	@GetMapping(value = "unesiLek")
	public String redirectToUnesiLek(Model model) {
		Lek lek = new Lek();

		model.addAttribute("lek", lek);

		return "admin/unesiLek";
	}

	@PostMapping(value = "sacuvajLek")
	public ModelAndView saveLek(@ModelAttribute("lek") Lek lek) {
		lekRepository.save(lek);

		return new ModelAndView("redirect:/admin/pocetna");
	}

	@GetMapping(value = "unesiTehnicara")
	public String redirectToUnesiTehnicara(HttpServletRequest request, Model model) {
		Tehnicar tehnicar = new Tehnicar();

		List<Departman> departmani = departmanRepository.findAll();
		request.getSession().setAttribute("departmani", departmani);

		model.addAttribute("tehnicar", tehnicar);

		return "admin/unesiTehnicara";
	}

	@PostMapping(value = "sacuvajTehnicara")
	public ModelAndView saveTehnicar(HttpServletRequest request, @ModelAttribute("tehnicar") Tehnicar tehnicar) {
		Integer idDepartman = Integer.parseInt(request.getParameter("departman"));
		Departman departman = departmanRepository.findById(idDepartman).get();

		tehnicar.setDepartman(departman);

		tehnicarRepository.save(tehnicar);

		return new ModelAndView("redirect:/admin/pocetna");
	}
}
