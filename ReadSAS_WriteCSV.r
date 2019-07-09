#July 9, 2019
#The following script loops through a directory, identifies all sas7bdat files (i.e., a database storage file
#created by SAS), and saves their associated file paths. Then, each SAS file is read into R, saved as an dataframe, and
#finally exported to a .csv file. Note that the directory for saving csv files (outdir) may differ vs the SAS files (indir).

#Load the library haven. The read_sas function is included in this package and allows reading and writing of sas7bdat files
library(haven)

#Example base directory
basedir <- "C:/EnterFolderName"

#Example subdirectory (under basedir) where the sas7bdat files are stored.
indir <- file.path(basedir, "Folder2/SASFolder")

#Example subdirectory (under basedir) where the exported csv files should be saved.
outdir <- file.path(basedir, "Folder2/CSVFolder")

#Full path names of all sas7bdat files saved in indir (e.g., C:/EnterFolderName/ExampleFile.sas7bdat)
SAS_files_fullPath <- list.files(path=indir, pattern="*.sas7bdat", full.names=TRUE, recursive=FALSE)

#File names only of sas7bdat files saved in indir (e.g., ExampleFile.sas7bdat).
SAS_files_namesOnly <- list.files(path=indir, pattern="*.sas7bdat", full.names=FALSE, recursive=FALSE)

#Names of SAS files excluding the ".sas7bdat" extension. These names will be used for naming the associated, exported
#.csv files (e.g., ExampleFile).
SAS_files_namesOnly <- sapply(strsplit(SAS_files_namesOnly,split=".",fixed=TRUE), function (x) (x[1]))

for (i in 1:length(SAS_files_fullPath)) {
  #Read in sas7bdat files to R and save in the dataframe indat.
  indat <- read_sas(SAS_files_fullPath[i])
  #Write to a .csv file and save to the outdir folder. This completes the process of converting a sas7bdat to a csv 
  #by using R as an intermediary.
  outdat <- write.csv(indat, file=file.path(outdir,paste0(SAS_file_namesOnly[i],".csv")), row.names = FALSE)
}