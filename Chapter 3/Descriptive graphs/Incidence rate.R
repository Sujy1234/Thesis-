#Working directory
setwd("C:/Users/user/Desktop/mortality data/R file/new for line on top")

# Load the distance matrix from the CSV file
data <- read.csv("Incident for main and overall.csv", check.names = FALSE)

# Load ggplot2 library
library(ggplot2)

# Reorder levels of the 'Moran's I' column to change legend order
data$Event <- factor(data$Event, levels = c( "Treatment","Harmful algal blooms (HABs)","Low dissolved oxygen (Low-DO)", "Total MEs"))


# Plot
  ggplot(data, aes(x = Year, y = Mean, fill = Event)) +
    geom_bar(stat = "identity", position = "dodge") +
    geom_errorbar(aes(ymin = `CI lower band`, ymax = `CI upper band`), width = 0.4,size = 0.2, position = position_dodge(width = 0.9)) +
    labs(x = "Year", y = "Incidence rate per 100 active site-month", fill = "Types of mortality events (MEs)") +  # Updated legend title
    scale_x_continuous(breaks = seq(2011, 2022, by = 1)) +
    scale_y_continuous(breaks = seq(0, 24, by = 2))+
    scale_fill_manual(values = c("#8c510a","#bf812d", "#80cdc1", "#01665e")) +  # Color scheme
    theme(
      plot.background = element_rect(fill = "white"),  # Set the background color of the entire plot
      axis.line = element_line(colour = "black", linewidth = 1),  # Customize axis lines
      axis.text = element_text(size = 14, colour = "black"),  # Customize axis text size and color
      axis.title = element_text(size = 15),  # Customize axis title size and style
      plot.title = element_text(size = 16, face = "bold"),
      legend.title = element_text(size = 12,face="bold"),  # Adjust the legend title size
      legend.text = element_text(color = "black", size=10),
      legend.position = "top",  # Position the legend on the right side
      axis.text.y = element_text(size = 13),
      axis.text.x = element_text(angle = 45, hjust = 1, size=13) 
    )
#Save the plot as a high-resolution image (adjust the filename and parameters as needed)
ggsave("Incidence rate per zone.png", width = 10, height = 6, dpi = 600)
