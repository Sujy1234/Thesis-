#Working directory
setwd("C:/Users/user/Desktop/mortality data/Chapter 3/Descriptive graphs")

# Load the distance matrix from the CSV file
data <- read.csv("Incidence for all the FHZ.csv", check.names = FALSE)

# Load ggplot2 library
library(ggplot2)

# Reorder levels of the 'Moran's I' column to change legend order
data$Event <- factor(data$Event, levels = c( "Treatment", "Harmful algal blooms (HABs)","Low dissolved oxygen (Low-DO)", "Total MEs"))

#Reorder zone
data$Zone <-factor(data$Zone, levels= c("Vancouver Island Northwest Central","Mainland Far North" ,"Mainland Central","Vancouver Island West Central", "Mainland North Central","Mainland South Central","Vancouver Island Southwest Central","Vancouver Island Northwest", "Mainland Far South"
))

# Plot (Looks larger here but fine in saved one)
ggplot(data, aes(x = Year, y = Mean, fill = Event)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = `CI lower band`, ymax = `CI upper band`), 
                width = 0.4, size = 0.2, position = position_dodge(width = 0.9)) +
  facet_wrap(~Zone) +
  labs(x = "Year", 
       y = "Incidence rate per 100 active site-month", 
       fill = "Types of mortality events (MEs)") +
  scale_x_continuous(breaks = seq(2011, 2022, by = 1)) +
  scale_y_continuous(breaks = seq(0, 70, by = 5)) +
  scale_fill_manual(values = c("#8c510a", "#bf812d", "#80cdc1", "#01665e")) +
  theme(
    plot.background = element_rect(fill = "white"),
    axis.line = element_line(colour = "black", linewidth = 1),
    axis.text = element_text(size = 30, colour = "black"),  # Larger text for axis labels
    axis.title = element_text(size = 35, face = "bold"),    # Larger text for axis titles
    plot.title = element_text(size = 30, face = "bold"),
    legend.title = element_text(size = 30, face = "bold"),
    legend.text = element_text(color = "black", size = 30),
    legend.position = "top",
    axis.text.x = element_text(angle = 45, hjust = 1, size = 25),  # Larger x-axis text
    axis.text.y = element_text(size = 25),                         # Larger y-axis text
    strip.text = element_text(size = 30, face = "bold")            # Larger facet labels (zone names)
  )


#Save the plot as a high-resolution image (adjust the filename and parameters as needed)
ggsave("Incidence rate for all FHZ.png", width = 30, height = 30, dpi = 300)