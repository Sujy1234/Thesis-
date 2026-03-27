#working directory
setwd("C:/Users/user/Desktop/mortality data/Chapter 3/Trend analysis")

#libraries
library(Kendall)
library(lmtest)
library(modifiedmk)

# data 
monthly_data <- read.csv("Monthly incidence data.csv", check.names = FALSE)

# Order month 
monthly_data$Month <- factor(
  monthly_data$Month,
  levels = c("January", "February", "March", "April", "May", "June",
             "July", "August", "September", "October", "November", "December"),
  ordered = TRUE
)

# Sort dataset
monthly_data <- monthly_data[order(monthly_data$Event, monthly_data$Year, monthly_data$Month), ]

# Extract unique mortality event types
events <- unique(monthly_data$Event)
events 

#Durbin-Watson test for each mortality event
dw_results <- list()

for (event in events) {
  
  event_data <- subset(monthly_data, Event == event)
  event_data <- event_data[order(event_data$`Time code`), ]
  
  # Linear model for trend over time
  lm_fit <- lm(Incidence ~ `Time code`, data = event_data)
  
  # Durbin-Watson test
  dw_test <- dwtest(lm_fit)
  dw_results[[event]] <- dw_test
  
  cat("\n=====================================\n")
  cat("Durbin-Watson test for:", event, "\n")
  print(dw_test)
}

#ACF plot for each mortality event
par(mfrow = c(2, 2))

for (event in unique(monthly_data$Event)) {
  event_data <- monthly_data[monthly_data$Event == event, ]
  event_data <- event_data[order(event_data$`Time code`), ]
  
  acf(event_data$Incidence, main = event)
}
#As the Durbin-Watson test and ACF plot reveal that the assumption of independence is violated for all the mortality event
#We need to switch to modified Mann-Kendall test.

#Modified Mann-Kendall test
mmk_results <- list()

for (event in events) {
  
  event_data <- subset(monthly_data, Event == event)
  event_data <- event_data[order(event_data$`Time code`), ]
  
  mmk_test <- mmkh(event_data$Incidence)
  mmk_results[[event]] <- mmk_test
  
  cat("\n=====================================\n")
  cat("Modified Mann-Kendall test for:", event, "\n")
  print(mmk_test)
}