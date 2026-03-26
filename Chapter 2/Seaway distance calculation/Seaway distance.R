# Load libraries
library(raster)
library(gdistance)
library(sf)

# 1. Set working directory
setwd("C:/Users/user/Desktop/Health event data/Chapter 2/Seaway distance calculation")

# 2. Load sites and water contour
sites <- st_read("Healtheventdatapoints.shp")
sites <- st_transform(sites, st_crs(3156))

poly <- st_read("Waterway-BC_UTM9N_corrections.shp")
poly <- st_transform(poly, st_crs(3156))

# 3. Convert polygon extent to raster extent
xrange <- extent(poly)[2] - extent(poly)[1]
yrange <- extent(poly)[4] - extent(poly)[3]

# 4. Grid size: 100 by 100 m
gridsize <- 100
ncols <- ceiling(xrange / gridsize)
nrows <- ceiling(yrange / gridsize)

# 5. Create raster with desired grid size
r <- raster(ncol = ncols, nrow = nrows, crs = CRS("+init=EPSG:3156"))

# 6. Set raster extent to match polygon extent
extent(r) <- extent(poly)

# 7. Rasterize polygon onto raster
rp <- rasterize(poly, r)

# 8. Save raster file
output_file <- "100by100raster(BC_waterway).tif"
writeRaster(rp, filename = output_file, format = "GTiff", overwrite = TRUE)

# 9. Check if any sites are outside the raster
site_check <- extract(rp, sites)
sites_df <- as.data.frame(sites$Site_id[is.na(site_check)])  # IDs of sites outside raster

# 10. Make transition raster
tr <- transition(rp, transitionFunction = mean, directions = 8, symm = TRUE)

# 11. Correct inter-cell conductance values
trC <- geoCorrection(tr, type = "c", multpl = FALSE)

# 12. Create coordinate matrix with X and Y columns
sites_coords <- as.data.frame(sites)
site.mat <- data.matrix(sites_coords[, c("coords.x1", "coords.x2")])

# 13. Calculate sea-way distances
distsites2sites <- costDistance(trC, site.mat, site.mat)

# 14. Convert distance matrix to data frame
distances <- as.data.frame(distsites2sites)
distances$Site_id <- sites_coords$Site_id

# 15. Export distance matrix
write.csv(distances, file = "distsites2sites_dataframe.csv", row.names = FALSE)

# *************************** STOP ************************************

# 16. Import the same file
distsites2sites <- read.csv("distsites2sites_dataframe.csv")

# 17. Convert matrix to data frame
test <- as.data.frame(distsites2sites)
test$Site_id <- sites$Site_id

# 18. Example for first site
test.v1 <- as.data.frame(test[c("V1", "Site_id")])
test.v1$V1 <- test.v1$V1 * 100
test_sorted <- test.v1[order(test.v1$V1), ]
v1 <- test_sorted$Site_id

# 19. Create sorted neighbour lists for all sites
site_ids <- vector("list", length(sites$Site_id))
site_ids[[1]] <- v1

for (i in 2:length(sites$Site_id)) {
  temp_df <- as.data.frame(test[c(paste0("V", i), "Site_id")])
  names(temp_df)[1] <- "distance"
  temp_df$distance <- temp_df$distance * 100
  temp_sorted <- temp_df[order(temp_df$distance), ]
  site_ids[[i]] <- temp_sorted$Site_id
}

# 20. Combine into neighbour data frame
neighbour <- as.data.frame(do.call(rbind, site_ids))

# 21. Export spatial neighbours
write.table(
  neighbour,
  file = "nearest_neighbour.nei",
  sep = "\t",
  row.names = FALSE,
  col.names = FALSE,
  quote = FALSE
)