/*Modified Poisson regression analysis for non-rare binary outcomes*/

*Female
**2016
local poissonoutcomes = "srhbi16 dgns2ht16 dgns2dm16 hopeless16 satisfaction16 RES16 RIS16 drink16 exam16"
local preoutcomes13 = "teeth13 srhbi13 bmi13std IADL13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"
foreach x of local poissonoutcomes {
mi estimate, esampvaryok irr post: poisson `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 0, cluster(popdens13)
}	
**2019
local poissonoutcomes = "srhbi19 dgns2ht19 dgns2dm19 hopeless19 satisfaction19 RES19 RIS19 drink19 exam19"
local preoutcomes13 = "teeth13 srhbi13 bmi13std IADL13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"
foreach x of local poissonoutcomes {
mi estimate, esampvaryok irr post: poisson `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 0, cluster(popdens13)
}	

*Male
**2016
local poissonoutcomes = "srhbi16 dgns2ht16 dgns2dm16 hopeless16 satisfaction16 RES16 RIS16 drink16 exam16"
local preoutcomes13 = "teeth13 srhbi13 bmi13std IADL13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"
foreach x of local poissonoutcomes {
mi estimate, esampvaryok irr post: poisson `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 1, cluster(popdens13)
}	
**2019
local poissonoutcomes = "srhbi19 dgns2ht19 dgns2dm19 hopeless19 satisfaction19 RES19 RIS19 drink19 exam19"
local preoutcomes13 = "teeth13 srhbi13 bmi13std IADL13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"
foreach x of local poissonoutcomes {
mi estimate, esampvaryok irr post: poisson `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 1, cluster(popdens13)
}
