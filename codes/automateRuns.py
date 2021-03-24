import sys,os,shutil
import argparse

## Timing cycle
clockPeriods = [400,500,600,700,800]

##
#nohup path to run.sh > log file

##
#Post processing stage
#Parse pre and post pnr data



INFO = "Automate data generation"
VERSION = 0.1
rootDir = ""
runNum = 0
templateDir = ""



def showVersion():
    print(INFO)
    print(VERSION)
    sys.exit()

def parseArguments():
    global rootDir,runNum
    argparser = argparse.ArgumentParser(description="Feature Extraction (Pre PnR synthesis)")
    argparser.add_argument("-V", "--version", action="store_true", dest="showversion", default=False,
                           help="Show the version")
    argparser.add_argument("-d", "--dirc", action="store", dest="dirc", default="",required=True,
                           help="Specify the root directory of the design")
    argparser.add_argument("-r", "--run_number", action="store", dest="run_number", default="",required=True,
                           help="Specify the run number")
    #argparser.add_argument("-o", "--output_file", action="store", dest="output_file", default="prePnR.csv",
    #                       help="Specify the name of the output csv file")

    # read arguments/options from the cmd line
    args = argparser.parse_args()

    if args.showversion:
        showVersion()

    if (args.dirc == None or args.run_number == None):
        print("Provide proper arguments")
        exit()
    else:
        rootDir = args.dirc
        runNum = args.run_number


def createFolder(destFolder,clockPeriod):
    os.mkdir(destFolder)
    shutil.copy(templateDir,destFolder)
    configFile = open(os.path.join(destFolder,'GENUS','config.tcl'),'w+')
    configFile.write("\nset CLOCK_PERIOD "+str(clockPeriod/1000)+"\n")
    configFile.close()

def createRunsAndGenScript():
    global templateDir
    templateDir = os.path.join(rootDir,"template")
    finalRunScript = open(os.path.join(rootDir,"batchRun.sh"),"w+")
    for cp in clockPeriods:
        destFolder = os.path.join(rootDir,'runD'+str(runNum)+"_"+str(cp))
        createFolder(destFolder,cp)
        nohupCmd = "nohup "+os.path.join(destFolder,'GENUS','run.sh')+" > "+os.path.join(destFolder,'GENUS','log_Fullrun')+"2>&1 &"
        finalRunScript.write(nohupCmd+"\n")
    finalRunScript.close()

if __name__ == "__main__":
    parseArguments()
    createRunsAndGenScript()
