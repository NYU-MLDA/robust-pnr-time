class gateBlock:

    def __init__(self):
        self.gateName = None
        self.gateType = None
        self.fanoutLoad = 0
        self.fanoutName = None
        self.gateDelay = 0
        self.targetCycleTime = 0

    def setGateParams(self,name,type,delay):
        self.gateName = name
        self.gateType = type
        self.gateDelay = delay

    def setFanoutChar(self,name,load):
        self.fanoutLoad = load
        self.fanoutName = name

    def setTargetCycleTime(self,ct):
        self.targetCycleTime = ct

    def getFeature(self):
        return [self.targetCycleTime,self.fanoutName,self.fanoutLoad]

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