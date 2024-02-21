#从Development Disorder Genotype - Phenotype Database (DDG2P)数据库中筛选HCIP

import os
import csv
import numpy as np

with open('/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv','r') as csvfile:
    reader = csv.reader(csvfile)
    column = [row[1] for row in reader]
print (type(column))
print (len(column))

file_DDG2P = open("/Users/tangsuiyue/Documents/Documents/Project/Notch/Decipher/DDG2P_14_4_2020.csv")
file_HCIP_in_DDG2P=open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP_in_DDG2P.csv", "w")
all_lines = file_DDG2P.readlines()
for line in all_lines:
    Row=line.split(',')
    if Row[0] in column:
        file_HCIP_in_DDG2P.writelines(line)
file_DDG2P.close()