/*Multiple imputation*/

*Create dummy variables
tabulate emp13, gen(emp13d)
tabulate edu3_13, gen(edu3_13d)

local covars "edu3_13d1 edu3_13d3 eqincome13 emp13d1 emp13d3 adl3ra13 cohab13"

#delimit ;
local continuous_outcomes "bmi13 iid13 walk13 gds13 happiness13 hobby13 sports13 senior13 learn13 meet13 numfr13 goout13 volunteer13 skills13 meat13 veg13 trust13 contribution13 attachment13
bmi16 iid16 walk16 gds16 happiness16 hobby16 sports16 senior16 learn16 meet16 numfr16 goout16 volunteer16 skills16 meat16 veg16 trust16 contribution16 attachment16
bmi19 iid19 walk19 gds19 happiness19 hobby19 sports19 senior19 learn19 meet19 numfr19 goout19 volunteer19 skills19 meat19 veg19 trust19 contribution19 attachment19"
;
#delimit cr

#delimit ;
local binary_outcomes "teeth13 srhbi13 dgns2ht13 dgns2dm13 hopeless13 satisfaction13 ikigai13 RES13 RIS13 smoke13 drink13 exam13 
teeth16 srhbi16 dgns2ht16 dgns2dm16 sedentary16 hopeless16 satisfaction16 RES16 RIS16 smoke16 drink16 exam16 
teeth19 srhbi19 dgns2ht19 dgns2dm19 sedentary19 hopeless19 satisfaction19 RES19 RIS19 smoke19 drink19 exam19"
;
#delimit cr

*Multiple imputation
mi set flong 
mi register imputed `covars' `continuous_outcomes' `binary_outcomes' berv3_1316
mi register regular age_ysl13 sex_2_13 popdens13
mi impute mvn `covars' `continuous_outcomes' `binary_outcomes' berv3_1316 = age_ysl13 sex_2_13 popdens13, ///
add(20) rseed(2345) initmcmc(em , iterate(200)) noisily force

*MI: Set and initialize variables
mi set
forvalues n = 0/20 {
    generate mi_num`n' = 0
    replace mi_num`n' = 1 if _mi_m == `n'
}

*Rounding values of imputed binary variables
local binary_outcomes "teeth13 srhbi13 dgns2ht13 dgns2dm13 hopeless13 satisfaction13 ikigai13 RES13 RIS13 smoke13 drink13 exam13 
teeth16 srhbi16 dgns2ht16 dgns2dm16 sedentary16 hopeless16 satisfaction16 RES16 RIS16 smoke16 drink16 exam16 
teeth19 srhbi19 dgns2ht19 dgns2dm19 sedentary19 hopeless19 satisfaction19 RES19 RIS19 smoke19 drink19 exam19"
foreach var of local binary_outcomes {
    replace `var' = round(`var')
    replace `var' = 1 if `var' > 1 & `var' < .
    replace `var' = 0 if `var' < 0
}

*Rounding values of IADL variables
local cat6vars "IADL13 IADL16 IADL19"
foreach var of local cat6vars {
    replace `var' = round(`var')
    replace `var' = 5 if `var' > 5 & `var' < .
    replace `var' = 0 if `var' < 0
}

*Rounding values of loneliness variables
replace loneliness19 = round(loneliness19)
replace loneliness19 = 6 if loneliness19 > 6 & loneliness19 < .
replace loneliness19 = 0 if loneliness19 < 0

*Rounding values of "No. of friends" variables
local cat5vars "numfr13 numfr16 numfr19"
foreach var of local cat5vars {
    replace `var' = round(`var')
    replace `var' = 5 if `var' > 5 & `var' < .
    replace `var' = 1 if `var' < 1
}

*Rounding values of social participation variables
local extended_cat6vars "hobby13 hobby16 hobby19 sports13 sports16 sports19 senior13 senior16 senior19 learn13 learn16 learn19 meet13 meet16 meet19 goout13 goout16 goout19 volunteer13 volunteer16 volunteer19 skills13 skills16 skills19"
foreach var of local extended_cat6vars {
    replace `var' = round(`var')
    replace `var' = 6 if `var' > 6 & `var' < .
    replace `var' = 1 if `var' < 1
}

*Rounding values of social capital variables
local trust_vars "trust13 contribution13 attachment13 trust16 contribution16 attachment16 trust19 contribution19 attachment19"
foreach var of local trust_vars {
    replace `var' = round(`var')
    replace `var' = 5 if `var' > 5 & `var' < .
    replace `var' = 1 if `var' < 1
}

*Rounding values of walking variables
foreach year in 13 16 19 {
    replace walk`year' = round(walk`year')
    replace walk`year' = 4 if walk`year' > 4 & walk`year' < .
    replace walk`year' = 1 if walk`year' < 1
}

*Rounding values of meat and vegetable consumption variables
foreach year in 13 16 19 {
    replace meat`year' = round(meat`year')
    replace meat`year' = 7 if meat`year' > 7 & meat`year' < .
    replace meat`year' = 1 if meat`year' < 1
    
    replace veg`year' = round(veg`year')
    replace veg`year' = 7 if veg`year' > 7 & veg`year' < .
    replace veg`year' = 1 if veg`year' < 1
}

*Rounding values of GDS variables
foreach year in 13 16 19 {
    replace gds`year' = round(gds`year')
    replace gds`year' = 15 if gds`year' > 15 & gds`year' < .
    replace gds`year' = 0 if gds`year' < 0
}

*Rounding values of happiness variables
foreach year in 16 19 {
    replace happiness`year' = round(happiness`year')
    replace happiness`year' = 10 if happiness`year' > 10 & happiness`year' < .
    replace happiness`year' = 0 if happiness`year' < 0
}

replace happiness13 = round(happiness13)
replace happiness13 = 10 if happiness13 > 10 & happiness13 < .
replace happiness13 = 1 if happiness13 < 1

*Covariates: Employment
generate emp13mi = .
replace emp13mi = cond(emp13d1 > emp13d3, 1, 3)
replace emp13mi = 2 if emp13d1 < 0.5 & emp13d3 < 0.5
forvalues n = 0/20 {
    tab emp13mi emp13 if mi_num`n' == 1, m
}

*Covariates: Education
generate edu3_13mi = .
replace edu3_13mi = 1 if max(edu3_13d1, edu3_13d3) == edu3_13d1
replace edu3_13mi = 3 if max(edu3_13d1, edu3_13d3) == edu3_13d3
replace edu3_13mi = 2 if max(edu3_13d1, edu3_13d3) < 0.5
forvalues n = 0/20 {
    tab edu3_13mi edu3_13 if mi_num`n' == 1, m
}

*Normalize population density
replace popdens13 = popdens13 * 0.001

*Covariates: ADL and Cohabitation
replace adl3ra13 = round(adl3ra13)
replace adl3ra13 = 3 if adl3ra13 > 3 & adl3ra13 < .
replace adl3ra13 = 1 if adl3ra13 < 1

replace cohab13 = round(cohab13)
replace cohab13 = 1 if cohab13 > 1 & cohab13 < .
replace cohab13 = 0 if cohab13 < 0

*Rounding values of exposure
replace berv3_1316 = round(berv3_1316)
replace berv3_1316 = 2 if berv3_1316 > 2 & berv3_1316 < .
replace berv3_1316 = 0 if berv3_1316 < 0 

*Standardize continuous variables
#delimit ;
local continuous_outcomes "bmi13 iid13 meat13 veg13 walk13 gds13 happiness13 hobby13 sports13 senior13 learn13 meet13 numfr13 goout13 volunteer13 skills13 trust13 contribution13 attachment13 
bmi16 iid16 meat16 veg16 walk16 gds16 happiness16 hobby16 sports16 senior16 learn16 meet16 numfr16 goout16 volunteer16 skills16 trust16 contribution16 attachment16
bmi19 iid19 meat19 veg19 walk19 gds19 happiness19 hobby19 sports19 senior19 learn19 meet19 numfr19 goout19 volunteer19 skills19 trust19 contribution19 attachment19"
#delimit cr

*Loop through continuous outcomes to standardize
foreach var of local continuous_outcomes {
    *Initialize new variable for standardized values
    generate `var'std = .
    *Standardize for each imputation set
    forvalues n = 0/20 {
        egen `var'std`n' = std(`var') if mi_num`n' == 1
        replace `var'std = `var'std`n' if mi_num`n' == 1
}

*Standardize eqincome13 separately
generate eqincome13std = .
forvalues n = 0/20 {
    egen eqincome13std`n' = std(eqincome13) if mi_num`n' == 1
    replace eqincome13std = eqincome13std`n' if mi_num`n' == 1
}
