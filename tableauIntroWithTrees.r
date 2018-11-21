install.packages("tidyr")
install.packages("readxl")

library(tidyr)
library(dplyr)
library(readxl)

# each town has its own folder and a unique xls file that includes desired data
# to pull full list of towns, we create a list of the folders
towns <- list.dirs("C:/Users/nicmo/Dropbox/MunicipalCanopySummaries/", full.names=FALSE, recursive=FALSE)

# some of the folders are for counties, for large regions, or for things that are not places
# *at bottom of this script is a long list of inconsistent namings and how they were modified for the script
# seems like there's a shorter way to do this involving a list
towns <- towns[towns != "BaseImages"]
towns <- towns[towns != "Region"]
towns <- towns[towns != "Cook"]
towns <- towns[towns != "DuPage"]
towns <- towns[towns != "KaneCounty"]
towns <- towns[towns != "Kendall"]
towns <- towns[towns != "Lake"]
towns <- towns[towns != "McHenryCounty"]
towns <- towns[towns != "Will"]
towns <- towns[towns != "ChicagoCommAreas"]
towns <- towns[towns != "IndianaMunis"]



# 1. pull data from each spreadsheet and make a single data set

allTowns <- data.frame()
for (town in towns) {  # pull selected data for each town
  thisTown <- read_xls(paste("C:/Users/nicmo/Dropbox/MunicipalCanopySummaries/",town,"/",town,"Complete.xls", sep=""), sheet = "Area", range = "a2:h15", col_names=FALSE)
  thisTown$town <- town  # create column that records name of town
  thisTown <- thisTown[,c(9,1,2,3,4,5,6,7,8)]  # place town name in first column 
  allTowns <- rbind(allTowns,thisTown)  # add this town's data to full set
}


# 2. clean up full set

allTowns <- allTowns[!is.na(allTowns$X__1), ]  # remove true na rows
allTowns <- allTowns[allTowns$X__1 != "0", ]  # remove rows pulled from wrong table
allTowns$X__1 <- tolower(allTowns$X__1)  # inconsistent case use can lead to weird things later on
allTowns <- allTowns[allTowns$X__1 != "total area", ]  # remove "total area" rows
allTowns <- allTowns[allTowns$X__1 != "total", ]  # remove "total" rows
allTowns <- allTowns[!duplicated(allTowns[1:2]), ]  # remove duplicate rows (not sure of original purpose)
allTowns[is.na(allTowns)] <- 0  # set remaining cells with NA values to 0

allTowns[3:9] <- lapply(allTowns[3:9], as.numeric)  # convert values to numerical data
allTowns[3:9] <- lapply(allTowns[3:9], round)  # round to integer to eliminate floating point errors


# 3. collapse areas for potential canopy and unsuitable space into two columns

allTowns$landUse <- allTowns$X__1

allTowns$canopy <- allTowns$X__2
allTowns$plantable <- allTowns$X__3 + allTowns$X__4 + allTowns$X__8
allTowns$unsuitable <- allTowns$X__5 + allTowns$X__6 + allTowns$X__7


# 4. find town / land use combinations which do not exist, and add these in as all-zero rows

# count how many rows include each combination of town name and land use type
# this method is also useful for identifying data quality issues
n_occur <- data.frame(table(allTowns$town,allTowns$X__1))
n_occur <- n_occur[n_occur$Freq == 0, ]
n_occur <- n_occur[n_occur$Var2 != "total", ]
n_occur$town <- n_occur$Var1
n_occur$landUse <- n_occur$Var2
n_occur$canopy <- 0
n_occur$plantable <- 0
n_occur$unsuitable <- 0

nullset <- n_occur[,c(4:8)]


# 5. add in zero rows (where certain land uses don't exist within certain towns)

fullSet <- allTowns[,c(1,10:13)]
fullSet <- rbind(fullSet,nullset)
fullSet <- fullSet[order(fullSet$town, fullSet$landUse),]

# convert square feet to acres
# round values to nearest hundreth of an acre
sqft2acre <- (640 / 5280 / 5280)

fullSet$canopy <- round((fullSet$canopy * sqft2acre), digits=2)
fullSet$plantable <- round((fullSet$plantable * sqft2acre), digits=2)
fullSet$unsuitable <- round((fullSet$unsuitable * sqft2acre), digits=2)


# 6. get data into long-form

canopyOnly <- fullSet[,c(1:3)]  # subset data to include only 'town', 'landUse', and the specific canopy status acreage
plantableOnly <- fullSet[,c(1:2,4)]
unsuitableOnly <- fullSet[,c(1:2,5)]

canopyOnly$status <- "canopy"  # add category variable to clarify canopy status
plantableOnly$status <- "plantable"
unsuitableOnly$status <- "unsuitable"

names(canopyOnly)[names(canopyOnly) == "canopy"] <- "acres"  # rename the quanity variable in each subset to "acres"
names(plantableOnly)[names(plantableOnly) == "plantable"] <- "acres"
names(unsuitableOnly)[names(unsuitableOnly) == "unsuitable"] <- "acres"

final <- rbind(canopyOnly,plantableOnly,unsuitableOnly)  # bring three subsets back together
final <- final[,c(1,2,4,3)]  # reorder columns to acreage quantity is last


# 7. output final csv file

write.csv(final, file = "potentialCanopy.csv",row.names=FALSE)


## *name issues referenced above

# 'BaseImages' is not a town
# 'Region' is not a town
# 'NA_character_' is not a town

# 'Cook' is a county
# 'DuPage' is a county
# Kane County as 'Kane' in file, also is a county
# 'Kendall' is a county
# 'Lake' is a county
# 'McHenry' is a county (not to be confused with town called McHenry)
# 'Will' is a county

# Elmhurst file missing in folder ... this xls was estimated using data from chart.bmp in Elmhurst file
# Westmont file missing in folder ... this xls was estimated using data from chart.bmp in Westmont file

# Bolingbrook as 'Bolingbrooke' in file ... name corrected
# Crystal Lawns as 'CrystalLawn' in file ... name corrected
# Elk Grove Village as 'ElkGroveVillag' in file ... name corrected
# Frankfort Square as 'FrankfortSquaret' in file ... name corrected
# Godley as 'GodleyPark' in file ... name corrected
# Holiday Hills as 'HollidayHills' in file ... name corrected
# McHenry (town) as 'McHenryTown' in folder and file ... town name file and folder changed to 'McHenry', with county name changed to 'McHenryCounty'
# Park Ridge as just 'ParkRidge' rather than 'ParkRidgeComplete' in file ... file name changed to conform to convention

# Chicago data one layer down within 'CityofChicago' folder ... this has been brought up one folder level for inclusion
# 'ChicagoCommAreas' not a town, but broken into parts of City of Chicago
# 'IndianaMunis' folder includes multiple community files

# Diamond under 'Diamond_onlyPortionInWill' folder ... folder name changed to 'Diamond'
# Pistakee Heights under 'PistakeeHighlands' folder (Highlands is a subdivision name) ... folder name changed to 'PistakeeHeights'
# 'StCharles' under 'St.Charles' folder ... folder name changed to 'StCharles'