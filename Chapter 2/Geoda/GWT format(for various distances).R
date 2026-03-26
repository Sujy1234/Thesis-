#working directory
setwd("C:/Users/user/Desktop/Health event data/Morans I")

# Load the distance matrix from the CSV file
distance_matrix <- read.csv("seaway distance matrix.csv", check.names = FALSE)

# Extract row names
row_names <- as.character(distance_matrix[,1])

# Remove the first column (row names)
distance_matrix <- distance_matrix[, -1]

# Function to find neighbors within a specified distance for each farm
find_neighbors <- function(matrix, row_names, max_distance) {
  neighbors_list <- list()
  num_farms <- nrow(matrix)
  for (i in 1:num_farms) {
    # Initialize list to store neighbors for farm i
    neighbors <- c()
    for (j in 1:num_farms) {
      # Check if distance is less than or equal to max_distance
      if (matrix[i, j] <= max_distance && i != j) {
        neighbors <- c(neighbors, paste(row_names[j], matrix[i, j], sep = " "))
      }
    }
    # Store neighbors for farm i
    neighbors_list[[row_names[i]]] <- neighbors
  }
  return(neighbors_list)
}

# Find neighbors within 42,000 meters for each farm
neighbors <- find_neighbors(distance_matrix, row_names, max_distance = 42000)



# Save neighbors to a GWT file
write.table(do.call(rbind, lapply(names(neighbors), function(farm_id) {
  neighbors_list <- neighbors[[farm_id]]
  if (length(neighbors_list) > 0) {
    neighbors_df <- as.data.frame(matrix(unlist(strsplit(neighbors_list, " ")), ncol = 2, byrow = TRUE))
    colnames(neighbors_df) <- c("Neighbor_Farm", "Distance")
    neighbors_df$Farm_ID <- farm_id
    return(neighbors_df[, c("Farm_ID", "Neighbor_Farm", "Distance")])
  }
})), "neighbors42.gwt", quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")
