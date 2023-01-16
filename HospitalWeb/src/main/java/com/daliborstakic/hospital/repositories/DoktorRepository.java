package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Doktor;
import model.Specijalizacija;

public interface DoktorRepository extends JpaRepository<Doktor, Integer> {
	List<Doktor> findBySpecijalizacija(Specijalizacija specijalizacija);
}
