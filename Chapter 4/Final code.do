*codes for health event data cleaning
version 15.1
*Woking directory 
 cd "C:\Users\user\Desktop\Chapter 5\Codes and shapefiles\CODES"
*Dataset
use "Sea lice data.dta",clear

*filter data
keep if inlist(month,4,5,6)/*keep months from April to June)*/
keep if inlist(fish_spec,2,6) /*keep only pink and chum*/
keep if inlist(sampling_unit,4,6,9)/*select only one migration route*/
drop if source==4/*Marine Environmental Research Program was not considererd in the analysis*/
*generate a grouping variable to inuclde as a random effect
egen unit_yearmonth= group(sampling_unit year month)


***********************************************************************
***********************MOTILES (any species)***************************
***********************************************************************


*Mixed-effect logistic model
*2006-2009
preserve

*filter year
drop if year>2009
drop if year<2006 /*Martin Krkosek's team did not collect data in this year*/

*Univariable mixed-effect logistic regression
melogit sealicemot_bin i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealicemot_bin i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealicemot_bin i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealicemot_bin i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealicemot_bin i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealicemot_bin i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicemot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*ICC
estat icc


*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
melogit sealicemot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

bayesstats summary 

restore

***********************motiles (any species)***************************
*Mixed-effect logistic model
*2010-2012
preserve

*filter year
drop if year<2010
drop if year>2012

*Univariable mixed-effect logistic model
melogit sealicemot_bin i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealicemot_bin i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealicemot_bin i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealicemot_bin i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealicemot_bin i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealicemot_bin i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect logistic model
melogit sealicemot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*ICC
estat icc

*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
melogit sealicemot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

bayesstats summary 

restore

***********************motiles (any species)***************************
*Mixed-effect logistic model
*2016-2023
preserve

*filter year
drop if year<2016


*Univariable mixed-effect logistic model
melogit sealicemot_bin i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealicemot_bin i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealicemot_bin i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealicemot_bin i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealicemot_bin i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealicemot_bin i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect logistic model
melogit sealicemot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or
testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*ICC
estat icc

*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
melogit sealicemot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

bayesstats summary 

restore



***********************motiles (any species)***************************
*Mixed-effect negative binomial model 
*2006-2009
preserve

*filter year
drop if year>2009
drop if year<2006 /*Martin Krkosek's team did not collect data in this year*/

*Univariable mixed-effect negative binomial model
menbreg sealice_mot i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealice_mot i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealice_mot i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealice_mot i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealice_mot i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealice_mot i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_mot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*Bayesian mixed-effect negative binomial model
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
menbreg sealice_mot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

bayesstats summary 
restore

***********************motiles (any species)***************************
*Mixed-effect negative binomial model 
*2010-2012
preserve

*filter year
drop if year<2010
drop if year>2012 

*Univariable mixed-effec negative binomial model
menbreg sealice_mot i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealice_mot i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealice_mot i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealice_mot i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealice_mot i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealice_mot i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_mot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*Bayesian mixed-effect negative binomial model
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
menbreg sealice_mot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

bayesstats summary 
restore

***********************motiles (any species)***************************
*Mixed-effect negative binomial model 
*2016-2023
preserve

*filter year
drop if year<2016


*Univariable mixed-effec negative binomial model
menbreg sealice_mot i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealice_mot i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealice_mot i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealice_mot i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealice_mot i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealice_mot i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_mot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*Bayesian mixed-effect negative binomial model
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
menbreg sealice_mot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

bayesstats summary 
restore


***********************************************************************
***********************NON-MOTILES (any species)***************************
***********************************************************************


*Mixed-effect logistic model
*2006-2009

preserve

*filter year
drop if year>2009
drop if year<2006 /*Martin Krkosek's team did not collect data in this year*/

*Univariable mixed-effect logistic regression
melogit sealicenmot_bin i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealicenmot_bin i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealicenmot_bin i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealicenmot_bin i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealicenmot_bin i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealicenmot_bin i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicenmot_bin i.length_cat##i.source i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

testparm i.length_cat#i.source /*significant interaction*/
testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

**multivariable mixed-effect logistic regression (to isolate the effect of source at differnt levels of fish length)
melogit sealicenmot_bin i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

*ICC
estat icc

*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
melogit sealicenmot_bin i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

bayesstats summary 

restore

***********************Non-motiles (any species)***************************
*Mixed-effect logistic model
*2010-2012

preserve

*filter year
drop if year<2010
drop if year>2012 

*Univariable mixed-effect logistic regression
melogit sealicenmot_bin i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealicenmot_bin i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealicenmot_bin i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealicenmot_bin i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealicenmot_bin i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealicenmot_bin i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicenmot_bin i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*ICC
estat icc

*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
melogit sealicenmot_bin i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

bayesstats summary 
restore

***********************Non-motiles (any species)***************************
*Mixed-effect logistic model
*2016-2023

preserve

*filter year
drop if year<2016 

*Univariable mixed-effect logistic regression
melogit sealicenmot_bin i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealicenmot_bin i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealicenmot_bin i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealicenmot_bin i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealicenmot_bin i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealicenmot_bin i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicenmot_bin i.length_cat##i.source i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

testparm i.length_cat#i.source /*significant interaction*/
testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

**multivariable mixed-effect logistic regression (to isolate the effect of source at differnt levels of fish length)
melogit sealicenmot_bin i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

*ICC
estat icc

*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
melogit sealicenmot_bin i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,or

bayesstats summary 

restore

***********************Non-motiles (any species)***************************
*Mixed-effect negative binomial model logistic model
*2006-2009
preserve

*filter year
drop if year>2009
drop if year<2006  /*Martin Krkosek's team did not collect data in this year*/

*Univariable mixed-effect negative binomial model
menbreg sealice_nmot i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealice_nmot i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealice_nmot i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealice_nmot i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealice_nmot i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealice_nmot i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_nmot i.length_cat##i.source i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,irr

testparm i.length_cat#i.source /*significant interaction*/
testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

**multivariable mixed-effect logistic regression (to isolate the effect of source at differnt levels of fish length)
menbreg sealice_nmot i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,irr


*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
menbreg sealice_nmot i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,irr

bayesstats summary 

restore

***********************Non-motiles (any species)***************************
*Mixed-effect negative binomial model 
*2010-2012
preserve

*filter year
drop if year<2010
drop if year>2012 

*Univariable mixed-effec negative binomial model
menbreg sealice_nmot i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealice_nmot i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealice_nmot i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealice_nmot i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealice_nmot i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealice_nmot i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_nmot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
menbreg sealice_nmot i.source i.length_cat i.fish_spec i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:, irr

bayesstats summary 

restore

***********************Non-motiles (any species)***************************
*Mixed-effect negative binomial model 
*2016-2023
preserve

*filter year
drop if year<2016


*Univariable mixed-effec negative binomial model
menbreg sealice_nmot i.source||unit_yearmonth:|| event_id:
testparm i.source
melogit sealice_nmot i.length_cat||unit_yearmonth:|| event_id:
testparm i.length_cat
melogit sealice_nmot i.fish_spec||unit_yearmonth:|| event_id:
testparm i.fish_spec
melogit sealice_nmot i.year||unit_yearmonth:|| event_id:
testparm i.year
melogit sealice_nmot i.month||unit_yearmonth:|| event_id:
testparm i.month
melogit sealice_nmot i.sampling_unit||unit_yearmonth:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_nmot i.length_cat##i.source i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,irr

testparm i.length_cat#i.source /*significant interaction*/
testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.year
testparm i.month
testparm i.sampling_unit

**multivariable mixed-effect logistic regression (to isolate the effect of source at differnt levels of fish length)
menbreg sealice_nmot i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,irr


*Bayesian mixed-effect logistic regression
bayes, rseed (123) burnin(20000) mcmcsize(60000): ///
menbreg sealice_nmot i.length_cat#i.source i.length_cat i.fish_spec  i.year i.month i.sampling_unit ||unit_yearmonth:|| event_id:,irr

bayesstats summary 

restore




*ANALYSIS FOR THE SUPPLEMENTARY MATERIAL

***********************************************************************
***********************MOTILES (any species)***************************
***********************************************************************

*Mixed-effect logistic model
*2003
preserve
*filter year
keep if year==2003
*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect logistic regression
melogit sealicemot_bin i.source||unit_month:|| event_id:
testparm i.source
melogit sealicemot_bin i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealicemot_bin i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealicemot_bin i.month||unit_month:|| event_id:
testparm i.month
melogit sealicemot_bin i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicemot_bin i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

*ICC
estat icc
restore



*Mixed-effect logistic model
*2004
preserve
*filter year
keep if year==2004
*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect logistic regression
melogit sealicemot_bin i.source||unit_month:|| event_id:
testparm i.source
melogit sealicemot_bin i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealicemot_bin i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealicemot_bin i.month||unit_month:|| event_id:
testparm i.month
melogit sealicemot_bin i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicemot_bin i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

*ICC
estat icc
restore

*Mixed-effect logistic model
*2005
preserve
*filter year
keep if year==2005
*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect logistic regression
melogit sealicemot_bin i.source||unit_month:|| event_id:
testparm i.source
melogit sealicemot_bin i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealicemot_bin i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealicemot_bin i.month||unit_month:|| event_id:
testparm i.month
melogit sealicemot_bin i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicemot_bin i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

*ICC
estat icc
restore


*Mixed-effect negative binomial model 
*2003
*filter year
keep if year==2003

*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect negative binomial model
menbreg sealice_mot i.source||unit_month:|| event_id:
testparm i.source
melogit sealice_mot i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealice_mot i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealice_mot i.month||unit_month:|| event_id:
testparm i.month
melogit sealice_mot i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_mot i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

restore



*Mixed-effect negative binomial model 
*2004
*filter year
keep if year==2004

*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect negative binomial model
menbreg sealice_mot i.source||unit_month:|| event_id:
testparm i.source
melogit sealice_mot i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealice_mot i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealice_mot i.month||unit_month:|| event_id:
testparm i.month
melogit sealice_mot i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_mot i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

restore



*Mixed-effect negative binomial model 
*2005
*filter year
keep if year==2005

*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect negative binomial model
menbreg sealice_mot i.source||unit_month:|| event_id:
testparm i.source
melogit sealice_mot i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealice_mot i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealice_mot i.month||unit_month:|| event_id:
testparm i.month
melogit sealice_mot i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_mot i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

restore




***********************************************************************
***********************NON-MOTILES (any species)***************************
***********************************************************************

*Mixed-effect logistic model
*2003
preserve
*filter year
keep if year==2003
*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect logistic regression
melogit sealicenmot_bin i.source||unit_month:|| event_id:
testparm i.source
melogit sealicenmot_bin i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealicenmot_bin i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealicenmot_bin i.month||unit_month:|| event_id:
testparm i.month
melogit sealicenmot_bin i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicenmot_bin i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

*ICC
estat icc
restore


*Mixed-effect logistic model
*2004
preserve
*filter year
keep if year==2004
*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect logistic regression
melogit sealicenmot_bin i.source||unit_month:|| event_id:
testparm i.source
melogit sealicenmot_bin i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealicenmot_bin i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealicenmot_bin i.month||unit_month:|| event_id:
testparm i.month
melogit sealicenmot_bin i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicenmot_bin i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

*ICC
estat icc
restore

*Mixed-effect logistic model
*2005
preserve
*filter year
keep if year==2005
*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect logistic regression
melogit sealicenmot_bin i.source||unit_month:|| event_id:
testparm i.source
melogit sealicenmot_bin i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealicenmot_bin i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealicenmot_bin i.month||unit_month:|| event_id:
testparm i.month
melogit sealicenmot_bin i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit


*multivariable mixed-effect logistic regression
melogit sealicenmot_bin i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:,or

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

*ICC
estat icc
restore




*Mixed-effect negative binomial model 
*2003
*filter year
keep if year==2003

*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect negative binomial model
menbreg sealice_nmot i.source||unit_month:|| event_id:
testparm i.source
melogit sealice_nmot i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealice_nmot i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealice_nmot i.month||unit_month:|| event_id:
testparm i.month
melogit sealice_nmot i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_nmot i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:, irr

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

restore



*Mixed-effect negative binomial model 
*2004
*filter year
keep if year==2004

*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect negative binomial model
menbreg sealice_nmot i.source||unit_month:|| event_id:
testparm i.source
melogit sealice_nmot i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealice_nmot i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealice_nmot i.month||unit_month:|| event_id:
testparm i.month
melogit sealice_nmot i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_nmot i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:, irr /*model could not converge*/

*Although the model could not converge here, the univariable mixed-effect logistic regression already suggest there was no significant differences between sampling groups.

*Mixed-effect negative binomial model 
*2005
*filter year
keep if year==2005

*Create a new hierarchial structure combining only sampling unit and month as there is a single year here
egen unit_month= group(sampling_unit month)

*Univariable mixed-effect negative binomial model
menbreg sealice_nmot i.source||unit_month:|| event_id:
testparm i.source
melogit sealice_nmot i.length_cat||unit_month:|| event_id:
testparm i.length_cat
melogit sealice_nmot i.fish_spec||unit_month:|| event_id:
testparm i.fish_spec
melogit sealice_nmot i.month||unit_month:|| event_id:
testparm i.month
melogit sealice_nmot i.sampling_unit||unit_month:|| event_id:
testparm i.sampling_unit

*Multivariable mixed-effect negative binomial model
menbreg sealice_nmot i.source i.length_cat i.fish_spec i.month i.sampling_unit ||unit_month:|| event_id:, irr 

testparm i.source
testparm i.length_cat
testparm i.fish_spec
testparm i.month
testparm i.sampling_unit

restore
