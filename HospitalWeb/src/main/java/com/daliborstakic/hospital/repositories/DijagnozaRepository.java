package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Dijagnoza;

public interface DijagnozaRepository extends JpaRepository<Dijagnoza, Integer> {
	@Query("SELECT d FROM Dijagnoza d JOIN d.simptoms s WHERE s.idSimptom IN :symptomIds")
	List<Dijagnoza> findBySymptomIds(@Param("symptomIds") List<Integer> symptomIds);
}
