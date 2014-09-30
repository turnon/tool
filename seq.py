import sys

argvs=len(sys.argv)

if argvs > 2 :
	start=int(sys.argv[1])
	end=int(sys.argv[2])+1
elif argvs == 2 :
	start=1
	end=int(sys.argv[1])+1
else :
	print('wrong arg')
	exit()

for i in range(start,end) :
 print(i)
