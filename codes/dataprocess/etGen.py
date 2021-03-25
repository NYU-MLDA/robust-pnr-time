import sys
import argparse
import re
import fileinput
from gateElement import gateBlock,pathSegment

INFO = "Extract timing information from synthesized netlist (pre PnR)"
VERSION = 0.1
timing_report = ""
output_csv = ""
pathInformation = []
csvDelimiter = ","
target_cycle_time = 0.0


def showVersion():
    print(INFO)
    print(VERSION)
    sys.exit()

def parseArguments():
    global timing_report,output_csv,target_cycle_time
    argparser = argparse.ArgumentParser(description="Feature Extraction (Pre PnR synthesis)")
    argparser.add_argument("-V", "--version", action="store_true", dest="showversion", default=False,
                           help="Show the version")
    argparser.add_argument("-t", "--timing_report", action="store", dest="timing_report", default="",required=True,
                           help="Specify the name of the netlist file to process")
    argparser.add_argument("-d", "--target_cycle_time", action="store", dest="target_cycle_time", default="",required=True,
                           help="Specify the target cycle time")
    argparser.add_argument("-o", "--output_file", action="store", dest="output_file", default="prePnR.csv",
                           help="Specify the name of the output csv file")

    # read arguments/options from the cmd line
    args = argparser.parse_args()

    if args.showversion:
        showVersion()

    if (args.timing_report == None) or (args.output_file == None) or (args.target_cycle_time == None):
        print("Provide proper arguments")
        exit()
    else:
        timing_report = args.timing_report
        output_csv = args.output_file
        target_cycle_time = args.target_cycle_time

'''
def processStartAndEndpoint(startPoint,endPoint):
    #Trim starting '_'
    sPoint = startPoint[1:]
    ePoint = endPoint[1:]
    if(ePoint.endswith('d')):
        ePoint = ePoint[:-1]+'D'
    elif(endPoint.endswith('sena')):
        ePoint = ePoint[:-4] + 'SE'
    return sPoint,ePoint
'''

def processStartAndEndpoint(startPoint,endPoint):
    sPoint = startPoint.strip()
    sPoint = sPoint.replace("/clk","/CK")
    sPoint = sPoint.replace("/","_")
    ePoint = endPoint.strip()
    ePoint = ePoint.replace("/d", "/D")
    ePoint = ePoint.replace("/", "_")
    return sPoint, ePoint


def parseFileLines(filelineContents):
    idx = 0
    numLines = len(filelineContents)
    while(idx < numLines):
        line = filelineContents[idx]
        if(line.__contains__("Startpoint")):
            tempPS = pathSegment()
            line = line.strip("\r\n").split(")")
            startPoint = line[1]#re.sub("[^A-Za-z0-9_]", "_",line[1])
        elif(line.__contains__("Endpoint")):
            line = line.strip("\r\n").split(")")
            endPoint = line[1]#re.sub("[^A-Za-z0-9_]", "_",line[1])
            #print(line)
        elif(line.__contains__("Load") and line.__contains__("Delay") and line.__contains__("Fanout")):
            idx+=4 # Length 3 buffer, no good inputs.
            firstLine = filelineContents[idx]
            idx+=1
            secondLine = filelineContents[idx]
            pathDelay = 0
            sPoint,ePoint = processStartAndEndpoint(startPoint,endPoint)
            tempPS.setStartAndEndpoint(sPoint,ePoint)
            while(not secondLine.__contains__("#--------------")):
                #### Logic for new path
                ### paramList[0] contains name, Param[1] contains gate type, param[2] contains Fanout, param[3] - Trans
                ### Param[4] - Incr, Param[4] -  Path
                #parseList = re.findall(r'[A-Za-z0-9/._\[(){}\]]+',line)
                parseList = firstLine.strip("\r\n").split()
                gateName = parseList[0]
                gateType = parseList[4]
                fanout = parseList[5]
                gateLoad = parseList[6]
                gateDelay = parseList[8]
                #print(parseList)
                #print(gateLoad)

                # Creating Gate object
                gateObj = gateBlock()
                gateObj.setGateParams(gateName, gateType, float(gateDelay),gateLoad)
                gateObj.setFanoutChar(gateName, fanout)
                gateObj.setTargetCycleTime(target_cycle_time)
                pathDelay += float(gateDelay)
                tempPS.addGateObj(gateObj)
                idx+=1
                firstLine = secondLine
                secondLine = filelineContents[idx]
            tempPS.setPathDelay(pathDelay)
            pathInformation.append(tempPS)
        idx+=1

def reportInfo():
    idx=1
    writeFile = open(output_csv,"w")
    writeInputFeatureFile = open("inputFeatureFile.csv","w")
    writeFile.write("pathIdx,startPoint,endPoint,genericPD,pathLength")
    for path in pathInformation:

        #print("\n\nPath info:"+str(idx)+"\n")
        #print(path.getStartPoint())
        #print(path.getEndPoint())
        #print(path.getPathDelay())
        #print(path.getPathLength())
        writeFile.write("\n"+str(idx)+csvDelimiter)
        writeFile.write(path.getStartPoint()+csvDelimiter)
        writeFile.write(path.getEndPoint()+csvDelimiter)
        writeFile.write(str(path.getPathDelay())+csvDelimiter)
        writeFile.write(str(path.getPathLength()))
        writeInputFeatureFile.write(str(idx))
        pathInfo = path.getGateList()
        for gate in pathInfo:
            designTCTime,gateID,gateLoad = gate.getFeature()
            writeInputFeatureFile.write(csvDelimiter+str(designTCTime)+csvDelimiter+str(gateID)+csvDelimiter+str(gateLoad))
        writeInputFeatureFile.write("\n")
        idx+=1
    writeFile.close()


def fileContent():
    f = open(timing_report,'r+')
    fileLines = f.readlines()
    f.close()
    parseFileLines(fileLines)

def main():
    parseArguments()
    fileContent()
    reportInfo()

if __name__ == '__main__':
    main()