package com.daliborstakic.hospital.security;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;

@EnableWebSecurity
public class SecurityConfig {
	@Bean
	public UserDetailsService userDetailsService() {
		return new CustomUserDetailsService();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		return new CustomAccessDeniedHandler();
	}

	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/", "/auth").permitAll().antMatchers("/admin/**")
				.access("hasRole('ADMIN')").antMatchers("/pacijent/**").access("hasRole('PACIJENT')")
				.antMatchers("/doktor/**").access("hasRole('DOKTOR')").and().formLogin().loginPage("/auth/loginPage")
				.defaultSuccessUrl("/auth/pocetna").usernameParameter("username").passwordParameter("password")
				.loginProcessingUrl("/login").and().exceptionHandling().accessDeniedHandler(accessDeniedHandler()).and()
				.logout().logoutUrl("/auth/logout").logoutSuccessUrl("/").and().csrf();

		return http.build();
	}
}
