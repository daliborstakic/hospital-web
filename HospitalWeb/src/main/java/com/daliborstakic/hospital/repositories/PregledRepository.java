package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import model.Pacijent;
import model.Pregled;

public interface PregledRepository extends JpaRepository<Pregled, Integer> {
	@Query("select p from Pregled p inner join p.pacijent pac where pac.ime LIKE ?1 OR pac.prezime LIKE ?1 AND p.doktor.idDoktor = ?2")
	List<Pregled> findByDoktorAndPacijent(String pacijent, Integer idDoktor);

	List<Pregled> findByPacijent(Pacijent pacijent);
}
