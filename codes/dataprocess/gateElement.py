gateLoadDictionary =  {
    "unmapped_d_flop" : 5.0,
    "unmapped_complex2" : 4.0,
    "unmapped_or2" : 3.0,
    "unmapped_and2" : 3.0,
    "unmapped_nor2" : 2.0,
    "unmapped_nand2" : 2.0,
    "unmapped_not" : 1.0
}


class gateBlock:

    def __init__(self):
        self.gateName = None
        self.gateType = None
        self.fanout = 0
        self.fanoutName = None
        self.gateDelay = 0
        self.gateLoad = 0.0
        self.gateID = 0.0
        self.targetCycleTime = 0

    def setGateParams(self,name,type,delay,load):
        self.gateName = name
        self.gateType = type
        self.gateDelay = delay
        self.gateLoad = load
        if(self.gateType in gateLoadDictionary.keys()):
          self.gateID = gateLoadDictionary[self.gateType]

    def setFanoutChar(self,name,fanout):
        self.fanout = fanout
        self.fanoutName = name

    def setTargetCycleTime(self,ct):
        self.targetCycleTime = ct

    def getFeature(self):
        return [self.targetCycleTime,self.gateID,self.gateLoad]

class pathSegment:

    def __init__(self):
        self.startPoint = None
        self.endPoint = None
        self.pathLength = 0
        self.dataArrivalTime = 0
        self.gateList = []

    def setStartAndEndpoint(self,start,end):
        self.startPoint = start
        self.endPoint = end

    def setPathDelay(self,pDelay):
        self.dataArrivalTime = pDelay

    def addGateObj(self,gateObj):
        self.gateList.append(gateObj)
        self.pathLength+=1

    def getPath(self):
        return self.gateList

    def getPathLength(self):
        return self.pathLength
    def getPathDelay(self):
        return self.dataArrivalTime

    def getStartPoint(self):
        return self.startPoint

    def getEndPoint(self):
        return self.endPoint

    def getGateList(self):
        return self.gateList
