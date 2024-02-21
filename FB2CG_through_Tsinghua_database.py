### FB2CG through Tsinghua database

import os
import csv
import numpy as np

with open('/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/HCIP_in_Drosophila.csv','r') as csvfile:
    reader = csv.reader(csvfile)
    column = [row[0] for row in reader]
print (type(column))
print (len(column))
print (column[0])
print (column[1])

FB2CG_Tsinghua = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Tsinghua/1-Stock information-RNAi.csv","r")
CG_of_HCIP = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/CG_of_HCIP.csv", "w")
all_lines = csv.reader(FB2CG_Tsinghua)
for line in all_lines:
    if len(line) > 0:
        #print (line[6])
        if line[6] in column :
            CG_of_HCIP.writelines(line[4] + '\t' + line[6])
            #print(len(line))
            CG_of_HCIP.writelines('\n')
CG_of_HCIP.close()