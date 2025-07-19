#!mainFile "../StadiumBox.opy"

macro eventPlayer.startSample():
    if SUPPORTED_HEROES.index(eventPlayer.getHero()) == -1:
        smallMessage(eventPlayer, "{0} is currently not supported.".format(eventPlayer.getHero()))
        return

    if eventPlayer.isSampling():
        smallMessage(eventPlayer, "You are already in a cell.")
        return

    if len(FreeCells) == 0:
        smallMessage(eventPlayer, "All cells are occupied, please wait for a cell to become free.")
        return

    eventPlayer.resetStatistics()
    eventPlayer.CurrentCellIndex = FreeCells[0]
    FreeCells.remove(eventPlayer.CurrentCellIndex)

    eventPlayer.createBots()
    eventPlayer.startForcingPosition(eventPlayer.CellCenter(), false)
    eventPlayer.startFacing(eventPlayer.CellFacingDirection(), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.NONE)
    eventPlayer.startCamera(eventPlayer.CellCameraPosition(), eventPlayer.getPosition(), 0)
    eventPlayer.disableHeroHud()

    wait(0.1)
    eventPlayer.SampleReady = true

macro eventPlayer.endSample():
    if not eventPlayer.isSampling():
        smallMessage(eventPlayer, "You are not in a cell.")
        return

    smallMessage(eventPlayer, "Sample Complete.")
    eventPlayer.SampleReady = false
    FreeCells.append(eventPlayer.CurrentCellIndex)
    eventPlayer.CurrentCellIndex = -1

    eventPlayer.finalizeStatistics()

    eventPlayer.stopForcingAllButtons()

    eventPlayer.destroyBots()
    eventPlayer.stopForcingPosition()
    eventPlayer.stopFacing()
    eventPlayer.stopCamera()
    eventPlayer.enableHeroHud()

    eventPlayer.teleport(vect(54, 1, 37))
    eventPlayer.setFacing(vect(0, 0, 0), Relativity.TO_PLAYER)

macro eventPlayer.waitForSample():
    eventPlayer.updateLastTimeMS()
    if not eventPlayer.isSampling():
        smallMessage(eventPlayer, "You are not in a cell.")
        return

    if not eventPlayer.isSampleReady():
        smallMessage(eventPlayer, "Sample is not ready yet.")
        return
        
    eventPlayer.CurrentDuration = 0
    chaseOverTime(eventPlayer.CurrentDuration, 100, eventPlayer.Duration, ChaseTimeReeval.NONE)
    progressBarHud(eventPlayer, eventPlayer.CurrentDuration, "Sample in progress...", HudPosition.TOP, 0, Color.BLACK)
    eventPlayer.CurrentDurationElement = getLastCreatedText()

    wait(eventPlayer.Duration)

    destroyProgressBarHud(eventPlayer.CurrentDurationElement)
    eventPlayer.endSample()

