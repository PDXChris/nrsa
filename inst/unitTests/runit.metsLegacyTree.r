##  Testing metsLegacyTree
##  Data and metrics for/from EMAP SAS code are being used.

metsLegacyTreeTest <- function()
{
  testData <- metsLegacyTree.inputData()
  testResults <- metsLegacyTree.testResults()

  legMets <- metsLegacyTree.1(testData)

  ## Get both data frames in the same order
  testMets <- legMets[order(legMets$UID, legMets$METRIC),]
  sasMets <- testResults[order(testResults$UID, testResults$METRIC),]

  # Character and numeric metrics are checked separately
  testMets.1 <- subset(testMets
                      ,METRIC %in% c('ltfracl', 'ltfracm', 'ltfracs'
                                    ,'ltfracx', 'ltmddist', 'ltmddomn'
                                    ,'ltmxcnt', 'ltmxdist', 'ltmdsubn'
                                    )
                      )
  testMets.2 <- subset(testMets
                      ,!(METRIC %in% c('ltfracl', 'ltfracm', 'ltfracs'
                                      ,'ltfracx', 'ltmddist', 'ltmddomn'
                                      ,'ltmxcnt', 'ltmxdist', 'ltmdsubn'
                                      )
                        )
                      )

  sasMets.1 <- subset(sasMets
                     ,METRIC %in% c('ltfracl', 'ltfracm', 'ltfracs'
                                   ,'ltfracx', 'ltmddist', 'ltmddomn'
                                   ,'ltmxcnt', 'ltmxdist', 'ltmdsubn'
                                   )
                     )
  sasMets.2 <- subset(sasMets
                     ,!(METRIC %in% c('ltfracl', 'ltfracm', 'ltfracs'
                                     ,'ltfracx', 'ltmddist', 'ltmddomn'
                                     ,'ltmxcnt', 'ltmxdist', 'ltmdsubn'
                                     )
                       )
                     )

  testMets.1$RESULT <- as.numeric(testMets.1$RESULT)
  sasMets.1$RESULT <- as.numeric(sasMets.1$RESULT)

  aa <- dfCompare(testMets.1, sasMets.1, c('UID', 'METRIC'), zeroFudge=1e-9)
  checkEquals(NULL, aa, "Error: metsLegacyTree numeric metrics are broken")
  bb <- dfCompare(testMets.2, sasMets.2, c('UID', 'METRIC'))
  checkEquals(NULL, aa, "Error: metsLegacyTree character metrics are broken")

  #return(aa)
  #return(bb)
}


metsLegacyTree.inputData <- function()
# creates dataframe of legacy tree data for unit test
{
fred <- textConnection(
"UID TRANSECT PARAMETER RESULT
'EPA01-0124' 'A' 'DBH' '.3-.75'
'EPA01-0124' 'A' 'DISTANCE' '1'
'EPA01-0124' 'A' 'HEIGHT' '>30'
'EPA01-0124' 'A' 'SPECIES' 'FIR'
'EPA01-0124' 'A' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'B' 'DBH' '.3-.75'
'EPA01-0124' 'B' 'DISTANCE' '1'
'EPA01-0124' 'B' 'HEIGHT' '>30'
'EPA01-0124' 'B' 'SPECIES' 'FIR'
'EPA01-0124' 'B' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'C' 'DBH' '.3-.75'
'EPA01-0124' 'C' 'DISTANCE' '0'
'EPA01-0124' 'C' 'HEIGHT' '>30'
'EPA01-0124' 'C' 'SPECIES' 'FIR'
'EPA01-0124' 'C' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'D' 'DBH' '.3-.75'
'EPA01-0124' 'D' 'DISTANCE' '1'
'EPA01-0124' 'D' 'HEIGHT' '>30'
'EPA01-0124' 'D' 'SPECIES' 'FIR'
'EPA01-0124' 'D' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'E' 'DBH' '.3-.75'
'EPA01-0124' 'E' 'DISTANCE' '1'
'EPA01-0124' 'E' 'HEIGHT' '15-30'
'EPA01-0124' 'E' 'SPECIES' 'FIR'
'EPA01-0124' 'E' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'F' 'DBH' '.3-.75'
'EPA01-0124' 'F' 'DISTANCE' '3'
'EPA01-0124' 'F' 'HEIGHT' '>30'
'EPA01-0124' 'F' 'SPECIES' 'FIR'
'EPA01-0124' 'F' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'G' 'DBH' '.3-.75'
'EPA01-0124' 'G' 'DISTANCE' '0'
'EPA01-0124' 'G' 'HEIGHT' '>30'
'EPA01-0124' 'G' 'SPECIES' 'FIR'
'EPA01-0124' 'G' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'H' 'DBH' '.3-.75'
'EPA01-0124' 'H' 'DISTANCE' '0'
'EPA01-0124' 'H' 'HEIGHT' '>30'
'EPA01-0124' 'H' 'SPECIES' 'FIR'
'EPA01-0124' 'H' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'I' 'DBH' '.3-.75'
'EPA01-0124' 'I' 'DISTANCE' '1'
'EPA01-0124' 'I' 'HEIGHT' '>30'
'EPA01-0124' 'I' 'SPECIES' 'FIR'
'EPA01-0124' 'I' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'J' 'DBH' '.3-.75'
'EPA01-0124' 'J' 'DISTANCE' '2'
'EPA01-0124' 'J' 'HEIGHT' '>30'
'EPA01-0124' 'J' 'SPECIES' 'FIR'
'EPA01-0124' 'J' 'TREE_TYP' 'Coniferous'
'EPA01-0124' 'K' 'DBH' '.3-.75'
'EPA01-0124' 'K' 'DISTANCE' '1'
'EPA01-0124' 'K' 'HEIGHT' '>30'
'EPA01-0124' 'K' 'SPECIES' 'FIR'
'EPA01-0124' 'K' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'A' 'DBH' '.3-.75'
'EPA01-0144' 'A' 'DISTANCE' '1'
'EPA01-0144' 'A' 'HEIGHT' '>30'
'EPA01-0144' 'A' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'A' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'B' 'DBH' '.3-.75'
'EPA01-0144' 'B' 'DISTANCE' '15'
'EPA01-0144' 'B' 'HEIGHT' '>30'
'EPA01-0144' 'B' 'SPECIES' 'LODGEPOLE PINE'
'EPA01-0144' 'B' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'C' 'DBH' '.3-.75'
'EPA01-0144' 'C' 'DISTANCE' '5'
'EPA01-0144' 'C' 'HEIGHT' '>30'
'EPA01-0144' 'C' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'C' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'D' 'DBH' '.3-.75'
'EPA01-0144' 'D' 'DISTANCE' '4'
'EPA01-0144' 'D' 'HEIGHT' '>30'
'EPA01-0144' 'D' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'D' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'E' 'DBH' '.3-.75'
'EPA01-0144' 'E' 'DISTANCE' '15'
'EPA01-0144' 'E' 'HEIGHT' '>30'
'EPA01-0144' 'E' 'SPECIES' 'SUBALPINE FIR'
'EPA01-0144' 'E' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'F' 'DBH' '.3-.75'
'EPA01-0144' 'F' 'DISTANCE' '5'
'EPA01-0144' 'F' 'HEIGHT' '>30'
'EPA01-0144' 'F' 'SPECIES' 'SUBALPINE FIR'
'EPA01-0144' 'F' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'G' 'DBH' '.3-.75'
'EPA01-0144' 'G' 'DISTANCE' '0.5'
'EPA01-0144' 'G' 'HEIGHT' '>30'
'EPA01-0144' 'G' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'G' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'H' 'DBH' '.3-.75'
'EPA01-0144' 'H' 'DISTANCE' '2'
'EPA01-0144' 'H' 'HEIGHT' '>30'
'EPA01-0144' 'H' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'H' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'I' 'DBH' '.3-.75'
'EPA01-0144' 'I' 'DISTANCE' '10'
'EPA01-0144' 'I' 'HEIGHT' '>30'
'EPA01-0144' 'I' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'I' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'J' 'DBH' '.1-.3'
'EPA01-0144' 'J' 'DISTANCE' '15'
'EPA01-0144' 'J' 'HEIGHT' '15-30'
'EPA01-0144' 'J' 'SPECIES' 'SUBALPINE FIR'
'EPA01-0144' 'J' 'TREE_TYP' 'Coniferous'
'EPA01-0144' 'K' 'DBH' '.3-.75'
'EPA01-0144' 'K' 'DISTANCE' '1'
'EPA01-0144' 'K' 'HEIGHT' '>30'
'EPA01-0144' 'K' 'SPECIES' 'SPRUCE'
'EPA01-0144' 'K' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'A' 'DBH' '.3-.75'
'EPA01-0147' 'A' 'DISTANCE' '4'
'EPA01-0147' 'A' 'HEIGHT' '>30'
'EPA01-0147' 'A' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'A' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'B' 'DBH' '.3-.75'
'EPA01-0147' 'B' 'DISTANCE' '1'
'EPA01-0147' 'B' 'HEIGHT' '15-30'
'EPA01-0147' 'B' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'B' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'C' 'DBH' '.3-.75'
'EPA01-0147' 'C' 'DISTANCE' '3'
'EPA01-0147' 'C' 'HEIGHT' '>30'
'EPA01-0147' 'C' 'SPECIES' 'HEMLOCK'
'EPA01-0147' 'C' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'D' 'DBH' '.3-.75'
'EPA01-0147' 'D' 'DISTANCE' '0.5'
'EPA01-0147' 'D' 'HEIGHT' '>30'
'EPA01-0147' 'D' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'D' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'E' 'DBH' '.1-.3'
'EPA01-0147' 'E' 'DISTANCE' '0'
'EPA01-0147' 'E' 'HEIGHT' '15-30'
'EPA01-0147' 'E' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'E' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'F' 'DBH' '.3-.75'
'EPA01-0147' 'F' 'DISTANCE' '2'
'EPA01-0147' 'F' 'HEIGHT' '>30'
'EPA01-0147' 'F' 'SPECIES' 'HEMLOCK'
'EPA01-0147' 'F' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'G' 'DBH' '.75-2'
'EPA01-0147' 'G' 'DISTANCE' '2'
'EPA01-0147' 'G' 'HEIGHT' '>30'
'EPA01-0147' 'G' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'G' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'H' 'DBH' '.1-.3'
'EPA01-0147' 'H' 'DISTANCE' '10'
'EPA01-0147' 'H' 'HEIGHT' '15-30'
'EPA01-0147' 'H' 'SPECIES' 'HEMLOCK'
'EPA01-0147' 'H' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'I' 'DBH' '.75-2'
'EPA01-0147' 'I' 'DISTANCE' '1'
'EPA01-0147' 'I' 'HEIGHT' '>30'
'EPA01-0147' 'I' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'I' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'J' 'DBH' '.3-.75'
'EPA01-0147' 'J' 'DISTANCE' '5'
'EPA01-0147' 'J' 'HEIGHT' '>30'
'EPA01-0147' 'J' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'J' 'TREE_TYP' 'Coniferous'
'EPA01-0147' 'K' 'DBH' '.75-2'
'EPA01-0147' 'K' 'DISTANCE' '2'
'EPA01-0147' 'K' 'HEIGHT' '>30'
'EPA01-0147' 'K' 'SPECIES' 'WESTERN RED CEDAR'
'EPA01-0147' 'K' 'TREE_TYP' 'Coniferous'
'EPA01-0159' 'A' 'DBH' '0-0.1'
'EPA01-0159' 'A' 'DISTANCE' '1'
'EPA01-0159' 'A' 'HEIGHT' '5-15'
'EPA01-0159' 'A' 'SPECIES' 'WILLOW'
'EPA01-0159' 'A' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'B' 'DBH' '.1-.3'
'EPA01-0159' 'B' 'DISTANCE' '15'
'EPA01-0159' 'B' 'HEIGHT' '5-15'
'EPA01-0159' 'B' 'SPECIES' 'ASPEN'
'EPA01-0159' 'B' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'C' 'DBH' '.1-.3'
'EPA01-0159' 'C' 'DISTANCE' '15'
'EPA01-0159' 'C' 'HEIGHT' '5-15'
'EPA01-0159' 'C' 'SPECIES' 'ASPEN'
'EPA01-0159' 'C' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'D' 'DBH' '0-0.1'
'EPA01-0159' 'D' 'DISTANCE' '10'
'EPA01-0159' 'D' 'HEIGHT' '<5'
'EPA01-0159' 'D' 'SPECIES' 'ASPEN'
'EPA01-0159' 'D' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'E' 'DBH' '.1-.3'
'EPA01-0159' 'E' 'DISTANCE' '8'
'EPA01-0159' 'E' 'HEIGHT' '5-15'
'EPA01-0159' 'E' 'SPECIES' 'ASPEN'
'EPA01-0159' 'E' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'F' 'DBH' '0-0.1'
'EPA01-0159' 'F' 'DISTANCE' '1'
'EPA01-0159' 'F' 'HEIGHT' '<5'
'EPA01-0159' 'F' 'SPECIES' 'WILLOW'
'EPA01-0159' 'F' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'G' 'DBH' '.3-.75'
'EPA01-0159' 'G' 'DISTANCE' '2'
'EPA01-0159' 'G' 'HEIGHT' '<5'
'EPA01-0159' 'G' 'SPECIES' 'WILLOW'
'EPA01-0159' 'G' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'H' 'DBH' '0-0.1'
'EPA01-0159' 'H' 'DISTANCE' '5'
'EPA01-0159' 'H' 'HEIGHT' '<5'
'EPA01-0159' 'H' 'SPECIES' 'WILLOW'
'EPA01-0159' 'H' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'I' 'DBH' '0-0.1'
'EPA01-0159' 'I' 'DISTANCE' '1'
'EPA01-0159' 'I' 'HEIGHT' '<5'
'EPA01-0159' 'I' 'SPECIES' 'WILLOW'
'EPA01-0159' 'I' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'J' 'DBH' '.1-.3'
'EPA01-0159' 'J' 'DISTANCE' '1'
'EPA01-0159' 'J' 'HEIGHT' '<5'
'EPA01-0159' 'J' 'SPECIES' 'WILLOW'
'EPA01-0159' 'J' 'TREE_TYP' 'Deciduous'
'EPA01-0159' 'K' 'DBH' '.1-.3'
'EPA01-0159' 'K' 'DISTANCE' '10'
'EPA01-0159' 'K' 'HEIGHT' '5-15'
'EPA01-0159' 'K' 'SPECIES' 'WILLOW'
'EPA01-0159' 'K' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'A' 'DBH' '.1-.3'
'EPA01-0161' 'A' 'DISTANCE' '5'
'EPA01-0161' 'A' 'HEIGHT' '5-15'
'EPA01-0161' 'A' 'SPECIES' 'ALDER/BIRCH'
'EPA01-0161' 'A' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'B' 'DBH' '.1-.3'
'EPA01-0161' 'B' 'DISTANCE' '5'
'EPA01-0161' 'B' 'HEIGHT' '5-15'
'EPA01-0161' 'B' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'B' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'C' 'DBH' '.1-.3'
'EPA01-0161' 'C' 'DISTANCE' '5'
'EPA01-0161' 'C' 'HEIGHT' '5-15'
'EPA01-0161' 'C' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'C' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'D' 'DBH' '.1-.3'
'EPA01-0161' 'D' 'DISTANCE' '5'
'EPA01-0161' 'D' 'HEIGHT' '5-15'
'EPA01-0161' 'D' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'D' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'E' 'DBH' '.1-.3'
'EPA01-0161' 'E' 'DISTANCE' '5'
'EPA01-0161' 'E' 'HEIGHT' '5-15'
'EPA01-0161' 'E' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'E' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'F' 'DBH' '.1-.3'
'EPA01-0161' 'F' 'DISTANCE' '2'
'EPA01-0161' 'F' 'HEIGHT' '5-15'
'EPA01-0161' 'F' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'F' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'G' 'DBH' '.1-.3'
'EPA01-0161' 'G' 'DISTANCE' '1'
'EPA01-0161' 'G' 'HEIGHT' '5-15'
'EPA01-0161' 'G' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'G' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'H' 'DBH' '.1-.3'
'EPA01-0161' 'H' 'DISTANCE' '1'
'EPA01-0161' 'H' 'HEIGHT' '5-15'
'EPA01-0161' 'H' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'H' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'I' 'DBH' '.1-.3'
'EPA01-0161' 'I' 'DISTANCE' '1'
'EPA01-0161' 'I' 'HEIGHT' '5-15'
'EPA01-0161' 'I' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'I' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'J' 'DBH' '.1-.3'
'EPA01-0161' 'J' 'DISTANCE' '1'
'EPA01-0161' 'J' 'HEIGHT' '5-15'
'EPA01-0161' 'J' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'J' 'TREE_TYP' 'Deciduous'
'EPA01-0161' 'K' 'DBH' '.1-.3'
'EPA01-0161' 'K' 'DISTANCE' '2'
'EPA01-0161' 'K' 'HEIGHT' '5-15'
'EPA01-0161' 'K' 'SPECIES' 'POPLAR/COTTONWOOD'
'EPA01-0161' 'K' 'TREE_TYP' 'Deciduous'
'EPA01-0167' 'A' 'DBH' '.3-.75'
'EPA01-0167' 'A' 'DISTANCE' '16'
'EPA01-0167' 'A' 'HEIGHT' '15-30'
'EPA01-0167' 'A' 'SPECIES' 'FIR'
'EPA01-0167' 'A' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'B' 'DBH' '.3-.75'
'EPA01-0167' 'B' 'DISTANCE' '4'
'EPA01-0167' 'B' 'HEIGHT' '15-30'
'EPA01-0167' 'B' 'SPECIES' 'FIR'
'EPA01-0167' 'B' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'C' 'DBH' '.3-.75'
'EPA01-0167' 'C' 'DISTANCE' '2'
'EPA01-0167' 'C' 'HEIGHT' '15-30'
'EPA01-0167' 'C' 'SPECIES' 'FIR'
'EPA01-0167' 'C' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'D' 'DBH' '.3-.75'
'EPA01-0167' 'D' 'DISTANCE' '14'
'EPA01-0167' 'D' 'HEIGHT' '15-30'
'EPA01-0167' 'D' 'SPECIES' 'FIR'
'EPA01-0167' 'D' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'E' 'DBH' '.3-.75'
'EPA01-0167' 'E' 'DISTANCE' '12'
'EPA01-0167' 'E' 'HEIGHT' '15-30'
'EPA01-0167' 'E' 'SPECIES' 'FIR'
'EPA01-0167' 'E' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'F' 'DBH' '.3-.75'
'EPA01-0167' 'F' 'DISTANCE' '12'
'EPA01-0167' 'F' 'HEIGHT' '15-30'
'EPA01-0167' 'F' 'SPECIES' 'FIR'
'EPA01-0167' 'F' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'G' 'DBH' '.3-.75'
'EPA01-0167' 'G' 'DISTANCE' '10'
'EPA01-0167' 'G' 'HEIGHT' '15-30'
'EPA01-0167' 'G' 'SPECIES' 'FIR'
'EPA01-0167' 'G' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'H' 'DBH' '.3-.75'
'EPA01-0167' 'H' 'DISTANCE' '1'
'EPA01-0167' 'H' 'HEIGHT' '5-15'
'EPA01-0167' 'H' 'SPECIES' 'FIR'
'EPA01-0167' 'H' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'I' 'DBH' '.3-.75'
'EPA01-0167' 'I' 'DISTANCE' '7'
'EPA01-0167' 'I' 'HEIGHT' '15-30'
'EPA01-0167' 'I' 'SPECIES' 'FIR'
'EPA01-0167' 'I' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'J' 'DBH' '.3-.75'
'EPA01-0167' 'J' 'DISTANCE' '20'
'EPA01-0167' 'J' 'HEIGHT' '15-30'
'EPA01-0167' 'J' 'SPECIES' 'FIR'
'EPA01-0167' 'J' 'TREE_TYP' 'Coniferous'
'EPA01-0167' 'K' 'DBH' '.3-.75'
'EPA01-0167' 'K' 'DISTANCE' '5'
'EPA01-0167' 'K' 'HEIGHT' '15-30'
'EPA01-0167' 'K' 'SPECIES' 'FIR'
'EPA01-0167' 'K' 'TREE_TYP' 'Coniferous'"
)
testData <-read.table(fred, header=TRUE, stringsAsFactors=FALSE)
close(fred)
return(testData)
}


metsLegacyTree.testResults <- function()
# creates dataframe of legacy tree metrics calculation results for unit test
##  Test metrics from SAS are corrected for known errors.
{
bob <- textConnection(
"UID METRIC RESULT
'EPA01-0124' 'ltfracl' '1'
'EPA01-0124' 'ltfracm' '1'
'EPA01-0124' 'ltfracs' '1'
'EPA01-0124' 'ltfracx' '0'
'EPA01-0124' 'ltmddist' '1'
'EPA01-0124' 'ltmddom' 'Firs/Hemlock'
'EPA01-0124' 'ltmddomn' '11'
'EPA01-0124' 'ltmxcnt' '10'
'EPA01-0124' 'ltmxdbh' '.3-.75'
'EPA01-0124' 'ltmxdist' '1'
'EPA01-0124' 'ltmxht' '>30'
'EPA01-0124' 'ltmxsize' 'L'
'EPA01-0124' 'ltmxspp' 'Firs/Hemlock'
'EPA01-0124' 'ltsplist' 'FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR'
'EPA01-0144' 'ltfracl' '0.90909090909'
'EPA01-0144' 'ltfracm' '1'
'EPA01-0144' 'ltfracs' '1'
'EPA01-0144' 'ltfracx' '0'
'EPA01-0144' 'ltmddist' '5.85'
'EPA01-0144' 'ltmddom' 'Spruce'
'EPA01-0144' 'ltmddomn' '7'
'EPA01-0144' 'ltmdsub' 'Firs/Hemlock'
'EPA01-0144' 'ltmdsubn' '3'
'EPA01-0144' 'ltmxcnt' '10'
'EPA01-0144' 'ltmxdbh' '.3-.75'
'EPA01-0144' 'ltmxdist' '1'
'EPA01-0144' 'ltmxht' '>30'
'EPA01-0144' 'ltmxsize' 'L'
'EPA01-0144' 'ltmxspp' 'Spruce'
'EPA01-0144' 'ltsplist' 'SPRUCE,LODGEPOLE PINE,SPRUCE,SPRUCE,SUBALPINE FIR,SUBALPINE FIR,SPRUCE,SPRUCE,SPRUCE,SUBALPINE FIR,SPRUCE'
'EPA01-0147' 'ltfracl' '0.81818181818'
'EPA01-0147' 'ltfracm' '1'
'EPA01-0147' 'ltfracs' '1'
'EPA01-0147' 'ltfracx' '0.2727272727'
'EPA01-0147' 'ltmddist' '2.277777778'
'EPA01-0147' 'ltmddom' 'Cedar/Cypress/Sequoia'
'EPA01-0147' 'ltmddomn' '8'
'EPA01-0147' 'ltmdsub' 'Firs/Hemlock'
'EPA01-0147' 'ltmdsubn' '3'
'EPA01-0147' 'ltmxcnt' '3'
'EPA01-0147' 'ltmxdbh' '.75-2'
'EPA01-0147' 'ltmxdist' '2'
'EPA01-0147' 'ltmxht' '>30'
'EPA01-0147' 'ltmxsize' 'X'
'EPA01-0147' 'ltmxspp' 'Cedar/Cypress/Sequoia'
'EPA01-0147' 'ltsplist' 'WESTERN RED CEDAR,WESTERN RED CEDAR,HEMLOCK,WESTERN RED CEDAR,WESTERN RED CEDAR,HEMLOCK,WESTERN RED CEDAR,HEMLOCK,WESTERN RED CEDAR,WESTERN RED CEDAR,WESTERN RED CEDAR'
'EPA01-0159' 'ltfracl' '0'
'EPA01-0159' 'ltfracm' '0.454545454545'
'EPA01-0159' 'ltfracs' '1'
'EPA01-0159' 'ltfracx' '0'
'EPA01-0159' 'ltmddist' '8.5'
'EPA01-0159' 'ltmddom' 'Willow'
'EPA01-0159' 'ltmddomn' '7'
'EPA01-0159' 'ltmdsub' 'Poplar/Cottonwood'
'EPA01-0159' 'ltmdsubn' '4'
'EPA01-0159' 'ltmxcnt' '5'
'EPA01-0159' 'ltmxdbh' '.1-.3'
'EPA01-0159' 'ltmxdist' '15'
'EPA01-0159' 'ltmxht' '5-15'
'EPA01-0159' 'ltmxsize' 'M'
'EPA01-0159' 'ltmxspp' 'Poplar/Cottonwood'
'EPA01-0159' 'ltsplist' 'WILLOW,ASPEN,ASPEN,ASPEN,ASPEN,WILLOW,WILLOW,WILLOW,WILLOW,WILLOW,WILLOW'
'EPA01-0161' 'ltfracl' '0'
'EPA01-0161' 'ltfracm' '1'
'EPA01-0161' 'ltfracs' '1'
'EPA01-0161' 'ltfracx' '0'
'EPA01-0161' 'ltmddist' '3'
'EPA01-0161' 'ltmddom' 'Poplar/Cottonwood'
'EPA01-0161' 'ltmddomn' '10'
'EPA01-0161' 'ltmdsub' 'Alder/Birch'
'EPA01-0161' 'ltmdsubn' '1'
'EPA01-0161' 'ltmxcnt' '11'
'EPA01-0161' 'ltmxdbh' '.1-.3'
'EPA01-0161' 'ltmxdist' '5'
'EPA01-0161' 'ltmxht' '5-15'
'EPA01-0161' 'ltmxsize' 'M'
'EPA01-0161' 'ltmxspp' 'Alder/Birch'
'EPA01-0161' 'ltsplist' 'ALDER/BIRCH,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD,POPLAR/COTTONWOOD'
'EPA01-0167' 'ltfracl' '0.90909090909'
'EPA01-0167' 'ltfracm' '1'
'EPA01-0167' 'ltfracs' '1'
'EPA01-0167' 'ltfracx' '0'
'EPA01-0167' 'ltmddist' '9.363636364'
'EPA01-0167' 'ltmddom' 'Firs/Hemlock'
'EPA01-0167' 'ltmddomn' '11'
'EPA01-0167' 'ltmxcnt' '10'
'EPA01-0167' 'ltmxdbh' '.3-.75'
'EPA01-0167' 'ltmxdist' '16'
'EPA01-0167' 'ltmxht' '15-30'
'EPA01-0167' 'ltmxsize' 'L'
'EPA01-0167' 'ltmxspp' 'Firs/Hemlock'
'EPA01-0167' 'ltsplist' 'FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR,FIR'"
)

testResults <-read.table(bob, header=TRUE, stringsAsFactors=FALSE)
close(bob)
return(testResults)
}