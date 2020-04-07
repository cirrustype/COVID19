#creating SIR model for Corona 

#libraries 
install.packages("deSolve")
library(deSolve)
install.packages("ggplot2")
library(ggplot2)
install.packages("reshape2")
library(reshape2)


#http://rstudio-pubs-static.s3.amazonaws.com/32888_197d1a1896534397b67fb04e0d4899ae.html

#Main components 
#S = susceptible. This represents the individuals who 
##are still capable of getting sick. 

#I = infected. Individuals who are activley sick 

#R = Recoverd. Idividuals who have either recovered and are now 
##immune or have died. Anyone who is no longer capable of 
##spreading the virus.

#  H = hospitalized and V = on ventalator

# transr = transmisson rate, the rate of spread
# recovr = recovery rate


###############Estimating secondary attack rate################################################
#https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(20)30462-1/fulltext


#number of uninfected people at gathering:
ngath <- c(8,13,1,8,14,17,47,11,18)

#number who were infected at gathering 
igath <- c(8,4,1,7,3,2,10,5,8)

cor(igath, ngath) #0.585 

mean(igath) #5.33

#the secondary rate of attack is dtermined by (# new infected)/(total # exposed at contact)
# I am assumeing everyone had the opportunity for exposer at these gatherings 
tgath <- igath/ngath
tgath
mean(tgath) # 0.514

#given that these gatherings have SARs that range from 0.21 to 1.0 its likley that the ammount of 
#actuall contact at the gatherings varies a lot so a much larger dataset is needed. 

#the sample Secondary Attack Rate from this small dataset is 0.514
#need to add more data form Italy or the US if possible

################################################################################################




##################Estimating Transmission rate##################################################
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5572698/






##################Estimating Recovery Rate#####################################################





##################Estimating R0################################################################
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3935673/



#################Case Fatality Rate############################################################




###################The SIR model##############################################################

#setting up the time vector
time <- seq(from=0, to=15, by = 0.01)

#setting up the parameters 
parameters <- c(transr = 5.33, recovr = .5, hospr = .13, ventr = .065) 

#initial conditions
state <- c(S = .99, I = .01, R = 0, H = 0, V = 0)

SIRcorona <- function(t, state, parameters){
  with(as.list(c(state, parameters)), {
    dS = -transr*S*I #change in suceptibility 
    dI =  transr*S*I - recovr*I #change in number of infected 
    dR =  recovr*I #change in number of recovered 
    dH =  hospr*I - recovr*H #change in the number of hospitalizations 
    dV =  ventr*I - recovr*V #change in the number of patients on ventalators
    return(list(c(dS, dI, dR, dH, dV)))
  })
}


#integrating to solve the ODE using the deSolve package
output <- ode(y = state, times = time, func = SIRcorona, parms = parameters)
## plotting the end times 
output.df = as.data.frame(output) #must be data frame for ggplot
output.m = melt(output.df, id.vars='time') #melt?

p <- ggplot(out.m, aes(time, value, color = variable)) + geom_point()
print(p)


#finding the % of population will eventually get sick, and the % who will 
## be hospitalized, be ventalated, and/or die from the virus. 

##the area under the curves will bew the total number... need to modify ODE function the 
##output a vector to match to a function for numerical answer. will compare to actual 
## solved ODE?





