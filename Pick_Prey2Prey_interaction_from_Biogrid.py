###从Biogrid中选出Prey-Prey之间的互作

import os
import csv
import numpy as np

with open('/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv','r') as csvfile:
    reader = csv.reader(csvfile)
    column = [row[1] for row in reader]
print (type(column))
print (len(column))
print (column[2])

Biogrid = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Biogrid/Biogrid_human_1.csv")
Prey_Prey_interaction=open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey_Prey_interaction.csv", "w")
all_lines = Biogrid.readlines()
for line in all_lines:
    Row=line.split(',')
    #print (Row[0])
    #print (Row[3])
    if Row[2] in column and Row[3] in column and Row[2] != Row[3]:
        Prey_Prey_interaction.writelines(line)
    #Row=line.split(',')
    #if Row[0] in column:
Prey_Prey_interaction.close()

