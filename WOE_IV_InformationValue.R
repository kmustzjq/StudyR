library(InformationValue)
inputData <- readr::read_csv("D:/walter/adult.data.csv")
head(inputData)

inputData$ABOVE50K <- ifelse(inputData$income_class %in% "<=50K" ,0,1)


inputData$X1 <- NULL
inputData$income_class <- NULL
names(inputData) <- toupper(names(inputData))

#=>   AGE         WORKCLASS FNLWGT  EDUCATION EDUCATIONNUM       MARITALSTATUS
#=> 1  39         State-gov  77516  Bachelors           13       Never-married
#=> 2  50  Self-emp-not-inc  83311  Bachelors           13  Married-civ-spouse
#=> 3  38           Private 215646    HS-grad            9            Divorced
#=> 4  53           Private 234721       11th            7  Married-civ-spouse
#=> 5  28           Private 338409  Bachelors           13  Married-civ-spouse
#=> 6  37           Private 284582    Masters           14  Married-civ-spouse
#             OCCUPATION   RELATIONSHIP   RACE     SEX CAPITALGAIN CAPITALLOSS
#=> 1       Adm-clerical  Not-in-family  White    Male        2174           0
#=> 2    Exec-managerial        Husband  White    Male           0           0
#=> 3  Handlers-cleaners  Not-in-family  White    Male           0           0
#=> 4  Handlers-cleaners        Husband  Black    Male           0           0
#=> 5     Prof-specialty           Wife  Black  Female           0           0
#=> 6    Exec-managerial           Wife  White  Female           0           0
#     HOURSPERWEEK  NATIVECOUNTRY ABOVE50K
#=> 1           40  United-States        0
#=> 2           13  United-States        0
#=> 3           40  United-States        0
#=> 4           40  United-States        0
#=> 5           40           Cuba        0
#=> 6           40  United-States        0


factor_vars <- c ("WORKCLASS", "MARITAL_STATUS", "OCCUPATION", "RELATIONSHIP", "RACE", "SEX", "NATIVE_COUNTRY")  # get all categorical variables

inputData[,factor_vars] <-  lapply(inputData[,factor_vars] , factor)
# inputData <- data.frame(inputData)

all_iv <- data.frame(VARS=factor_vars, IV=numeric(length(factor_vars)), STRENGTH=character(length(factor_vars)), stringsAsFactors = F)  # init output dataframe
for (factor_var in factor_vars){
  # all_iv[all_iv$VARS == factor_var, "IV"] <- InformationValue::IV(X=inputData[, factor_var], Y=inputData$ABOVE50K)
  all_iv[all_iv$VARS == factor_var, "IV"] <- InformationValue::IV(X=dplyr::pull(inputData,factor_var), Y=inputData$ABOVE50K)
  # all_iv[all_iv$VARS == factor_var, "STRENGTH"] <- attr(InformationValue::IV(X=inputData[, factor_var], Y=inputData$ABOVE50K), "howgood")
  all_iv[all_iv$VARS == factor_var, "STRENGTH"] <- attr(InformationValue::IV(X=dplyr::pull(inputData,factor_var), Y=inputData$ABOVE50K), "howgood")
}

all_iv <- all_iv[order(-all_iv$IV), ]  # sort
#>           VARS         IV            STRENGTH
#>   RELATIONSHIP 1.53560810   Highly Predictive
#>  MARITALSTATUS 1.33882907   Highly Predictive
#>     OCCUPATION 0.77622839   Highly Predictive
#>      EDUCATION 0.74105372   Highly Predictive
#>            SEX 0.30328938   Highly Predictive
#>      WORKCLASS 0.16338802   Highly Predictive
#>  NATIVECOUNTRY 0.07939344 Somewhat Predictive
#>           RACE 0.06929987 Somewhat Predictive



for(factor_var in factor_vars){
  inputData[[factor_var]] <- WOE(X=inputData[, factor_var], Y=inputData$ABOVE50K)
}
#>   AGE  WORKCLASS FNLWGT  EDUCATION EDUCATIONNUM MARITALSTATUS OCCUPATION
#> 1  39  0.1608547  77516  0.7974104           13    -1.8846680  -0.713645
#> 2  50  0.2254209  83311  0.7974104           13     0.9348331   1.084280
#> 3  38 -0.1278453 215646 -0.5201257            9    -1.0030638  -1.555142
#> 4  53 -0.1278453 234721 -1.7805021            7     0.9348331  -1.555142
#> 5  28 -0.1278453 338409  0.7974104           13     0.9348331   0.943671
#> 6  37 -0.1278453 284582  1.3690863           14     0.9348331   1.084280

#>   RELATIONSHIP        RACE        SEX CAPITALGAIN CAPITALLOSS HOURSPERWEEK
#> 1    -1.015318  0.08064715  0.3281187        2174           0           40
#> 2     0.941801  0.08064715  0.3281187           0           0           13
#> 3    -1.015318  0.08064715  0.3281187           0           0           40
#> 4     0.941801 -0.80794676  0.3281187           0           0           40
#> 5     1.048674 -0.80794676 -0.9480165           0           0           40
#> 6     1.048674  0.08064715 -0.9480165           0           0           40

#>   NATIVECOUNTRY ABOVE50K
#> 1    0.02538318        0
#> 2    0.02538318        0
#> 3    0.02538318        0
#> 4    0.02538318        0
#> 5    0.11671564        0
#> 6    0.02538318        0