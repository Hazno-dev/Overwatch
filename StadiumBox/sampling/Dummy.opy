#!mainFile "../StadiumBox.opy"

macro eventPlayer.createBots():
    for Iterator in range(len(self.CellEnemyPositions())):
        createDummy(Hero.ASHE, Team.2, -1, self.CellEnemyPositions()[Iterator], directionTowards(self.CellEnemyPositions()[Iterator], self.getPosition()))
        LastEntity = getLastCreatedEntity()
        if (not LastEntity.hasSpawned()):
            waitUntil(LastEntity.hasSpawned())

        LastEntity.setMaxHealth(200)
        LastEntity.setStatusEffect(null, Status.UNKILLABLE, 9999)
        eventPlayer.Bots.append(LastEntity)

macro eventPlayer.destroyBots():
    for Iterator in range(len(self.Bots)):
        destroyDummy(Team.2, self.Bots[Iterator].getSlot())