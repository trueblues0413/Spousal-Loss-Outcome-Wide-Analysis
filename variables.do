/*Characteristics*/
*Sex
label define sex 0 "Female" 1 "Male"
foreach i in 13 16 19{
recode sex_2_`i' (1=1) (2=0)
label values sex_2_`i' sex
label variable sex_2_`i' "Gender"
}

*ADL
recode adl3ra13 (1=0) (2/3=1), gen(adl13)
label variable adl13 "ADL dependence in 2013"

*Education
label define edu3 1 "≤9" 2 "10-12" 3 "≥13" 
recode educ5_13 (1 2=1)(3=2)(4=3)(5=.), gen(edu3_13)
label values edu3_13 edu3
label variable edu3_13 "Education"

*Equivalent income
drop clincome_13
gen clincome_13 = hhine_13
recode clincome_13 (1=25)(2=75)(3=125)(4=175)(5=225)(6=275)(7=350)(8=450)(9=550)(10=650)(11=750)(12=850)(13=950)(14=1100)(15=1300)
recode mebr2nb13 (0=.)
gen eqincome13 = clincome_13 / sqrt(mebr2nb13)
label variable eqincome13 "Household income"

*Employment
label define emp 0 "Never" 1 "Past worker" 2 "Current worker"
recode empl3pt13 (1=2) (2=1) (3=0), gen(emp13) 
label values emp13 emp

*Marital status
recode mari5st13 (1=1) (2/5=0), gen(married13) 
label variable married13 "Married"
label values married13 yesno
ta married13

*Living with someone*
generate cohab13 = .
replace cohab13 = 1 if mebr2nb13 >=3 & mebr2nb13 <.
replace cohab13 = 0 if mebr2nb13 == 1|mebr2nb13 == 2
label variable cohab13 "Living with someone"
label values cohab13 yesno

*Population density
generate popdens13 = .
label variable popdens13 "Population density"
replace popdens13 = 172.3 if mcode13 == 1453
replace popdens13 = 106.7 if mcode13 == 1458
replace popdens13 = 35.5 if mcode13 == 1459
replace popdens13 = 324.8 if mcode13 == 2206
replace popdens13 = 941.4 if mcode13 == 4211
replace popdens13 = 4008.1 if mcode13 == 12217
replace popdens13 = 9268.3 if mcode13 == 14100
replace popdens13 = 1212.2 if mcode13 == 15100
replace popdens13 = 1191.4 if mcode13 == 19214
replace popdens13 = 79.7 if mcode13 == 19364
replace popdens13 = 7202.7 if mcode13 == 23100
replace popdens13 = 1723.6 if mcode13 == 23201
replace popdens13 = 2601.3 if mcode13 == 23205
replace popdens13 = 2008.3 if mcode13 == 23209 
replace popdens13 = 1223.7 if mcode13 == 23213
replace popdens13 = 1085.4 if mcode13 == 23216
replace popdens13 = 2535.1 if mcode13 == 23222
replace popdens13 = 2621.4 if mcode13 == 23223
replace popdens13 = 1965.0 if mcode13 == 23224
replace popdens13 = 476.4 if mcode13 == 23231
replace popdens13 = 1695.6 if mcode13 == 23442
replace popdens13 = 749.4 if mcode13 == 23445
replace popdens13 = 723.7 if mcode13 == 23446
replace popdens13 = 1840.6 if mcode13 == 23447
replace popdens13 = 418.1 if mcode13 == 24470
replace popdens13 = 4832.1 if mcode13 == 28100
replace popdens13 = 147.6 if mcode13 == 29449
replace popdens13 = 1354.5 if mcode13 == 37202
replace popdens13 = 365.4 if mcode13 == 42208
replace popdens13 = 415.0 if mcode13 == 43441

/*Outcome variables*/
*1. Physical and cognitive health
**No natural teeth remaining
recode teeth4_13 (1=1)(2/5=0), gen(teeth13)
label values teeth13 yesno
foreach i in 16 19{
recode teeth5_`i' (1=1)(2/5=0), gen(teeth`i')
label values teeth`i'
label variable teeth`i' "No remaining natural teeth"
}

**Self-rated health
label define srhbi 0 "Bad" 1 "Good"
foreach i in 13 16 19{
gen srh`i' = srh_4_`i' - 1
recode srh`i' (0/1=1)(2/3=0), gen(srhbi`i')
label values srhbi`i' srhbi
label variable srh`i' "Self-rated health"
}

**BMI
drop height* weight* bmi
foreach i in 13 16 19{
gen height`i' = 100*hghtmz_`i'+ hghtcz_`i'
gen weight`i' = wghtz_`i'
gen bmi`i' = weight`i'/(height`i'/100)^2
label variable bmi`i' "BMI"
}

**IADL
drop iadl2bt13_01 iadl2pc13_01 iadl2me13_01 iadl2pl13_01 iadl2dp13_01 iadl2dc13_01 iadl2np13_01 iadl2bm13_01 iadl2hl13_01 iadl2vf13_01 iadl2gc13_01 iadl2vp13_01 iadl2ty13_01
recode iadl2bt13 iadl2pc13 iadl2me13 iadl2pl13 iadl2dp13 iadl2dc13 iadl2np13 iadl2bm13 iadl2hl13 iadl2vf13 iadl2gc13 iadl2vp13 iadl2ty13 (1=1) (2=0), ///
gen(iadl2bt13_01 iadl2pc13_01 iadl2me13_01 iadl2pl13_01 iadl2dp13_01 iadl2dc13_01 iadl2np13_01 iadl2bm13_01 iadl2hl13_01 iadl2vf13_01 iadl2gc13_01 iadl2vp13_01 iadl2ty13_01)	

foreach i in 16 19{
	recode iadl3bt_`i' iadl3pc_`i' iadl3me_`i' iadl3pl_`i' iadl3dp_`i' (1 2=1)(3=0) ///
	,gen(iadl2bt`i'_01 iadl2pc`i'_01 iadl2me`i'_01 iadl2pl`i'_01 iadl2dp`i'_01)
	recode iadl2dc`i' iadl2np`i' iadl2bm`i' iadl2hl`i' iadl2vf`i' iadl2gc`i' iadl2vp`i' iadl2ty`i' (1=1) (2=0) ///
	,gen(iadl2dc`i'_01 iadl2np`i'_01 iadl2bm`i'_01 iadl2hl`i'_01 iadl2vf`i'_01 iadl2gc`i'_01 iadl2vp`i'_01 iadl2ty`i'_01)
}

foreach i in 13 16 19{
	gen IADL`i' = iadl2bt`i'_01 + iadl2pc`i'_01 + iadl2me`i'_01 + iadl2pl`i'_01 + iadl2dp`i'_01 + iadl2dc`i'_01 + iadl2np`i'_01 ///
	+ iadl2bm`i'_01 + iadl2hl`i'_01 + iadl2vf`i'_01 + iadl2gc`i'_01 + iadl2vp`i'_01 + iadl2ty`i'_01
	label variable IADL`i' "IADL(0-13)"
}
	
**Chronic disease: hypertension, diabetes
foreach i in 13 16 19{
	label variable dgns2ht`i' "Hypertension"
	label variable dgns2dm`i' "Diabetes"
	elabel values dgns2ht`i' dgns2dm`i' yesno
}

*2. Health behaviors**
**Smoking
gen smoke13=smok4_13
recode smoke13 (2/3=0)
label define smoke 0 "non-smoker" 1 "smoker"
label value smoke13  smoke

foreach i in 16 19{
recode smok5_`i' (1/2=1) (3/5=0), gen(smoke`i')
label values smoke`i' smoke
}

**Alcohol
recode alcl3_13 (1=1) (2 3=0), gen(drink13)
foreach i in 16 19{
recode alcl4_`i' (1=1) (2/4=0), gen(drink`i')
}

foreach i in 13 16 19{
label variable drink`i' "Drinking"
label values drink`i' yesno
}

**Eating fruits and vegetables/eating meat and fish/walking
foreach i in 13 16 19{
generate veg`i' = 8 - fq7veg`i'
generate meat`i' = 8 - fq7prt`i'
generate walk`i' = walk4tm`i'
elabel variable veg`i' "Freq of eating fruits and vegetables" meat`i' "Freq of eating meat and fish" walk`i' "Walking time"
}

**Sedentary lifestyle
gen sedentary16=.
replace sedentary16=0 if wave16==1 &  tm3sit16!=. & tm3sp16!=. & tm3wlk16!=.
replace sedentary16=1 if tm3sit16==3 & tm3sp16<=2 & tm3wlk16<=2

gen sedentary19=.
replace sedentary19=0 if wave19==1 &  tm3sit19!=. & tm3sp19!=. & tm3wlk19!=.
replace sedentary19=1 if tm3sit19==3 & tm3sp19<=2 & tm3wlk19<=2

elabel variable sedentary16 "Sedentary lifestyle" sedentary19 "Sedentary lifestyle"
elabel values sedentary16 sedentary19 yesno

**Health screening
foreach i in 13 16 19{
recode exam4_`i' (2/4=0)(1=1), gen(exam`i')
label variable exam`i' "Health check-up"
label values exam`i' yesno
}

*3. Mental health
**Geriatric depression scale
foreach x in 13 16 19{
recode gds_2sf`x' gds_2fg`x' gds_2hp`x' gds_2lb`x' gds_2vt`x' (2=1)(1=0)(-9999=.), ///
gen(gds15_1_`x' gds15_6_`x' gds15_8_`x' gds15_12_`x' gds15_13_`x')
recode gds_2sa`x' gds_2ai`x' gds_2em`x' gds_2br`x' gds_2be`x' gds_2nd`x' gds_2hm`x' gds_2fr`x' gds_2nh`x' gds_2oc`x' (1=1)(2=0)(-9999=.), ///
gen (gds15_2_`x' gds15_3_`x' gds15_4_`x' gds15_5_`x' gds15_7_`x' gds15_9_`x' gds15_10_`x' gds15_11_`x' gds15_14_`x' gds15_15_`x')
gen gds`x' = gds15_1_`x' + gds15_6_`x' + gds15_8_`x' + gds15_12_`x' + gds15_13_`x' + gds15_2_`x' + gds15_3_`x' + gds15_4_`x' + gds15_5_`x' + gds15_7_`x' + gds15_9_`x' + gds15_10_`x' + gds15_11_`x' + gds15_14_`x' + gds15_15_`x'
label variable gds`x' "Depressive symptoms (GDS-15)"
}

**Hopelessness
foreach i in 13 16 19{
recode gds_2nh`i'(1=1)(2=0), gen(hopeless`i')
label variable hopeless`i' "Hopeless"
}

**Loneliness
recode soc3lac19 soc3lon19 soc3iso19 (1=0) (2=1) (3=2)
generate loneliness19 = soc3lac19 + soc3lon19 + soc3iso19
label variable loneliness19 "Loneliness"

*4. Subjective well-being
**Happiness
gen happiness13=happy10_13
gen happiness16=happy11_16
gen happiness19=happy11_19

foreach i in 13 16 19 {
label variable happiness`i' "Happiness"
}

**Life satisfaction
foreach i in 13 16 19{
recode gds_2sf`i'(1=1)(2=0), gen(satisfaction`i')
label variable satisfaction`i' "Life satisfaction"
label values satisfaction`i' yesno
}

**Ikigai
recode pil_3_13 (1=1)(2=0), gen(ikigai13)
recode pil_2_19 (1=1)(2=0), gen(ikigai19)
foreach i in 13 19{
	label variable ikigai`i' "Ikigai"
	label values ikigai`i' yesno
}

*5. Social well-being
**Participation in hobby group/sports group/senior club/learning group/frequency of meeting friends**
foreach i in 13 16 19{
recode cmnt6hb`i' cmnt6sp`i' cmnt6sg`i' cmnt6le`i' meet6fr`i' (6=1) (5=2) (4=3) (3=4) (2=5) (1=6), gen(hobby`i' sports`i' senior`i' learn`i' meet`i')
elabel variable hobby`i' "Hobby group participation" sports`i' "Sports club participation" senior`i' "Senior club participation" learn`i' "Learning group participation" meet`i' "Frequency of meeting friends"
}

**No. of meeting friends
foreach i in 13 16 19{
generate numfr`i' = num5fr`i'
label variable numfr`i' "No. of friends"
}

**Going out
foreach i in 13 16 {
generate goout`i' = 7 - gout6fq`i'
}
generate goout19 = 7 - gout7fq19
foreach i in 13 16 19{
label variable goout`i' "Frequency of going out"
}

**Emotional/instrumental social support
foreach i in 13 16 19{
recode lsnd2no`i' card2no`i' (1=0) (0=1), gen(RES`i' RIS`i')
elabel variable RES`i'"Received emotional support" RIS`i' "Received instrumental support"
label values RES`i' RIS`i' yesno
}

*6. Prosocial/ altruistic behaviors
**Participation in volunteer groups/skills
foreach i in 13 16 19{
recode cmnt6vl`i' cmnt6sk`i' (6=1) (5=2) (4=3) (3=4) (2=5) (1=6), gen(volunteer`i' skills`i')
elabel variable volunteer`i' "Volunteering" skills`i' "Skills"
}

*7. Cognitive social capital
foreach i in 13 16 19{
	recode fot_5_`i' cmn5cntr`i' cmn5at`i' (5=1) (4=2) (3=3) (2=4) (1=5), gen(trust`i' contribution`i' attachment`i')
	elabel variable trust`i' "Community trust" contribution`i' "Community contribution" attachment`i' "Community attachment"
}

/*Explanatory variables*/
generate berv3_1316 = .
replace berv3_1316 = 0 if mari5st13 == 1 & mari5st16 == 1
replace berv3_1316 = 1 if mari5st13 == 1 & mari5st16 == 2
replace berv3_1316 = 2 if berv3_1316 == 1 & evnt2sd16 == 1
label variable berv3_1316 "Bereavement"
label define berv3 0 "No" 1 "Bereavement 2013-2015" 2 "Bereavement 2015-2016"
label values berv3_1316 berv3
