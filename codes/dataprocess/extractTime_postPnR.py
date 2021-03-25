import sys
import argparse
import re
import fileinput
from gateElement import gateBlock,pathSegment

INFO = "Extract timing information from synthesized netlist (post PnR)"
VERSION = 0.1
timing_report = ""
output_csv = ""
pathInformation = []
csvDelimiter = ","


def showVersion():
    print(INFO)
    print(VERSION)
    sys.exit()

def parseArguments():
    global timing_report,output_csv
    argparser = argparse.ArgumentParser(description="Feature Extraction (Pre PnR synthesis)")
    argparser.add_argument("-V", "--version", action="store_true", dest="showversion", default=False,
                           help="Show the version")
    argparser.add_argument("-t", "--timing_report", action="store", dest="timing_report", default="",
                           help="Specify the name of the netlist file to process")
    argparser.add_argument("-o", "--output_file", action="store", dest="output_file", default="postPnR.csv",
                           help="Specify the name of the output csv file")

    # read arguments/options from the cmd line
    args = argparser.parse_args()

    if args.showversion:
        showVersion()

    if (args.timing_report == None) or (args.output_file == None):
        print("Provide proper arguments")
        exit()
    else:
        timing_report = args.timing_report
        output_csv = args.output_file

'''
def processStartAndEndpoint(startPoint,endPoint):
    sPoint = startPoint
    if(startPoint.endswith('Q')):
        sPoint = startPoint[:-1]+'clk'
    elif(startPoint.endswith('QN')):
        sPoint = startPoint[:-2]+'clk'
    return sPoint,endPoint
'''

def processStartAndEndpoint(startPoint,endPoint):
    sPoint = startPoint.split('/')[0].strip()
    ePoint = endPoint.split('/')[0].strip()
    return sPoint, ePoint


def parseFileLines(filelineContents):
    idx = 0
    numLines = len(filelineContents)
    while(idx < numLines):
        line = filelineContents[idx]
        #if(line.__contains__("Beginpoint:")):
        if (line.__contains__("Startpoint:")):
            tempPS = pathSegment()
            line = line.strip("\r\n").split()
            #print(line)
            startPoint = line[2]
            #startPoint = re.sub("[^A-Za-z0-9_]", "_",line[1])
        elif(line.__contains__("Endpoint:")):
            line = line.strip("\r\n").split()
            #print(line)
            endPoint = line[2]
            #endPoint = re.sub("[^A-Za-z0-9_]", "_",line[1])
        #elif(line.__contains__("= Beginpoint Arrival Time")):
        elif(line.__contains__("Timing Point")):
            #idx+=6 # Length 3 buffer, no good inputs.
            idx += 4  # Length 3 buffer, no good inputs.
            firstLine = filelineContents[idx]
            idx+=1
            secondLine = filelineContents[idx]
            pathDelay = 0
            sPoint, ePoint = processStartAndEndpoint(startPoint, endPoint)
            tempPS.setStartAndEndpoint(sPoint, ePoint)
            #while(not secondLine.__contains__("+--------------")):
            while(not secondLine.__contains__("#--------------")):
                #parseList = "".join(firstLine.strip("\r\n").split()).split("|")
                parseList = firstLine.strip("\r\n").split()
                #print(parseList)

                #gateName = parseList[1]
                #gateType = parseList[3]
                ##fanout = parseList[5]
                #gateLoad = 0
                #gateDelay = parseList[4]
                #print(gateLoad)
                gateName = parseList[0]
                gateType = parseList[4]
                gateLoad = 0
                gateDelay = parseList[-2]
                # Creating Gate object
                #print(parseList,parseList[2])
                #Logic to skip entries extended to two lines
                #if((parseList[2].__contains__('v') or parseList[2].__contains__('^'))):
                #    gateObj = gateBlock()
                #    gateObj.setGateParams(gateName, gateType, float(gateDelay),gateLoad)
                #    #gateObj.setFanoutChar(gateName, fanout)
                #    pathDelay += float(gateDelay)
                #    tempPS.addGateObj(gateObj)
                gateObj = gateBlock()
                gateObj.setGateParams(gateName, gateType, float(gateDelay),gateLoad)
                #gateObj.setFanoutChar(gateName, fanout)
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
    writeFile.write("pathIdx,startPoint,endPoint,techmapPD,pathLength")
    for path in pathInformation:
        writeFile.write("\n"+str(idx)+csvDelimiter)
        writeFile.write(path.getStartPoint()+csvDelimiter)
        writeFile.write(path.getEndPoint()+csvDelimiter)
        writeFile.write(str(path.getPathDelay())+csvDelimiter)
        writeFile.write(str(path.getPathLength()))
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