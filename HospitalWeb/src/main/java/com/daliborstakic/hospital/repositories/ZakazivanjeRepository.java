package com.daliborstakic.hospital.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import model.Pacijent;
import model.Zakazivanje;

public interface ZakazivanjeRepository extends JpaRepository<Zakazivanje, Integer> {
	List<Zakazivanje> findByPacijent(Pacijent pacijent);

	@Query("select z from Zakazivanje z where doktor.idDoktor = ?1 AND postojiPregled IS NULL")
	List<Zakazivanje> findByDoktor(Integer idDoktor);

	@Query("select z from Zakazivanje z where doktor.idDoktor = ?1 AND z.datum = ?2")
	List<Zakazivanje> findByDoktorToday(Integer idDoktor, Date date);

	@Query("select z from Zakazivanje z where z.datum BETWEEN ?1 and ?2")
	List<Zakazivanje> findAllWithDate(Date prviDatum, Date drugiDatum);
}
