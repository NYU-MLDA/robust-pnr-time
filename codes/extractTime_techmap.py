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
    argparser.add_argument("-o", "--output_file", action="store", dest="output_file", default="prePnR.csv",
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


def parseFileLines(filelineContents):
    idx = 0
    numLines = len(filelineContents)
    while(idx < numLines):
        line = filelineContents[idx]
        if(line.__contains__("Startpoint")):
            tempPS = pathSegment()
            line = line.strip("\r\n").split(")")
            startPoint = re.sub("[^A-Za-z0-9_]", "_",line[1])
        elif(line.__contains__("Endpoint")):
            line = line.strip("\r\n").split(")")
            endPoint = re.sub("[^A-Za-z0-9_]", "_",line[1])
            #print(line)
        elif(line.__contains__("Load") and line.__contains__("Delay") and line.__contains__("Fanout")):
            idx+=4 # Length 3 buffer, no good inputs.
            firstLine = filelineContents[idx]
            idx+=1
            secondLine = filelineContents[idx]
            pathDelay = 0
            tempPS.setStartAndEndpoint(startPoint,endPoint)
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
        #pathInfo = path.getGateList()
        #for gate in pathInfo:
        #    print(gate.getFeature())
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