package com.daliborstakic.hospital.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daliborstakic.hospital.repositories.DoktorRepository;
import com.daliborstakic.hospital.repositories.KorisnikRepository;
import com.daliborstakic.hospital.repositories.PacijentRepository;
import com.daliborstakic.hospital.repositories.UlogaRepository;
import com.daliborstakic.hospital.security.CustomUserDetails;

import model.Doktor;
import model.Korisnik;
import model.Pacijent;
import model.Uloga;

@Controller
@RequestMapping("/auth")
public class AuthController {
	@Autowired
	UlogaRepository ulogaRepository;

	@Autowired
	KorisnikRepository korisnikRepository;

	@Autowired
	PacijentRepository pacijentRepository;

	@Autowired
	DoktorRepository doktorRepository;

	@GetMapping(value = "loginPage")
	public String redirectToLoginPage() {
		return "login";
	}

	@GetMapping(value = "registerUser")
	public String newUser(ModelMap map) {
		Korisnik user = new Korisnik();
		Pacijent pacijent = new Pacijent();

		map.addAttribute("user", user);
		map.addAttribute("pacijent", pacijent);

		return "register";
	}

	@PostMapping(value = "register")
	public String saveUser(@ModelAttribute("user") Korisnik korisnik, @ModelAttribute("pacijent") Pacijent pacijent) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		korisnik.setPassword(passwordEncoder.encode(korisnik.getPassword()));

		Uloga uloga = ulogaRepository.findByNaziv("PACIJENT");
		korisnik.setUloga(uloga);

		uloga.addKorisnik(korisnik);
		pacijent.setKorisnik(korisnik);

		korisnikRepository.save(korisnik);
		pacijentRepository.save(pacijent);

		return "login";
	}

	@GetMapping(value = "pocetna")
	public ModelAndView redirectToHomePage(HttpServletResponse response) throws IOException {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof CustomUserDetails) {
			Korisnik korisnik = korisnikRepository.findByUsername(((CustomUserDetails) principal).getUsername());

			String stranica = switch (korisnik.getUloga().getNaziv()) {
			case "ADMIN" -> "/admin/pocetna";
			case "DOKTOR" -> "/doktor/pocetna";
			default -> "/pacijent/pocetna";
			};

			return new ModelAndView("redirect:" + stranica);
		}

		return new ModelAndView("redirect:/");
	}

	@GetMapping(value = "/logout")
	public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		if (auth != null) {
			SecurityContextHolder.getContext().setAuthentication(null);
		}

		return "redirect:/auth/loginPage";
	}

	@GetMapping(value = "prikazDoktora")
	public String redirectToPrikazDoktora(HttpServletRequest request) {
		List<Doktor> doktori = doktorRepository.findAll();

		request.setAttribute("doktori", doktori);

		return "prikazDoktora";
	}
}
