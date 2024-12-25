**Female:
local contoutcomes16 = "bmi16std iid16std gds16std happiness16std hobby16std sports16std senior16std learn16std meet16std numfr16std goout16std volunteer16std skills16std veg16std meat16std walk16std trust16std contribution16std attachment16std"
local preoutcomes13 = "teeth13 srhbi13 bmi13std iid13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"

foreach x of local contoutcomes16 {
mi estimate:reg `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 0, cluster(popdens13) pformat(%5.4f)
eststo `x'
}

local contoutcomes19 = "bmi19std iid19std gds19std happiness19std hobby19std sports19std senior19std learn19std meet19std numfr19std goout19std volunteer19std skills19std veg19std meat19std walk19std trust19std contribution19std attachment19std"
local preoutcomes13 = "teeth13 srhbi13 bmi13std iid13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"

foreach x of local contoutcomes19 {
mi estimate:reg `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 0, cluster(popdens13)
eststo `x'
}

**Male:
local contoutcomes16 = "bmi16std iid16std gds16std happiness16std hobby16std sports16std senior16std learn16std meet16std numfr16std goout16std volunteer16std skills16std veg16std meat16std walk16std trust16std contribution16std attachment16std"
local preoutcomes13 = "teeth13 srhbi13 bmi13std iid13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"

foreach x of local contoutcomes16 {
mi estimate:reg `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 1, cluster(popdens13) pformat(%5.4f)
eststo `x'
}

local contoutcomes19 = "bmi19std iid19std gds19std happiness19std hobby19std sports19std senior19std learn19std meet19std numfr19std goout19std volunteer19std skills19std veg19std meat19std walk19std trust19std contribution19std attachment19std"
local preoutcomes13 = "teeth13 srhbi13 bmi13std iid13std dgns2ht13 dgns2dm13 gds13std hopeless13 happiness13std satisfaction13 hobby13std sports13std senior13std learn13std meet13std numfr13std goout13std RES13 RIS13 volunteer13std skills13std smoke13 drink13 veg13std meat13std walk13std exam13 trust13std contribution13std attachment13std"
local covars13 = "age_ysl13 sex_2_13 i.edu3_13 eqincome13 i.emp13 adl13 popdens13"

foreach x of local contoutcomes19 {
mi estimate:reg `x' i.berv3_1316 `covars13' `preoutcomes13' if sex_2_13 == 1, cluster(popdens13)
eststo `x'
}
