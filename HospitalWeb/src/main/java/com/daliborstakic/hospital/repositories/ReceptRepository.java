package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Recept;

public interface ReceptRepository extends JpaRepository<Recept, Integer> {

}
