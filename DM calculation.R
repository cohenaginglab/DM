
###### IMPORTANT NOTES ######
# 1) Variables should all be in SI units before DSign calculation. 
#    Check file "Variable units.pdf" for details.
# 2) The reference population can either be ours or the study population itself ("own.rp").
# 3) The "var.list" can either be DM9, DM17, or DM31.
# 4) DSign is usually approximately log-normally distributed. Choose "log = T" if you want to 
#    calculate correlations or other statistical operations requiring a normal distribution.

##### Example of use: 
# data$DM17 <- DM_calc(data, var.list = DM17, own.rp = F, log = T)

# Biomarker lists
DM9 = c("mch", "rdw", "pltlt", "rbc",  "hb", "wbc", "baso_p", "hdl", "lympho_p")
           
DM17 = c("ggt", "mch", "rdw", "pltlt", "rbc", "hb", "ast", "wbc", "alkp", "baso_p", 
         "tot_prot", "hdl", "ca", "lympho_p", "alb", "k", "vitb12")
           
DM31 = c("hb", "hct", "rdw", "mch", "mchc", "pltlt", "rbc", "wbc", "neut_p", "mono_p", 
         "lympho_p", "baso_p", "ferritin", "glu", "ca", "cl", "sodium", "k", "vitb12", 
         "folate", "chol", "trig", "hdl", "alb", "alkp", "tot_prot", "ggt", "ldh", "uric_ac", 
         "alt", "ast")

DM_calc <- function(data, var.list = DM17, own.rp = F, log = F){
  
  log.vars <- c("alkp", "alt", "ast", "ferritin", "folate", "ggt", "glu", "ldh", "pltlt", 
                "rdw", "trig", "vitb12", "wbc")
  sqrt.vars <- "baso_p"
  
  dat <- data[complete.cases(data[ , var.list]), var.list]
  
  # Transform variables to approach normal distributions
  dat[ , var.list %in% log.vars] <- apply(dat[ , var.list %in% log.vars], 2, function(x) 
    log(ifelse(x==0, min(x[x>0])/2, x)))
  if("baso_p" %in% var.list){
    dat[ , "baso_p"] <- sqrt(dat[ , "baso_p"])
  }
  
  # Get information from the reference population (means, SDs, and variance-covariance matrix)
  if (own.rp == F){
    var.means <- read.csv("https://raw.githubusercontent.com/cohenaginglab/DM/main/DM31_means.csv")
    var.means <- var.means[match(var.list, var.means[ , 1]), 2]
    var.SDs <- read.csv("https://raw.githubusercontent.com/cohenaginglab/DM/main/DM31_SDs.csv")
    var.SDs <- var.SDs[match(var.list, var.SDs[ , 1]), 2]
    var.cov <- read.csv("https://raw.githubusercontent.com/cohenaginglab/DM/main/DM31_cov.csv")
    var.cov <- var.cov[match(var.list, var.cov[ , 1]), match(var.list, colnames(var.cov))]
  } else if(own.rp == T){
    var.means <- colMeans(dat[ , var.list])
    var.SDs <- apply(dat[ , var.list], 2, function(x) sd)
    var.cov <- cov(dat[ , var.list])
  }
  
  # Standardize variables by the means and SDs of the reference population
  for (j in 1:ncol(dat)){
    dat[ , j] <- (dat[ , j] - var.means[j]) / var.SDs[j]
  }
  
  # Calculate DM 
  DM <- sqrt(mahalanobis(as.matrix(dat), var.means, var.cov))
  
  if (log == T) DM <- log(DM)
  
  DM.return <- rep(NA, nrow(data))
  DM.return[complete.cases(data[ , var.list])==T] <- DM 
  
  return(DM.return)
}      




