#!mainFile "../StadiumBox.opy"

macro eventPlayer.isSampling():
    eventPlayer.CurrentCellIndex != -1

macro eventPlayer.isSampleReady():
    eventPlayer.isSampling() and eventPlayer.SampleReady

macro eventPlayer.stopForcingAllButtons():
    eventPlayer.stopForcingButton(AllButtons)

macro eventPlayer.disallowAllButtons():
    eventPlayer.disallowButton(AllButtons)

macro eventPlayer.allowAllButtons():
    eventPlayer.allowButton(AllButtons)