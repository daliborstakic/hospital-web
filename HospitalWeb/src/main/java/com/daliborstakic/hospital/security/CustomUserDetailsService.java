package com.daliborstakic.hospital.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.daliborstakic.hospital.repositories.KorisnikRepository;

import model.Korisnik;

public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	KorisnikRepository korisnikRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Korisnik user = korisnikRepository.findByUsername(username);

		if (user == null)
			throw new UsernameNotFoundException("Nije pronadjen korisnik sa datim korisnickim imenom!");

		return new CustomUserDetails(user);
	}

}
