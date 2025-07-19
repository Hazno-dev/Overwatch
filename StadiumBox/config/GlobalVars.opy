#!mainFile "../StadiumBox.opy"

globalvar FreeCells = [0]
globalvar Iterator
globalvar LastEntity

globalvar CellCenter
globalvar CellCenterExtended
globalvar CellFacingDirection
globalvar CellCameraPosition
globalvar CellEnemyPositions

globalvar AllButtons = [
    Button.ABILITY_1,
    Button.ABILITY_2,
    Button.CROUCH,
    Button.INTERACT,
    Button.JUMP,
    Button.MELEE,
    Button.PRIMARY_FIRE,
    Button.RELOAD,
    Button.SECONDARY_FIRE,
    Button.ULTIMATE
]

globalvar TimeMS