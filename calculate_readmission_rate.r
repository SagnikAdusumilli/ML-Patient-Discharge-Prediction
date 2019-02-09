library(data.table)

# Choose core.csv, it has 1000 rows, only used a proof of concept
dt <- fread(file.choose())



#verify the cols have the right data for the operation
dt$LOS
dt$NRD_VisitLink
dt$NRD_DaysToEvent


# sort based on visitLink so all the NRD_VisitLink can be there subsequently
setkey(dt, NRD_VisitLink)
# subtract the NRD_DaysToEvent for the same NRD_VisitLink, since they are sorted, they should apprear subsequently
dt[, diff := NRD_DaysToEvent - shift(NRD_DaysToEvent, fill = first(NRD_DaysToEvent)), by = NRD_VisitLink]
dt$diff

# create column for target variable
dt$lessThan30 <- 0

#subtract los from difference, only for diff with non 0 (if LOS was 30 we would get wrong data)
for(i in 1:nrow(dt)) {
  if(abs(dt[i]$diff) > 0) {
    dt[i]$diff <- abs(dt[i]$diff) - dt[i]$LOS
    # creating an possible error in the collection here. 
    # If a patient is readmmited the same day the daydiff is 0
    # we can't detect that because it will be 0 for patients who are never seen again too
    # But I'm assuming this case is very rare
    # Perhaps we can think in the future we can think of a tweak that sets the default value to -1 or something
    if(dt[i]$diff > 0 && dt[i]$diff <= 30) {
      dt[i]$lessThan30 <- 1
    } else {
      dt[i]$lessThan30 <- 0
    }
  }
}
# view the new differece
# I'm going to assume that all the entries with diff as negative is is an error in data entry because you can only get that your LOS was longer than readmission
dt$diff
# Seems like its very are that patients come back within 30 days for the first 1000 rows at least
dt$lessThan30

