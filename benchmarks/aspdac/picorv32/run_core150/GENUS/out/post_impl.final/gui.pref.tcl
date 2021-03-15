###############################################################
#  Generated by:      Cadence Innovus 18.13-s088_1
#  OS:                Linux x86_64(Host ID hansolo.poly.edu)
#  Generated on:      Sun Mar 14 20:06:48 2021
#  Design:            picorv32
#  Command:           write_db out/post_impl.final
###############################################################

################################################
#  Preference File                             #
################################################

################################################
#  Syntax for Design-related/non-color pref:   #
#  set_preference <preference_name> <value>     #
################################################
set_preference DesignHierChar {/}
set_preference DEFHierChar {/}
set_preference PDEFBusDelim {[]}
set_preference LecDofile 0
set_preference CmdLogMode 1
set_preference ConstraintUserXGrid 0.0
set_preference ConstraintUserYGrid 0.0
set_preference ConstraintUserXOffset 0.0
set_preference ConstraintUserYOffset 0.0
set_preference SnapAllCorners 0
set_preference UserGridUnit 0
set_preference LogTypeInCmd 0
set_preference logviewer 0
set_preference EnableRectilinearDesign 0

################################################
#  Syntax for Display-related/non-color pref:  #
#  set_preference <preference_name> <value>     #
################################################
set_preference MinFPModuleSize 100
set_preference MinFlightLineWidth 1
set_preference MaxFlightLineNetTerms 500
set_preference LevelFlight 1
set_preference DirectionSink 1
set_preference DirectionSource 1
set_preference HiliteNetWhenQueryObj 1
set_preference HiliteShapeWhenSelectNet 0
set_preference SelectNetWhenSelectPin 0
set_preference HiliteNetWhenSelectPin 1
set_preference HiliteNetWhenSelectWire 1
set_preference QueryWireNet 0
set_preference ControlPinSelectabilityByInstance 1
set_preference OnlySelectHighlighted 0
set_preference SelectByArea 0
set_preference WinSelectMargin 8
set_preference ShowNumberBlockConnection 0
set_preference StrecthRestriction 0
set_preference StretchRectilinear 0
set_preference MoveRestriction 0
set_preference DisplayRelFPlan 1
set_preference LegalizeMacro 0
set_preference DisplayPtnPin 1
set_preference DisplayFPlanFlightLine 1
set_preference DisplayPinName 0
set_preference CopyNetKeepNetName 1
set_preference InstanceText Instance
set_preference ShowNetFullName 0
set_preference ShowNetNameWithLayerColor 0
set_preference TermCrossPix 4
set_preference hInstInnerText t
set_preference ExclusiveFlight 0
set_preference FlightLineInMove 1
set_preference AutoRedraw 1
set_preference ShowViaMetal 0
set_preference IgnoreAmoebaRatio 0
set_preference DisplayCellPattern 0
set_preference DrawInstByPlaceStatus 1
set_preference DrawWireByWireStatus 1
set_preference ShowCrossLineWhenSelect 1
set_preference FullViewOutsideDieArea 0
set_preference UseDigitFillPattern 1
set_preference DisplayCutPattern 1
set_preference DrawDetailWhenMoveVia 1
set_preference TurnOnLayersWhenEditWire 1
set_preference DisplayIndicatorOfViaPillar 0
set_preference ShowConnectionInOutNumber 0
set_preference ConnectionColorType 0
set_preference OnlyBundleNetFlight 0
set_preference FromOutputPin 0
set_preference ShowFlightLineTermMark 0
set_preference BlockFlightLine 1
set_preference InstFlightLine 1
set_preference ModuleFlightLine 1
set_preference IoCellFlightLine 1
set_preference BlackBoxFlightLine 1
set_preference ShowConnectionWithWidth 0
set_preference FLWidthThresholdLow 20
set_preference FLWidthThresholdHigh 80
set_preference percentageOfPan 30
set_preference scaleOfZoom 3.0
set_preference WheelZoomWithModify 0
set_preference ShowBothInputConnection 0
set_preference ShowNetWeightConnection 1
set_preference ShowFlightLineThruPtnPin 0
set_preference ShowLefLayerName 1
set_preference ShowAttrPopup 1
set_preference EnlargeLogicalPin 1
set_preference ShowDelBox 0
set_preference SelectByLine 0
set_preference SelectStickyMode 0
set_preference ShowUnplacedInst 0
set_preference ShowRectilinearPad 0
set_preference zoomPrevCount 6
set_preference displayViaSize 1
set_preference noInsideMacro 0
set_preference ShowParentModule 0
set_preference ShowChildPartition 0
set_preference ShowAllFence 0
set_preference SkipBufferFlightline 0
set_preference ShowFPObjInPlace 0
set_preference DrawFlightlineLast 0
set_preference DetailDisplayFactor 16
set_preference SingleLayerMode 0
set_preference QuerySkipInst 0
set_preference QuerySkipInstObs 0
set_preference QuerySkipInstPin 0
set_preference QuerySkipRegular 0
set_preference QuerySkipSpecial 0
set_preference ShowModuleText 1
set_preference ShowAmoebaModuleText 1
set_preference ShowRowSiteText 1
set_preference ShowIoPadText 1
set_preference ShowInstanceText 1
set_preference ShowInstancePinText 1
set_preference ShowIoPinText 1
set_preference ShowGroupText 1
set_preference ShowBumpText 1
set_preference ShowClockTreeText 1
set_preference ShowChannelText 1
set_preference ShowLefPortNumText 1
set_preference ShowMacroSitePtnText 1
set_preference ShowSIPFingerText 1
set_preference ShowNetText 1
set_preference ShowUtilizationText 1
set_preference TextDisplaySize a
set_preference AutoDetailDisplay 0

################################################
#  Syntax for Floorplan-related/non-color pref:#
#  set_preference <preference_name> <value>     #
################################################
set_preference CloneSnapMaster 0
set_preference MoveMacrosWithGuide 0
set_preference MoveMacrosWithRegion 0
set_preference MoveMacrosWithFence 1
set_preference MoveStdCellWithGuide 0
set_preference MoveStdCellWithRegion 0
set_preference MoveStdCellWithFence 0
set_preference MovePreplacedStdCellOnly 0

################################################
#  Syntax for Comgestion Map related pref:     #
#  set_preference <preference_name> <value>     #
################################################
set_preference VertViolation 0.0
set_preference HorzViolation 0.0
set_preference congestionMap_nrStyle 0
set_preference congestionMap_trStyle 0
set_preference congestionMap_range0 -2
set_preference congestionMap_color0 0
set_preference congestionMap_range1 -1
set_preference congestionMap_color1 0
set_preference congestionMap_range2 0
set_preference congestionMap_color2 1
set_preference congestionMap_range3 1
set_preference congestionMap_color3 2
set_preference congestionMap_range4 2
set_preference congestionMap_color4 3
set_preference congestionMap_range5 3
set_preference congestionMap_color5 5
set_preference congestionMap_range6 4
set_preference congestionMap_color6 9
set_preference congestionMap_range7 5
set_preference congestionMap_color7 11
set_preference congestionMap_range8 6
set_preference congestionMap_color8 11
set_preference congestionMap_range9 27
set_preference congestionMap_color9 11
set_layer_preference congestH -is_visible 0
set_layer_preference congestV -is_visible 0
set_layer_preference congestObj -is_visible 0

################################################
#  Syntax for display threshold related pref:   #
#  set_preference <preference_name> <value>     #
################################################
set_preference SpeedLevel 0
set_preference HighlightColorNumber 64

################################################
#  Syntax for flightline color related pref:   #
#  set_preference <preference_name> <value>     #
################################################
set_preference InputConnectionColor red
set_preference OutputConnectionColor green
set_preference InoutConnectionColor yellow
set_preference MixtureConnectionColor blue

################################################
#  Syntax for attribute summary of             #
#  object attribute related pref:              #
#  set_preference <preference_name> <value>     #
################################################

