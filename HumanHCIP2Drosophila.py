###从FlyBase数据库中找到HCIP对应果蝇同源基因突变后的phenotype

import os
import csv
import numpy as np


### HumanGeneSymbol of HCIP -> Drosophila FbID 
csv.register_dialect('mydialect',delimiter='\t',quoting=csv.QUOTE_ALL)

with open('/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv','r') as csvfile:
    reader = csv.reader(csvfile)
    column = [row[1] for row in reader]
print (type(column))
print (len(column))

#Final_Matrix = np.array()

Human2Drosophila = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/dmel_human_orthologs_disease_fb_2020_02 2.tsv","r")
HCIP_in_Drosophila = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/HCIP_in_Drosophila.csv", "w")
all_lines = csv.reader(Human2Drosophila,'mydialect')
#all_lines = csv.reader(Human2Drosophila)
for line in all_lines:
    #print (line)
    #print (len(line))
    #Row=line.split('\t')
    if len(line) > 1 :
        if line[4] in column:
            
            HCIP_in_Drosophila.writelines(line[0] + '\t' + line[4] + '\n')    
            #HCIP_in_Drosophila.writelines('\n')

HCIP_in_Drosophila.close()
csv.unregister_dialect('mydialect')


### ID conversion: FB -> CG 
with open('/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/HCIP_in_Drosophila.csv','r') as csvfile:
    reader = csv.reader(csvfile)
    column = [row[0] for row in reader]
print (type(column))
print (len(column))

FB_CG_ID = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/fbgn_annotation_ID_fb_2020_02.tsv","r")
FB2CG = open("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/FB2CG.csv", "w")
all_lines = csv.reader(FB_CG_ID)
for line in all_lines:
    #print (line)
    #print (len(line))
    #Row=line.split('\t')
    if len(line) > 1 :
        List_for_secondary_CG = line[3].split(',')
        ret2= list(set(column) & set(List_for_secondary_CG))
        if line[2] in column or len(ret2)>0:
            FB2CG.writelines(line[2] + '\t' + line[3]+ '\t' + line[5]+ '\t' + line[5] + '\n')    
FB2CG.close()

