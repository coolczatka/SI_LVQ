import neurolab as n
import numpy as np
import csv
#wczytanie danych
we = list()
wy = list()
data = csv.reader(open('diagnosis.txt'), delimiter='\t')
for row in data:
	row = [float(x) for x in row]
	we.append(row[0:6])
	if row[6] and row[7]:
		wy.append([1,0,0,0])
	elif row[6] and not(row[7]):
		wy.append([0,1,0,0])
	elif not(row[6]) and row[7]:
		wy.append([0,0,1,0])
	else:
		wy.append([0,0,0,1])
#normalizacja
maxtemp = we[119][0]
mintemp = we[0][0]
for i in we:
	i[0] = 2*((i[0]-mintemp)/(maxtemp-mintemp))-1
print(we)
print(wy)
minmax = n.tool.minmax(we)

#siec
#wektor z współczynnikami uczenia
Lr=[]
for i in range(4):
	Lr.append(10**(-4+i))
for i in range(1,9):
	Lr.append(Lr[3]+i/10)
for i in range(1,10):
	Lr.append(Lr[11]+i/100)	
#wektor z ilościami neuronow w warstwie pierwszej
wynik=list()
S1 = range(5,120,10)
for lrr in Lr:
	for s in S1:
		print("\nlr = ",lrr,"\nS1 = ",s)
		net = n.net.newlvq(minmax,s,[.25, .25, .25, .25])
		#sprawnosc=(1-sum(abs(wy-sym)>=0.5)/we.shape[0])*100
		#wynik.append([lrr,s,		
		error = net.train(we, wy, epochs=10, goal=-1, lr=lrr, show=1)
		spr = round((1-error[9])*100,1)
		print(spr,"%\n")
#print(wy)
