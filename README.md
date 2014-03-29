great3-config
=============

config files for running on great3

---------
run-rgc*
- rgc-deep01 expfit
- real_galaxy ground constant
    - run-rgc-01 edg
    - run-rgc-02 edg i2 using 01 as expand shear, some minor bug fixes
    - run-rgc-04 edg i3 using 02 as expand shear

- rgc-deep02 bdf
- rgc-03 bdf trained from deep02

- rgc-deep03 exp
    * exp with psf ngauss 3 more burnin slightly tighter flat priors run-rgc-05
    * edg i4 using 04 as expand shear and deep03 for priors
