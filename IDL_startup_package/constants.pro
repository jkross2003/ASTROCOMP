;
; set some constants 
; base unit eV
;
  common physicalconstants, pc, m_sol, r_sol, year, au, k_b, g_n, mp, $
     m_sol_symb, mach_symb, ell_symb, absbar_symb, perp_symb, para_symb

  m_sol_symb = 'M!D!9n!3!N'
  mach_symb = '!13M!X'
  ell_symb = '!12l!X'
  absbar_symb = '!19'+string("174B)+'!X
  prime_symb = '!9' + string("140B) + '!X'
  perp_symb = '!9x!X'
  para_symb = '!9#!X'

  SPEED_OF_LIGHT = 2.99792458d+10   ; speed of light [cm/s]
  MASS_ENERGY    = 1.7827d-33       ; mass energy relation [g/eV] 
  TIME_ENERGY    = 6.5822d-16       ; time-energy relation [sec eV]
  LENGTH_ENERGY  = 1.9733d-5        ; length-energy relation [cm eV]
  K_eV           = 1.d0/1.1605d4    ; Kelvin eV relation [eV/K]
  erg_eV         = 1.60206e-12      ; erg-eV relation [erg/eV]
;  MU_0           = 1.1294d22       $; vacuum permeability [Gauss^2/(g/cm^3)]
;                   *MASS_ENERGY/(LENGTH_ENERGY^3.d0) ;    [Gauss^2/eV^4]
  MU_0           = 1.d0/(1.9084d-4) ; rho_mag conversion factor (Kolb, p.500)
  m_e            = 5.11d5           ; electron rest mass [eV]
  M_PROTON       = 0.938272d9       ; proton rest mass [eV]
  M_PI           = 1.396d8          ; pi^+ mass [eV]
  G_F            = 1.1663d-23       ; Fermi's constant [eV^{-2}]
                                    ; Thomson cross section [eV^{-2}]  
  SIGMA_T        = 6.6524d-25/(LENGTH_ENERGY^2.d0)
  a_Bohr         = 5.2918d-09/(LENGTH_ENERGY) ; Bohr radius (1/(alpha * m_e))
;  A_SB           = (!DPI^2.d0)/30.d0 ; 2x Stefan-Boltzmann constant
  SIGMA_SB       = 5.67d-5          ; [ergs cm^-2 sec^-1 K^-4] Stefan-Boltzmann constant
  a_rad          = 4.d0 * sigma_sb / speed_of_light ; [ergs cm^-3 K^-4]
  MPL            = 1.2211d28        ; planck mass [eV]
;  pre factor for relativistic fermions
  PRE_F          = 3.d0/4.d0/!DPI^2*1.202056903d0 
  PC             = 3.0856d18        ; [cm pc^{-1}]    1 parsec [cm]
  AU             = 1.496d13         ; astronomical unit [cm]
  EVPC           = LENGTH_ENERGY/PC ; [eV pc]

  OMEGA_0     =  1.0d0                      ; total energy density
  OMEGA_MATT  =  0.3d0                      ; energy density of dark matter
  OMEGA_B     =  0.05d0                     ; baryonic energy density
  RHO_0       =  8.0992d-11                 ; critical density today [h^2 eV^4]
  RHO_GAMMA   =  2.0747d-15                 ; photon energy density today [(T_2.75 eV)^4]
  H_0         =  0.70d0                     ; Hubble today constant [100 km/sec/Mpc]
  T_DEC       =  0.26d0                     ; temperature @ photon decoupling
  T_EQ        =  5.5d0*OMEGA_MATT*H_0^2     ; temperature @ matter radiation equality
  T_0         =  2.75d0*K_eV                ; photon temperature today [eV]

  ALPHA_0     = SIGMA_T*RHO_GAMMA/M_PROTON  ; drag force today [eV]

  mp          = m_proton*MASS_ENERGY        ; proton mass [g]
  G_N         = 6.6725985d-08 ; Newton constant [g^-1 cm^3 sec^-2]
  h_planck    = 6.6260680e-27 ; Plancks constant [cm^2 g s^-1] [erg sec]
  ;           = 4.13566743.d-15 [eV sec]
  k_B         = 1.38065812d-16 ; Boltzmann constant [cm^2 s^-2 g K^-1] [erg/K]
  ;           = 8.617343d-5 [eV K^-1] Boltzmann
  M_sol       = 1.989d33                    ; solar mass [g]
  R_sol       = 6.96d10                     ; solar radius [cm]
  L_sol       = 3.85d33                     ; solar luminosity [erg sec^-1]

  year        = 31557600.d0                 ; year [sec]
  day         = 3600.d0*24.d0               ; day [sec]
END
