import os

var1 = os.getcwd()
os.chdir(os.path.dirname(os.path.abspath(__file__)))

os.system('git pull')

import subprocess

filename='README.md'
content = open(filename, 'r', encoding='UTF-8').read()
#print(content)

sharp2 = content.split('##')
#print(sharp2)
sharp=[]
for i in sharp2:
    i=i.strip('\n')
    if i != '':
        sharp.append(i)
sharp.sort()
#print(sharp)
data = "##"+"\n\n\n##".join(sharp)
#print(data)

open(filename, 'w', encoding='UTF-8').write(data)

# os.system("pandoc --toc -s %s -o README.md" %(filename))
os.system("git add .")
os.system("git commit -m 'AutoCommit'")
os.system("git push")

os.chdir(var1)
