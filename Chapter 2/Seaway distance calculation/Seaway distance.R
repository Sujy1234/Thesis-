#load the library
library(raster)
library(gdistance)
library(sf)
#1 Set working directory
setwd("C:/Users/user/Documents/MY PROJECT/Mortality casecontrol/Sea-way distance calculation")

#2 Load sites and raster file
sites<-st_read("Healtheventdatapoints.shp")
sites<- st_transform(sites,st_crs(3156))
rp<-raster("100by100raster(BC_waterway).tif")
plot(rp)


#3 Check if any sites are outside the raster(0 observations in our case)
extract(rp,sites)
sites_df<-as.data.frame(sites$Site_id) # Look at the dataframe of sites
sites_df<-as.data.frame(sites$Site_id[is.na(extract(rp,sites))]) # Get the IDs for those sites outside

#4 Make transition raster(I calculated with 4 directions)
tr<-transition(rp,transitionFunction=mean,directions=8,symm=TRUE)

#5 Correcting inter-cell conductance values
trC<-geoCorrection(tr,type="c",multpl=FALSE)


#6 Create matrices; they need to be two columns: X and Y
sites_coords<-as.data.frame(sites)
site.mat=data.matrix(sites_coords[,c("coords.x1","coords.x2")])

#7 Distance
distsites2sites<-costDistance(trC,site.mat,site.mat)

#8 Convert matrix to a dataframe
distances<-as.data.frame(distsites2sites)
distances$"Site_id"<-sites_coords$Site_id

#9 Export
write.csv(distances,file="distsites2sites_dataframe.csv")
#***************************STOP************************************

#IMPORT THE SAME FILE
distsites2sites<-read.csv("distsites2sites_dataframe.csv")

#Convert matrix to a dataframe
test<-as.data.frame(distsites2sites)
test$Site_id<-sites$Site_id

#Run some examples
test.v1<-as.data.frame(test[c("V1","Site_id")])
test.v1$V1<-test.v1$V1*100
attach(test.v1)
test_sorted<-test.v1[order(V1),]
v1<-test_sorted$Site_id

#Runs a loop for the length of the number of sieps in the dataset...
for (i in  1:length(sites$Site_id)){
  eval(parse(text=paste("test.v",i,"<- as.data.frame(test[c(\"V",i,"\",\"Site_id\")])", sep="")))
  eval(parse(text=paste("attach(test.v",i,")", sep="")))
  eval(parse(text=paste("test_sorted<-test.v",i,"[order(V",i,"),]", sep="")))
  eval(parse(text=paste("v",i,"<-test_sorted$Site_id", sep="")))
}

neighbour<- as.data.frame(rbind(v1))
for(i in 2:length(sites$Site_id)){
  eval(parse(text=paste("neighbour[\"v",i,"\",]<-rbind(v",i,")", sep="")))
}

#Spatial neighbours
write.table(neighbour,file="nearest_neighbour.nei",sep="\t", row.names=FALSE, col.names=FALSE)
