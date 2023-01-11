package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Doktor;

public interface DoktorRepository extends JpaRepository<Doktor, Integer> {

}
