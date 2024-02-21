### FB2CG through Tsinghua database

import os
import csv
import numpy as np

with open('/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/CG_of_HCIP.csv','r') as csvfile:
    reader = csv.reader(csvfile)
    column = [row[0] for row in reader]
print (type(column))
print (len(column))
print (column[0])
print (column[1])


PaperData = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Genome-wide analysis of Notch signalling in Drosophila by transgenic RNAi/NIHMS33166-supplement-supplementary_table-2.csv","r")
HCIP_in_Paper = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/HCIP_in_Paper.csv", "w")
all_lines = csv.reader(PaperData)
for line in all_lines:
    if len(line) > 0:
        print (line[3])
        if line[3] in column : 
            for ele in line:
                HCIP_in_Paper.writelines(ele + "\t")
            HCIP_in_Paper.writelines('\n')
HCIP_in_Paper.close()