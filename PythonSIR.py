#creating SIR model for Coronavirus

#libraries
import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt


#estimating Secondary Rate of Attack 




#main components 

#Main components 
#S = susceptible. This represents the individuals who 
##are still capable of getting sick. 

#I = infected. Individuals who are actively sick 

#R = Recovered. Individuals who have either recovered and are now 
##immune or have died. Anyone who is no longer capable of 
##spreading the virus.

#  H = hospitalized and V = on ventilator

# transr = transmission rate, the rate of spread
# recovr = recovery rate
 

####The ODE####

#time vector:
#to create sequence in python...
#time <- seq(from=0, to=15, by = 0.01)
###time = [n + 0.01 for n in range(0,15)] no
### use numpy np.arange function, or manual for loop???
#time = [np.arange(0,15, 0.01).tolist()] #this works 
#this isnt one-dimensional???
#print(time)
#linspace???


#parameters:
#parameters <- c(transr = 5.33, recovr = .5, hospr = .13, ventr = .065)
#creating a vector of parameters???

#transr is transmission rate, or Secondary Rate of Attack
transr = 5.33

#recovr is recovery rate per time step
recovr = 1




#initial conditions:
#state <- c(S = .99, I = .01, R = 0, H = 0, V = 0)
#create vector of initial conditions???

S0 = .99 #initial susceptible %
I0 = .01 #initial infection %
R0 = 0   #initial recovered %

#creating sustem of ODEs called model

#def model(S,I,t):
    #didt = transr*S*I - recovr*I
    #drdt = recovr*I
    #return [dsdt, didt, drdt]


#this didnt work as a system trying individual ODEs

def Smodel(y, t, transr, recovr):
    S, I, R = y
    dydt = [-transr*S*I, transr*S*I - recovr*I, recovr*I]
    return dydt

#!!! this cannot work because the system of ODEs are irreparably linked 
    #S, I, and R are not indepentent of eachother they must be a system 
#initial conditions
Sy0 = [S0, I0, R0]

#time
t = np.linspace(0,15, num = 1500)

#solving ODE
curve = odeint(Smodel,Sy0,t, args = (transr, recovr))

print(curve) #this goes negative 

#plotting to see if it matches 
plt.plot(t, curve)
plt.xlabel('Days')
plt.ylabel('Population')
plt.show()

#SIRmodel = integrate.odeint(model, y0, t)



#integrate.odeint()






