package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import model.Obavestenje;

public interface ObavestenjeRepository extends JpaRepository<Obavestenje, Integer> {
	@Query("select o from Obavestenje o where o.kreator = 'DOKTOR' and o.pacijent.idPacijent = ?1")
	List<Obavestenje> findByPacijent(Integer idPacijent);

	@Query("select o from Obavestenje o where o.kreator = 'PACIJENT' and o.doktor.idDoktor = ?1")
	List<Obavestenje> findByDoktor(Integer idDoktor);

	@Transactional
	@Modifying
	@Query("delete from Obavestenje o where o.kreator = 'PACIJENT' and o.doktor.idDoktor = ?1")
	void deleteByDoktor(Integer idDoktor);

	@Transactional
	@Modifying
	@Query("delete from Obavestenje o where o.kreator = 'DOKTOR' and o.pacijent.idPacijent = ?1")
	void deleteByPacijent(Integer idPacijent);
}
