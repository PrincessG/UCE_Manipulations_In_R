#### Hello! This runs the a series of functions across each file in the directory of your choice and parses each JSON rate file into three output files: .Rates, .switches, .Percents. CAUTION!!!!!!!!!!!!!!!!!This folder cannot include anything but the rate files when you start or else the script will choke!!!!!!!!!!!!!!!!!!! 
#setwd("~/LocationOfNexus.rate_Files")
#Set for length of Input Directory
ListOfJSONFiles<-list.files(full.names=TRUE)

ReadJSONFile<-function(x){
  require(jsonlite)
  FileToProcess<-fromJSON(x)
  return (FileToProcess)
}
InterpretedJSONFiles3<-sapply(ListOfJSONFiles, FUN=ReadJSONFile) #use sapply instead of lapply so that each entry will have the UCE name

################################################  Substitution Matrix (switches) ####################################################
for (i in 1:length(ListOfJSONFiles)) {
  CurrentFileName <-names(InterpretedJSONFiles3)
  EachEntryName<-names(InterpretedJSONFiles3[names(InterpretedJSONFiles3)==CurrentFileName][])
  #CurrentFileName.i<-EachEntryName #Gets mad here
  #File2BCreated<-paste(CurrentFileName.i,".switches.txt", sep="")  
  File2BCreated<-paste(EachEntryName,".switches.txt", sep="")
  file.create(File2BCreated)
}

for (i in 1:length(ListOfJSONFiles)){
  EachEntry<-InterpretedJSONFiles3[names(InterpretedJSONFiles3)==CurrentFileName][]
  #Matrix.i<-EachEntry[[1]]$subs_matrix
  #file.append(file=File2BCreated[i], append=T)
  sink(file=File2BCreated[i])
  rCA<-cat("rCA=",EachEntry[[i]]$subs_matrix$AC,"\n")
  rTG<-cat("rTG=",EachEntry[[i]]$subs_matrix$GT,"\n")
  rAG<-cat("rAG=",EachEntry[[i]]$subs_matrix$AG,"\n")
  rCG<-cat("rCG=",EachEntry[[i]]$subs_matrix$CG,"\n")
  rAT<-cat("rAT=",EachEntry[[i]]$subs_matrix$AT,"\n")
  rCT<-cat("rCT=",EachEntry[[i]]$subs_matrix$CT,"\n")
  sink()
}
######################################################  Percents ###################################################################
for (i in 1:length(ListOfJSONFiles)) {
  CurrentFileName <-names(InterpretedJSONFiles3)
  EachEntryName<-names(InterpretedJSONFiles3[names(InterpretedJSONFiles3)==CurrentFileName][])
  #CurrentFileName.i<-EachEntryName #Gets mad here
  #File2BCreated<-paste(CurrentFileName.i,".switches.txt", sep="")  
  File2BCreated_Percents<-paste(EachEntryName,".Percents.txt", sep="")
  file.create(File2BCreated_Percents)
}

for (i in 1:length(ListOfJSONFiles)){
  EachEntry<-InterpretedJSONFiles3[names(InterpretedJSONFiles3)==CurrentFileName][]
  sink(file=File2BCreated_Percents[i])
  PiSymbolA<-cat("piA=",EachEntry[[i]]$freqs$A,"\n")
  PiSymbolC<-cat("piC=",EachEntry[[i]]$freqs$C,"\n")
  PiSymbolT<-cat("piT=",EachEntry[[i]]$freqs$T,"\n")
  sink()
}
################################################  Rates ################################################################################
for (i in 1:length(ListOfJSONFiles)) {
  CurrentFileName <-names(InterpretedJSONFiles3)
  EachEntryName<-names(InterpretedJSONFiles3[names(InterpretedJSONFiles3)==CurrentFileName][])
  #CurrentFileName.i<-EachEntryName #Gets mad here
  #File2BCreated<-paste(CurrentFileName.i,".switches.txt", sep="")  
  File2BCreated_Rates<-paste(EachEntryName,".Rates.txt", sep="")
  file.create(File2BCreated_Rates)
}

for (i in 1:length(ListOfJSONFiles)){
  EachEntry<-InterpretedJSONFiles3[names(InterpretedJSONFiles3)==CurrentFileName][]
  sink(file=File2BCreated_Rates[i])
  cat(EachEntry[[i]]$rates$rate,sep=",")
  sink()
}

