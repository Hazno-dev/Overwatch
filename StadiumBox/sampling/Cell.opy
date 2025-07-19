#!mainFile "../StadiumBox.opy"
#!optimizeForSize

macro eventPlayer.CellCenter():
    CellCenter[self.CurrentCellIndex]

macro eventPlayer.CellCenterExtended():
    CellCenterExtended[self.CurrentCellIndex]

macro eventPlayer.CellFacingDirection():
    CellFacingDirection[self.CurrentCellIndex]

macro eventPlayer.CellCameraPosition():
    CellCameraPosition[self.CurrentCellIndex]   

macro eventPlayer.CellEnemyPositions():
    CellEnemyPositions[self.CurrentCellIndex]

rule "InitializeCells":
    @Event global
    splitDictArray({center: CellCenter, extendedCenter: CellCenterExtended, facingDirection: CellFacingDirection, cameraPosition: CellCameraPosition, enemyPositions: CellEnemyPositions}, [
    {
        center: vect(42, 2, 12), 
        extendedCenter: vect(39, 2, 16), 
        facingDirection: vect(0.58, 0, -0.81), 
        cameraPosition: vect(39, 8, 16), 
        enemyPositions: [vect(44, 2, 8.85)] # vect(46.61, 2, 10.73), vect(42.3, 2, 7.7)
    },
    ], true)

   