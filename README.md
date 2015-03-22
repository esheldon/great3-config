great3-config
=============

config files for running on great3

great3 run01
------------

rgc:
    - run-g301-rgc-01,  first run
        - forgot to record efficiency
        - using single psf

great3 run02
------------

Used psf parameters from Aaron and Mike

    - run-g302-rgc-01
        - cuts-sfit-01 (shear noise weighted)

            Q_c =  172.2700
            c+  = -0.00069 +/- 0.00008
            cx  = -0.00000 +/- 0.00006
            m+  = +0.02172 +/- 0.00325
            mx  = +0.01682 +/- 0.00242

        - cuts-sfit-02 (Ts2n weighted)

            Q_c =  487.4262
            c+  = -0.00060 +/- 0.00008
            cx  = +0.00003 +/- 0.00005
            m+  = -0.00347 +/- 0.00296
            mx  = -0.00616 +/- 0.00202

    # using 3 gauss psf
    - run-g302-rgc-01
        - looks better

    # composite fit, priors from g302-rgc-deep02
    - run-g302-rgc-03
        - looks very bad, m=0.05 for both components.  Must be a bug
        - note no need to iterate in isample, just use [2000]

        - could it be using BA as prior?  In nsim run it didn't matter,
            even with low s/n, although these were fairly large galaxies
            - maybe try great-des style dist
            - maybe run exp+dev sim for smaller sizes.
                - Note dev T should be not equal to exp to be realistic!

    # composite fit, priors from g302-rgc-deep02 with g fit prior
    # using GreatDES g prior (new parameters)
    - run-g302-rgc-04

        - about same with default cuts

        - interestingly, s/n cut helps

            for s/n > 40 I get Q=234  m ~  0.015
            for s/n > 45 I get Q=379  m ~  0.009
            for s/n > 50 I get Q=1030 m ~  0.002
            for s/n > 55 I get Q=668  m ~ -0.004
            for s/n > 60 I get Q=405  m ~ -0.009

        so there is some noise for sure here, hard to know if we should
        believe this cut at exactly 50 is meaningful

Exploring fracdev more

run-g302-rgc-deep03
    - another cm run but this time recording fracdev
run-g302-rgc-deep04
    - another cm run this time recording unclipped fracdev
run-g302-rgc-deep05
    - another cm run this time *using* unclipped fracdev



TODO
    - new great3 run without ring

    - use prior on fracdev
        - Seed fracdev fitter with best of
            linspace(-1.0,1.1,22)
    - use nm so prior can be used

old stuff
---------
rgc

- rgc-deep01 expfit
- real\_galaxy ground constant
    - run-rgc-01 edg
    - run-rgc-02 edg i2 using 01 as expand shear, some minor bug fixes
    - run-rgc-04 edg i3 using 02 as expand shear

    - run-rgc-05 edg i3 using 04 as expand shear, adding psf info, and newer
      fits to priors.  lower score, 270

    - run-rgc-06 similar to 04 but using g prior from lackner
        - score 412.  Ran another iteration from this and got 400; maybe noise
        is about +/- 10

- rgc-deep02 bdf
- rgc-03 bdf trained from deep02

- rgc-deep03 exp
    * exp with psf ngauss 3 more burnin slightly tighter flat priors run-rgc-05
    * edg i4 using 04 as expand shear and deep03 for priors

- rgc-deep04 exp
    - using cosmos g prior, all the rest is the same

run-cgc
---------
control ground constant

- cgc-deep01 sersic
