/*Define global variables*/
global preoutcomes13 "teeth13 srhbi13 bmi13std IADL13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
global covars13 "age_ysl13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"

/*Generate bereavement period indicators*/
generate berv2_1315 = 0 if berv3_1316 == 0
replace berv2_1315 = 1 if berv3_1316 == 1
generate berv2_1516 = 0 if berv3_1316 == 0
replace berv2_1516 = 1 if berv3_1316 == 2

/*Program for Logistic Regression*/
program define run_logistic
    args year period
    local outcomes "teeth`year' smoke`year' sedentary`year'"
    foreach x of local outcomes {
        mi estimate, esampvaryok post: logistic `x' i.berv`period'##i.sex_2_13 $covars13 $preoutcomes13, cluster(popdens13)
        if "`period'" == "2_1315" | "`period'" == "2_1516" {
            nlcom exp(_b[1.berv`period'] + _b[1.sex_2_13] + _b[1.berv`period'#1.sex_2_13]) - exp(_b[1.berv`period']) - exp(_b[1.sex_2_13]) + 1
        }
    }
end

/*Program for Poisson Regression*/
program define run_poisson
    args year period
    local base_outcomes "hopeless`year' satisfaction`year'"
    local additional_outcomes = cond("`year'" == "19", "srhbi`year' dgns2ht`year' dgns2dm`year' RES`year' RIS`year' drink`year' exam`year'", "RES`year' RIS`year' drink`year' exam`year'")
    local outcomes "`base_outcomes' `additional_outcomes'"
    
    foreach x of local outcomes {
        mi estimate, esampvaryok `=cond("`year'"=="19", "irr", "")' post: poisson `x' i.berv`period'##i.sex_2_13 $covars13 $preoutcomes13, cluster(popdens13)
        if "`period'" == "2_1315" | "`period'" == "2_1516" {
            nlcom exp(_b[1.berv`period'] + _b[1.sex_2_13] + _b[1.berv`period'#1.sex_2_13]) - exp(_b[1.berv`period']) - exp(_b[1.sex_2_13]) + 1
        }
    }
end

/*Analysis Program for Linear Regression*/
program define run_linear
    args year
    local outcomes "bmi`year'std IADL`year'std gds`year'std happiness`year'std hobby`year'std sports`year'std senior`year'std learn`year'std meet`year'std numfr`year'std goout`year'std volunteer`year'std skills`year'std veg`year'std meat`year'std walk`year'std trust`year'std contribution`year'std attachment`year'std"
    
    foreach x of local outcomes {
        mi estimate: reg `x' i.berv3_1316##i.sex_2_13 $covars13 $preoutcomes13, cluster(popdens13)
    }
end

/* Main Analysis Execution */

*Logistic Regression Analysis
run_logistic 16 "3_1316" // Multiplicative interaction 2016
run_logistic 19 "3_1316" // Multiplicative interaction 2019
run_logistic 16 "2_1315" // Additive interaction 2016
run_logistic 16 "2_1516" // Additive interaction 2016
run_logistic 19 "2_1315" // Additive interaction 2019
run_logistic 19 "2_1516" // Additive interaction 2019

*Poisson Regression Analysis
run_poisson 16 "3_1316"  // Multiplicative interaction 2016
run_poisson 19 "3_1316"  // Multiplicative interaction 2019
run_poisson 16 "2_1315"  // Additive interaction 2016
run_poisson 16 "2_1516"  // Additive interaction 2016
run_poisson 19 "2_1315"  // Additive interaction 2019
run_poisson 19 "2_1516"  // Additive interaction 2019

*Linear Regression Analysis
run_linear 16 // Additive interaction 2016
run_linear 19 // Additive interaction 2019

/*Loneliness Analysis*/
mi estimate, esampvaryok post: reg lonliness19std i.berv3_1316##i.sex_2_13 $covars13 $preoutcomes13, cluster(popdens13)

/*Ikigai Analysis*/
global preoutcomes13_ikigai "$preoutcomes13 ikigai13" //Add ikigai to preoutcomes

*Additive Analysis
foreach period in "2_1315" "2_1516" {
    mi estimate, esampvaryok irr post: poisson ikigai19 i.berv`period'##i.sex_2_13 $covars13 $preoutcomes13_ikigai, cluster(popdens13)
    nlcom exp(_b[1.berv`period'] + _b[1.sex_2_13] + _b[1.berv`period'#1.sex_2_13]) - exp(_b[1.berv`period']) - exp(_b[1.sex_2_13]) + 1
}

*Multiplicative Analysis
mi estimate, esampvaryok irr post: poisson ikigai19 i.berv3_1316##i.sex_2_13 $covars13 $preoutcomes13_ikigai, cluster(popdens13)

/*Cohort Analysis*/
local cohort "rc0 rc2 dementia death"

*Additive Analysis
foreach period in "2_1315" "2_1516" {
    foreach x of local cohort {
        mi estimate, or post: logit `x' i.berv`period'##i.sex_2_13 $covars13 $preoutcomes13, cluster(popdens13)
        nlcom exp(_b[1.berv`period'] + _b[1.sex_2_13] + _b[1.berv`period'#1.sex_2_13]) - exp(_b[1.berv`period']) - exp(_b[1.sex_2_13]) + 1
    }
}

*Multiplicative Analysis
foreach x of local cohort {
    mi estimate, or post: logit `x' i.berv3_1316##i.sex_2_13 $covars13 $preoutcomes13, cluster(popdens13)
}
