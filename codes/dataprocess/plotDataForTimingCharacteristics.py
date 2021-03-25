import sys
import pandas as pd

prePnRCSVFile = pd.read_csv(sys.argv[1])
postPnRCSVFile = pd.read_csv(sys.argv[2])

#prePnRCSVFile['startPoint'] = prePnRCSVFile['startPoint'].apply(lambda x: x.replace("_clk","_Q"))
#prePnRCSVFile['startPoint'] = prePnRCSVFile['startPoint'].apply(lambda x: x.replace("_",""))
#prePnRCSVFile['endPoint'] = prePnRCSVFile['endPoint'].apply(lambda x: x.replace("__d","_D"))
#prePnRCSVFile['endPoint'] = prePnRCSVFile['endPoint'].apply(lambda x: x.replace("_",""))


#postPnRCSVFile['startPoint'] = postPnRCSVFile['startPoint'].apply(lambda x: x.replace("_",""))
#postPnRCSVFile['endPoint'] = postPnRCSVFile['endPoint'].apply(lambda x: x.replace("_",""))


prePnRCSVFile = prePnRCSVFile.rename(columns={'pathLength': 'prePnRLen', 'pathIdx': 'pidPrePnR'})
postPnRCSVFile = postPnRCSVFile.rename(columns={'pathLength': 'postPnRLen', 'pathIdx': 'pidPostPnR'})

prePnRCSVFile['pkey'] = prePnRCSVFile['startPoint']+","+prePnRCSVFile['endPoint']
postPnRCSVFile['pkey'] = postPnRCSVFile['startPoint']+","+postPnRCSVFile['endPoint']


commonKeys = set(prePnRCSVFile['pkey']) & set(postPnRCSVFile['pkey'])
print(len(prePnRCSVFile['pkey'].unique()),len(postPnRCSVFile['pkey'].unique()))


prePnRCSVFile_common = prePnRCSVFile[prePnRCSVFile['pkey'].isin(commonKeys)]
postPnRCSVFile_common = postPnRCSVFile[postPnRCSVFile['pkey'].isin(commonKeys)]
prePnRCSVFile_uncommon = prePnRCSVFile[~prePnRCSVFile['pkey'].isin(commonKeys)]



print(prePnRCSVFile)
print(postPnRCSVFile)
print(prePnRCSVFile_common)
print(postPnRCSVFile_common)
print(prePnRCSVFile_uncommon)
final = prePnRCSVFile_common.merge(postPnRCSVFile_common, on="pkey", how = 'inner')
final["techmapPD"] = final["techmapPD"]*1000

'''
for index, row in final.iterrows():
    print(row["genericPD"],row["techmapPD"],row["pkey"])
'''

import seaborn as sns
import matplotlib.pyplot as plt

sns.set_style("whitegrid")
#ax = sns.ecdfplot(data=dfTemp, x=feature, hue="connection")
sns.scatterplot(x="genericPD", y="techmapPD",data=final)
#plt.ylim(0, 1.1)
#    #plt.xlim(0, 2)
plt.title("Timing Variation",fontsize=20,weight='bold')

plt.xlabel("Post generic synthesis timing",fontsize=20,weight='bold')
plt.ylabel("Post techmap timing",fontsize=20,weight='bold')


#plt.xticks(rotation=45,fontsize=20,weight='bold')
#plt.yticks(fontsize=20,weight='bold')
#ax.legend(prop={'size':18}, loc='bottom right')
#plt.legend(fontsize='x-large', title_fontsize='40')
#plt.setp(ax.get_legend().get_texts(), fontsize='20',weight='bold') # for legend text
#plt.setp(ax.get_legend().get_title(), fontsize='20',weight='bold')
plt.savefig('scatter.pdf',fmt='pdf',bbox_inches='tight')
plt.show()
