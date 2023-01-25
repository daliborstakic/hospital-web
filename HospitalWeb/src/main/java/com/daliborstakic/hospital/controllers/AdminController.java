package com.daliborstakic.hospital.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.daliborstakic.hospital.repositories.PregledRepository;
import com.daliborstakic.hospital.repositories.SpecijalizacijaRepository;
import com.daliborstakic.hospital.repositories.TehnicarRepository;
import com.daliborstakic.hospital.repositories.UlogaRepository;
import com.daliborstakic.hospital.repositories.ZakazivanjeRepository;

import model.Departman;
import model.Doktor;
import model.Korisnik;
import model.Lek;
import model.Pregled;
import model.Specijalizacija;
import model.Tehnicar;
import model.Uloga;
import model.Zakazivanje;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JRDesignStyle;

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

	@Autowired
	PregledRepository pregledRepository;

	@Autowired
	ZakazivanjeRepository zakazivanjeRepository;

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

	@GetMapping(value = "generisiIzvestajOPregledima")
	public void generisiIzvestaj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Pregled> pregledi = pregledRepository.findAll();
		pregledi.sort((p1, p2) -> p1.getDatum().compareTo(p2.getDatum()));

		response.setContentType("text/html");
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(pregledi);
		InputStream inputStream = this.getClass().getResourceAsStream("/sviPregledi.jrxml");
		JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
		Map<String, Object> params = new HashMap<String, Object>();
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
		inputStream.close();

		JRDesignStyle jrDesignStyle = new JRDesignStyle();
		jrDesignStyle.setPdfEncoding("UTF-8");
		jasperPrint.addStyle(jrDesignStyle);

		response.setContentType("application/x-download");
		response.addHeader("Content-disposition", "attachment; filename=SviPregledi.pdf");
		OutputStream out = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, out);
	}

	@GetMapping(value = "generisiIzvestajOZakazivanjima")
	public String redirectToDatum() {
		return "admin/odaberiDatume";
	}

	@PostMapping(value = "izvestajOZakazivanjima")
	public void generisiIzvestajOZakazivanjima(HttpServletRequest request, HttpServletResponse response)
			throws ParseException, JRException, IOException {
		Date prviDatum = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("prviDatum"));
		Date drugiDatum = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("drugiDatum"));
		List<Zakazivanje> zakazivanja = zakazivanjeRepository.findAllWithDate(prviDatum, drugiDatum);
		zakazivanja.sort((p1, p2) -> p1.getDatum().compareTo(p2.getDatum()));

		response.setContentType("text/html");
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(zakazivanja);
		InputStream inputStream = this.getClass().getResourceAsStream("/svaZakazivanja.jrxml");
		JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pocetniDatum", request.getParameter("prviDatum"));
		params.put("krajniDatum", request.getParameter("drugiDatum"));
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
		inputStream.close();

		JRDesignStyle jrDesignStyle = new JRDesignStyle();
		jrDesignStyle.setPdfEncoding("UTF-8");
		jasperPrint.addStyle(jrDesignStyle);

		response.setContentType("application/x-download");
		response.addHeader("Content-disposition", "attachment; filename=SvaZakazivanja.pdf");
		OutputStream out = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, out);
	}
}
