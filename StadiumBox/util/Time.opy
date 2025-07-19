#!mainFile "../StadiumBox.opy"

macro updateTimeMS():
    TimeMS = getTotalTimeElapsed() * 1000

macro eventPlayer.updateLastTimeMS():
    updateTimeMS()
    eventPlayer.LastTickTime = TimeMS

macro eventPlayer.getLastTimeDifferenceMS():
    TimeMS - eventPlayer.LastTickTime