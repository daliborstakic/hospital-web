package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import model.Doktor;
import model.Specijalizacija;

public interface DoktorRepository extends JpaRepository<Doktor, Integer> {
	List<Doktor> findBySpecijalizacija(Specijalizacija specijalizacija);

	@Query("select d from Doktor d inner join d.korisnik k where k.username = ?1")
	Doktor findDoktorByUsername(String username);
}
