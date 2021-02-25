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
            line = line.strip("\r\n").split(":")
            startPoint = re.sub("[^A-Za-z0-9_]", "_",line[1])
        elif(line.__contains__("Endpoint")):
            line = line.strip("\r\n").split(":")
            endPoint = re.sub("[^A-Za-z0-9_]", "_",line[1])
        elif(line.__contains__("Point") and line.__contains__("Incr") and line.__contains__("Fanout")):
            idx+=4 # Length 3 buffer, no good inputs.
            line = filelineContents[idx]
            gateDelay = 0
            pathDelay = 0
            netFlag = 0 # Every net followed by two gate entries
            tempPS.setStartAndEndpoint(startPoint,endPoint)
            while(not line.__contains__("data arrival time")):
                #### Logic for new path
                ### paramList[0] contains name, Param[1] contains gate type, param[2] contains Fanout, param[3] - Trans
                ### Param[4] - Incr, Param[4] -  Path
                parseList = re.findall(r'[A-Za-z0-9/._\[(){}\]]+',line)
                if(parseList[1].__contains__("net")):
                    if(netFlag == 1):
                        idx += 1
                        line = filelineContents[idx]
                        continue
                    netFlag = 1
                    gateObj = gateBlock()
                    fanoutLoad = int(parseList[2])
                    fanoutName = parseList[0]
                    gateObj.setGateParams(gateName,gateType,gateDelay)
                    gateObj.setFanoutChar(fanoutName,fanoutLoad)
                    pathDelay += gateDelay
                    tempPS.addGateObj(gateObj)
                    gateDelay = 0
                elif(parseList[1].__contains__("X1")):
                    gateType = re.sub("[^A-Za-z0-9]", "",parseList[1])
                    gateName = parseList[0]
                    gateDelay+=float(parseList[2])
                    netFlag = 0
                else:
                    pass
                #print(parseList[1])
                idx+=1
                line = filelineContents[idx]
                #continue
            tempPS.setPathDelay(pathDelay)
            pathInformation.append(tempPS)
        idx+=1

def reportInfo():
    for path in pathInformation:
        print("\n\nPath info:\n")
        print(path.getStartPoint())
        print(path.getEndPoint())
        print(path.getPathDelay())
        print(path.getPathLength())


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