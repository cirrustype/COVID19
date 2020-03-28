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


#estimating secondary attack rate 
#https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(20)30462-1/fulltext


#number of uninfected people at gathering:
ngath <- c(8,13,1,8,14,17,47,11,18)

#number who were infected at gathering 
igath <- c(8,4,1,7,3,2,10,5,8)

cor(igath, ngath) #0,585 

mean(igath) #5.33


# the ODE...

#setting up the time vector
time <- seq(from=0, to=15, by = 0.01)

#setting up the parameters 
parameters <- c(transr = 5.33, recovr = .5, hospr = .13, ventr = .065) 

#initial conditions
state <- c(S = .99, I = .01, R = 0, H = 0, V = 0)

SIRcorona <- function(t, state, parameters){
  with(as.list(c(state, parameters)), {
    dS = -transr*S*I
    dI =  transr*S*I - recovr*I
    dR =  recovr*I
    dH =  hospr*I - recovr*H
    dV =  ventr*I - recovr*V
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








