#!mainFile "../LaserSurvival.opy"

globalvar Speed = 10
globalvar LaserAngle = 0

globalvar Lasers = []

macro laser.angle = self[0]
macro laser.length = self[1]
macro laser.multiplier = self[2]
macro laser.endPosition = self[3]
macro laser.entities = self[4]
macro laser.abVector = self[5]
macro laser.abLenSq = self[6]

macro laser(angle, length, multi):
    [angle, length, multi, vect(0, 0, 0), [], vect(0, 0, 0), 0]

macro laser.updatePosition():
    self.endPosition = RING_CENTER.pivot(LaserAngle + self.angle, self.length)
    self.abVector = self.endPosition - RING_CENTER
    self.abLenSq = dotProduct(self.abVector, self.abVector)

macro laser.distance(position):
    position - (RING_CENTER + self.abVector *(min(max(dotProduct(position - RING_CENTER, self.abVector) / self.abLenSq, 0), 1 )))

macro addChaseLaser(angle, length, multiplier=1):
    Lasers.append([laser(angle, length, multiplier)])
    Lasers[len(Lasers) - 1].updatePosition()

    createBeam(getAllPlayers(), Beam.BAD, RING_CENTER, Lasers[evalOnce(len(Lasers) - 1)].endPosition, Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    Lasers[len(Lasers) - 1].entities = []
    Lasers[len(Lasers) - 1].entities.append(getLastCreatedEntity())
    createBeam(getAllPlayers(), Beam.BAD, RING_CENTER.yOffset(2), Lasers[evalOnce(len(Lasers) - 1)].endPosition.yOffset(2), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    Lasers[len(Lasers) - 1].entities.append(getLastCreatedEntity())


rule "Tick Lasers":
    while true:
        wait(0.1)
        for i in range(len(Lasers)):
            Lasers[i].updatePosition()

rule "Chase Laser":
    @SuppressWarnings w_ow2_rule_condition_chase
    @Condition getGameState() == GameState.GAME_IN_PROGRESS
    @Condition LaserAngle == 0
    @Condition Speed > 0
    stopChasingVariable(LaserAngle)
    LaserAngle = 360
    chaseAtRate(LaserAngle, 0, Speed)


rule "Laser Hit":
    @Event eachPlayer
    @Condition getGameState() == GameState.GAME_IN_PROGRESS
    @Condition eventPlayer.isAlive() and eventPlayer.hasSpawned()
    @Condition any([laser.distance(eventPlayer.getPosition()) <= HIT_RADIUS for laser in Lasers])
    smallMessage(eventPlayer, "Laser Hit!")
    