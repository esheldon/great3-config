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
        - clip fracdev [0,1]

        - about same with default cuts

        - interestingly, s/n cut helps

            for s/n > 40 I get Q=234  m ~  0.015
            for s/n > 45 I get Q=379  m ~  0.009
            for s/n > 50 I get Q=1030 m ~  0.002
            for s/n > 55 I get Q=668  m ~ -0.004
            for s/n > 60 I get Q=405  m ~ -0.009

        so there is some noise for sure here, hard to know if we should
        believe this cut at exactly 50 is meaningful

    - run-g302-rgc-05
        - same as 04, just added saving some output

    - run-g302-rgc-06
        - computed prior from deep05, unclipped
            - does great at low s/n now, but crappy
                at high s/n
            - so no clipping at high s/n is actually bad, or perhaps
                the underlying reason just manifests that way
            - prior without clipping is great at low s/n

    - run-g302-rgc-12
        - no prior but also no clip, not very good at any
            s/n

    - the following runs up to 12 explore various things, but
        the conclusion is that the prior (unclipped) from the deep fields is
        great at low s/n but not high.  Maybe the prior itself is just crap
        there, not sure, but have seen that doing the fit and clipping at high
        s/n works well, and applying prior without clipping works great at low
        s/n.  Is that just particular to these fields?

                          Q for various parameters

                          all s/n      high s/n (>50)   
                       ------------------------------
05 no prior, clipped   |    230     |       1030
12         no prior    |    340     |        160
13   prior, clipped    |    120     |        750
06            prior    |    600     |        130

    - things to explore

        - try cutting chi2per
        - try using combined g_sens

        - maybe the clipping of just high fracdev would help?
            - prior clipped [-1.5,1.1]?

        - maybe *not* fitting that spike at fracdev=0 is causing the problem
            at high s/n?
            - mike's plots show the fracdev should not evolve much, so
                maybe confirms something is fishy?

        - maybe cgc was crap *because* it fit the spike?

        - or maybe *fitting* spike at fracdev=1 is a problem?
            - it always gets fit, no way to remove it sensibly

        - should have priors for exp and dev separately, not the one
            from cm...!  Maybe this is messing up the high s/n?

        - ruled out
            - best of exp/dev
            - clipping to [0,1] after the fact with prior applied
            - separate priors for different s/n cut.  I tried s/n > 50 with new
              prior based on psf flux cut and it looked like crap

    - run-g302-rgc-13
        - use prior but clip fracdev [0,1]
            - still works quite well at high s/n, crap at low s/n

    - run-g302-rgc-14
        - clip [0,1] only for s/n > 35
        - in matrix above, this would perform most consistently
        - seems incorrect tough, as if it would not work on real
            data
        - worry it is some reflection on sample variance in
            great3?  Should create more low noise images
            to reduce sample variance in prior?

        - works pretty well only for high s/n... how can this be
            consistent with 06?  somehow breaking the ring test?

    - run-g302-rgc-15
        - realized I needed to update the TF prior when not
            clipping!

    - run-g302-rgc-16
        - try to choose exp or dev, with prior

    - run-g302-rgc-17
        - same as 06 but using BA for g prior
        - looks like crap!
            - the only change I recall is resetting the center

cgc

    - run-g302-cgc-deep01
    - run-g302-cgc-01
        - looks like crap!

great3 run03
------------

trying to put ring pairs together to help selections


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
