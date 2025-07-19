#!include "./settings/settings.opy"

#Global variables

globalvar Round 0
globalvar Safety 1
globalvar Alive 2
globalvar LinePos 3
globalvar LineSpeed 4
globalvar LinePosXY1 5
globalvar LinePosXY2 6
globalvar Direct1 8
globalvar Direct2 9
globalvar MatchTime 10
globalvar Traps1 11
globalvar Traps2 12
globalvar Traps3 13
globalvar Trap1pos 14
globalvar Trap2pos 15
globalvar Trap3pos 16
globalvar EffectID 17
globalvar TrapZPos1 18
globalvar TrapZPos2 19
globalvar zlineimpulse 20
globalvar zlineimpulsevert 21
globalvar zline4 22
globalvar zline3 23
globalvar zline2 24
globalvar zline1 25
globalvar TrapZPos3 26
globalvar KillAllEffects 27
globalvar NextRound 28
globalvar GameOver 29
globalvar Game0 30
globalvar Oppositesafety 31
globalvar Vote1 32
globalvar Vote2 33
globalvar Vote3 34
globalvar Vote4 35
globalvar VoteInProgress 36
globalvar VoteTimer 37
globalvar VoteFinal 38
globalvar HighestVoteFinal 39
globalvar RoundInProgress 40
globalvar Walls1 41
globalvar Walls2 42
globalvar Walls3 43
globalvar Walls4 44
globalvar Walls5 45
globalvar GenerateWalls 46
globalvar WallsRandom 47
globalvar RunText 48
globalvar zlineimpulsevert2 49
globalvar TrapXPos1 50
globalvar TrapXPos2 51
globalvar TrapXPos3 52
globalvar DisableRNG 53
globalvar RandomEvent 54
globalvar EventCD 55
globalvar LineSpeedPrev 56
globalvar RandomOrbs 57
globalvar RandomOrbsEvent 58
globalvar CircleTrapAngle 59
globalvar CircleTrapHeight 60


#Player variables

playervar Safe 0
playervar isDeaad 1
playervar AnaHealCD 2
playervar MercySprint 3
playervar SombraEMP 4
playervar MeleeCD 5
playervar MeiAmmo 6
playervar MeiUlt 7
playervar LucioUlt 8
playervar WidowOldPos 9
playervar WidowCD 10
playervar IsPoisoned 11
playervar EffectIDPlayers 12
playervar GenjiCD 13
playervar GenjiUlt 14
playervar AtSafetyy 15
playervar NewHud 16
playervar VoteCD 17
playervar WallEvent 18
playervar hero 20
playervar MercyCease 21
playervar Phasing 22
playervar MoiraUlt 23
playervar MoiraPhase 24


#Subroutine names

subroutine Direc1 0
subroutine Direc2 1
subroutine DeathDirec1 2
subroutine DeathDirec2 3
subroutine RoundSpeed1 4
subroutine RoundSpeed2 5
subroutine ByeEffectsxoxo 6
subroutine RandomOrbs 7
subroutine MoiraFix 8


# Conditional

#!define Impulse1Hori(a,b,c,d) (eventPlayer.getPosition().x >= (a) and eventPlayer.getPosition().x <= (b) and eventPlayer.getPosition().z >= (c).z - 0.5 and eventPlayer.getPosition().z <= (d).z + 0.5 and eventPlayer.getPosition().y <=49)
#!define Impulse1Vert(a,b,c,d) (eventPlayer.getPosition().x >= (a).x - 0.5 and eventPlayer.getPosition().x <= (b).x + 0.5 and eventPlayer.getPosition().z >= (c) and eventPlayer.getPosition().z <= (d) and eventPlayer.getPosition().y <=49)
#!define Impulse1HoriRed(a,b,c,d) (eventPlayer.getPosition().x >= (a) and eventPlayer.getPosition().x <= (b) and eventPlayer.getPosition().z >= (c).z - 0.5 and eventPlayer.getPosition().z <= (d).z + 0.5 and eventPlayer.getPosition().y <=70)


rule "Debug hero 2":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Disabled
    
    eventPlayer.startForcingHero(Hero.ANA)
    #eventPlayer.setUltCharge(100)


rule "Debug":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Disabled
    
    eventPlayer.startForcingHero(Hero.MERCY)
    #eventPlayer.setUltCharge(100)


rule "DEBUG":
    @Event eachPlayer
    @Hero all
    @Disabled
    
    hudHeader(hostPlayer, "{0}".format(hostPlayer.getPosition()), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(hostPlayer, "{0}".format(getServerLoad()), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(hostPlayer, "{0}".format(eventPlayer.MercySprint), HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "DEBUG 2":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Disabled
    
    hostPlayer.teleport(vect(17, 50, 17))
    #eventPlayer.setStatusEffect(null, Status.HACKED, 9999)
    #createDummy(Hero.ANA, Team.ALL, -1, vect(0, 10, 0), vect(0, 0, 0))


# ---------- START --------------


rule "Game Start":
    @Event eachPlayer
    @Hero all
    @Condition isGameInProgress() == true
    @Condition getLivingPlayers(Team.ALL).isDummy() == false
    @Condition Game0 == 0
    @Condition eventPlayer.isDead() == false
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    GenerateWalls = true
    Game0 = 1
    #getAllPlayers().disableRespawn()
    disableGamemodeCompletion()
    eventPlayer.startForcingHero(random.choice(eventPlayer.getAllowedHeroes()))
    eventPlayer.isDeaad = false
    getAllPlayers().disallowButton(Button.MELEE)
    Round = 1
    #createEffect(eventPlayer, Effect.LIGHT_SHAFT, Color.GREEN, Safety, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    #createEffect(eventPlayer, Effect.RING, Color.GREEN, Safety, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    #createInWorldText(eventPlayer, "Reach Here!", Safety + vect(0, 3, 0), 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.GREEN, SpecVisibility.DEFAULT)
    bigMessage(eventPlayer, "Loading")
    getLivingPlayers(Team.ALL).setStatusEffect(null, Status.ROOTED, 7.25)
    wait(3)
    wait(0.25)
    eventPlayer.teleport(vect(17, 50, 17))
    getAllPlayers().disablePlayerCollision()
    bigMessage(eventPlayer, "Race To The Other Side!")
    wait(1)
    smallMessage(eventPlayer, "3")
    wait(1)
    smallMessage(eventPlayer, "2")
    wait(1)
    smallMessage(eventPlayer, "1")
    wait(1)
    smallMessage(eventPlayer, "GO!")
    RandomOrbs()
    getAllPlayers().allowButton(Button.MELEE)
    LineSpeed = 1
    LineSpeedPrev = LineSpeed
    MatchTime = true
    RoundInProgress = true
    GenerateWalls = false


rule "Infinite Match Time":
    
    disableGamemodeCompletion()
    setMatchTime(10000)
    pauseMatchTime()

rule "Disable RNG":

    DisableRNG = createWorkshopSetting(bool, "Disable RNG", "Default Layout Only", false)


rule "Voicelines":
    @Event eachPlayer
    @Hero all
    
    eventPlayer.startModifyingVoicelinePitch(1.2, true)


rule "Player Joined":
    @Event playerJoined
    @Hero all
    #@Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isDummy() == false
    
    eventPlayer.NewHud = "what r u doing in my swamp"
    eventPlayer.disableRespawn()
    getAllPlayers().disablePlayerCollision()
    eventPlayer.enableDeathSpectateAllPlayers()
    wait(1)
    kill(eventPlayer, null)


rule "Disable respawn":
    @Event eachPlayer
    @Hero all
    
    while 0 == 0:
        #eventPlayer.disableRespawn()
        eventPlayer.setRespawnTime(9999)
        eventPlayer.enableDeathSpectateAllPlayers()
        wait(1)


rule "Player Dies while safe":
    @Event playerDied
    @Hero all
    @Condition eventPlayer.Safe == true
    @Condition eventPlayer.AtSafetyy == true
    
    Alive -= 1


rule "Player leaves while safe":
    @Event playerLeft
    @Hero all
    @Condition eventPlayer.Safe == true
    @Condition eventPlayer.isDeaad == false
    @Condition eventPlayer.AtSafetyy == true
    
    Alive -= 1


rule "Emote stun":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isCommunicatingEmote() == true
    
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 1)
    wait(0.25)
    if eventPlayer.Safe == true:
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
        eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)


rule "Random Hero":
    @Event eachPlayer
    @Hero all
    @Disabled
    
    setMatchTime(5)
    wait(0.25)
    eventPlayer.startForcingHero(random.choice(eventPlayer.getAllowedHeroes()))


# -------------- WALLS ---------------


rule "Wall lines":
    @Condition isGameInProgress() == true
    
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 46, 21.2), vect(21.3, 46, -21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 46, 21.2), vect(-21.3, 46, 21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 47, 21.2), vect(21.3, 47, -21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    #createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 47, 21.2), vect(-21.3, 47, 21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(-21.3, 46, 21.2), vect(-21.3, 46, -21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 46, -21.2), vect(-21.3, 46, -21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(-21.3, 47, 21.2), vect(-21.3, 47, -21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    #createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 47, -21.2), vect(-21.3, 47, -21.2), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 47, 21.2), vect(21.3, 46, 21.201), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(-21.3, 47, 21.2), vect(-21.3, 46, 21.201), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(21.3, 47, -21.2), vect(21.3, 46, -21.201), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, vect(-21.3, 47, -21.2), vect(-21.3, 46, -21.201), Color.ORANGE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "Wall 1 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getPosition().x > 21
    
    eventPlayer.applyImpulse(vect(-10, 3, 0), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Wall 2 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getPosition().x < -21
    
    eventPlayer.applyImpulse(vect(10, 3, 0), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Wall 3 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getPosition().z > 21
    
    eventPlayer.applyImpulse(vect(0, 3, -10), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Wall 4 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getPosition().z < -21
    
    eventPlayer.applyImpulse(vect(0, 3, 10), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "RNG Walls":
    @Condition GenerateWalls == true
    @Condition DisableRNG == false

    WallsRandom[1] = random.randint(1,4)

    switch (WallsRandom[1]):
        case 1:
            zline1[1] = vect(21.2, 46, 12.75)
            zline1[2] = vect(-12.75, 46, 12.75)
            zline1[3] = vect(0,-1,0)
            zline1[4] = vect(0,-1,0)
            zline1[5] = vect(-12.75, 46, 12.75)
            zline2[1] = vect(-21.2, 46, 4.25)
            zline2[2] = vect(12.75, 46, 4.25)
            zline2[3] = vect(0,-1,0)
            zline2[4] = vect(0,-1,0)
            zline2[5] = vect(12.75, 46, 4.25)
            zline3[1] = vect(21.2, 46, -4.25)
            zline3[2] = vect(-12.75, 46, -4.25)
            zline3[3] = vect(0,-1,0)
            zline3[4] = vect(0,-1,0)
            zline3[5] = vect(-12.75, 46, -4.25)
            zline4[1] = vect(-21.2, 46, -12.75)
            zline4[2] = vect(12.75, 46, -12.75)
            zline4[3] = vect(0,-1,0)
            zline4[4] = vect(0,-1,0)
            zline4[5] = vect(12.75, 46, -12.75)
            zline4[6] = vect(0,-1,0)
            zline4[7] = vect(0,-1,0)
            break
        case 2:
            zline1[1] = vect(21.2, 46, 12.75)
            zline1[2] = vect(-12.75, 46, 12.75)
            zline1[3] = vect(12.75, 46, 4.25)
            zline1[4] = vect(12.75, 46, -12.75)
            zline1[5] = vect(12.75, 46, -12.75)
            zline2[1] = vect(0,-1,0)
            zline2[2] = vect(0,-1,0)
            zline2[3] = vect(4.25, 46, -21.2)
            zline2[4] = vect(4.25, 46, -4.25)
            zline2[5] = vect(-12.75, 46, 12.75)
            zline3[1] = vect(4.25, 46, -4.25)
            zline3[2] = vect(-12.75, 46, -4.25)
            zline3[3] = vect(0,-1,0)
            zline3[4] = vect(0,-1,0)
            zline3[5] = vect(-12.75, 46, -4.25)
            zline4[1] = vect(-21.2, 46, -12.75)
            zline4[2] = vect(-4.25, 46, -12.75)
            zline4[3] = vect(-21.2, 46, 4.25)
            zline4[4] = vect(12.75, 46, 4.25)
            zline4[5] = vect(-4.25, 46, -12.75)
            zline4[6] = vect(0,-1,0)
            zline4[7] = vect(0,-1,0)
            break
        case 3:
            zline1[1] = vect(12.75, 46, 21.2)
            zline1[2] = vect(12.75, 46, 12.75)
            zline1[3] = vect(4.25, 46, -4.25)
            zline1[4] = vect(-12.75, 46, -4.25)
            zline1[5] = vect(-12.75, 46, -4.25)
            zline2[1] = vect(4.25, 46, -4.25)
            zline2[2] = vect(4.25, 46, 12.75)
            zline2[3] = vect(4.25, 46, 12.75)
            zline2[4] = vect(-12.75, 46, 12.75)
            zline2[5] = vect(-12.75, 46, 12.75)
            zline3[1] = vect(-21.2, 46, 4.25)
            zline3[2] = vect(-4.25, 46, 4.25)
            zline3[3] = vect(-21.2, 46, -12.75)
            zline3[4] = vect(12.75, 46, -12.75)
            zline3[5] = vect(-4.25, 46, 4.25)
            zline4[1] = vect(12.75, 46, -12.75)
            zline4[2] = vect(12.75, 46, -4.25)
            zline4[3] = vect(21.2, 46, 4.25)
            zline4[4] = vect(4.25, 46, 4.25)
            zline4[5] = vect(12.75, 46, -4.25)
            zline4[6] = vect(12.75, 46, 12.75)
            zline4[7] = vect(0,-1,0)
            break
        case 4:
            zline1[1] = vect(12.75, 46, 21.2)
            zline1[2] = vect(12.75, 46, 12.75)
            zline1[3] = vect(4.25, 46, 12.75)
            zline1[4] = vect(4.25, 46, 4.25)
            zline1[5] = vect(12.75, 46, 12.75)
            zline2[1] = vect(-4.25, 46, 21.2)
            zline2[2] = vect(-4.25, 46, 12.75)
            zline2[3] = vect(-12.75, 46, 12.75)
            zline2[4] = vect(-12.75, 46, 4.25)
            zline2[5] = vect(4.25, 46, 12.75)
            zline3[1] = vect(-21.2, 46, 0)
            zline3[2] = vect(12.75, 46, -8.5)
            zline3[3] = vect(12.75, 46, -8.5)
            zline3[4] = vect(12.75, 46, -12.75)
            zline3[5] = vect(12.75, 46, -12.75)
            zline4[1] = vect(-12.75, 46, -21.2)
            zline4[2] = vect(-12.75, 46, -12.75)
            zline4[3] = vect(21.2, 46, 4.25)
            zline4[4] = vect(-12.75, 46, 4.25)
            zline4[5] = vect(-4.25, 46, 12.75)
            zline4[6] = vect(-12.75, 46, 12.75)
            zline4[7] = vect(-12.75, 46, -12.75)
            break

rule "RNG Walls disabled":
    @Condition DisableRNG == true

    WallsRandom[1] = 1

    zline1[1] = vect(21.2, 46, 12.75)
    zline1[2] = vect(-12.75, 46, 12.75)
    zline1[3] = vect(0,-1,0)
    zline1[4] = vect(0,-1,0)
    zline1[5] = vect(-12.75, 46, 12.75)
    zline2[1] = vect(-21.2, 46, 4.25)
    zline2[2] = vect(12.75, 46, 4.25)
    zline2[3] = vect(0,-1,0)
    zline2[4] = vect(0,-1,0)
    zline2[5] = vect(12.75, 46, 4.25)
    zline3[1] = vect(21.2, 46, -4.25)
    zline3[2] = vect(-12.75, 46, -4.25)
    zline3[3] = vect(0,-1,0)
    zline3[4] = vect(0,-1,0)
    zline3[5] = vect(-12.75, 46, -4.25)
    zline4[1] = vect(-21.2, 46, -12.75)
    zline4[2] = vect(12.75, 46, -12.75)
    zline4[3] = vect(0,-1,0)
    zline4[4] = vect(0,-1,0)
    zline4[5] = vect(12.75, 46, -12.75)
    zline4[6] = vect(0,-1,0)
    zline4[7] = vect(0,-1,0)

rule "Z Lines":
    @Condition isGameInProgress() == true
    
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline1[1], zline1[2], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline1[1] + vect(0,1,0), zline1[2] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline1[1] + vect(0,0.5,0), zline1[2] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline1[3], zline1[4], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline1[3] + vect(0,1,0), zline1[4] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline1[3] + vect(0,0.5,0), zline1[4] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline1[5], zline1[5] + vect(0, 2.5, 0.01), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, zline1[5] + vect(0, 3, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline2[1], zline2[2], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline2[1] + vect(0,1,0), zline2[2] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline2[1] + vect(0,0.5,0), zline2[2] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline2[3], zline2[4], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline2[3] + vect(0,1,0), zline2[4] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline2[3] + vect(0,0.5,0), zline2[4] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline2[5], zline2[5] + vect(0, 2.5, 0.01), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, zline2[5] + vect(0, 3, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline3[1], zline3[2], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline3[1] + vect(0,1,0), zline3[2] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline3[1] + vect(0,0.5,0), zline3[2] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline3[3], zline3[4], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline3[3] + vect(0,1,0), zline3[4] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline3[3] + vect(0,0.5,0), zline3[4] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline3[5], zline3[5] + vect(0, 2.5, 0.01), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, zline3[5] + vect(0, 3, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[1], zline4[2], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[1] + vect(0,1,0), zline4[2] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline4[1] + vect(0,0.5,0), zline4[2] + vect(0,0.5,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[3], zline4[4], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[3] + vect(0,1,0), zline4[4] + vect(0,1,0), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, zline4[3] + vect(0,0.5,0), zline4[4] + vect(0,0.5,0), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[5], zline4[5] + vect(0, 2.5, 0.01), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, zline4[5] + vect(0, 3, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[6], zline4[6] + vect(0, 2.5, 0.01), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, zline4[6] + vect(0, 3, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GRAPPLE, zline4[7], zline4[7] + vect(0, 2.5, 0.01), Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, zline4[7] + vect(0, 3, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

rule "Layout 1 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition WallsRandom[1] == 1
    @Condition eventPlayer.AtSafetyy == false
        @Condition RoundInProgress == true

    while WallsRandom[1] == 1:
        if Impulse1Hori(zline1[2].x,zline1[1].x + 2,zline1[2],zline1[1]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline2[1].x - 2,zline2[2].x,zline2[1],zline2[2]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline3[2].x,zline3[1].x + 2,zline3[2],zline3[1]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline4[1].x -2,zline4[2].x,zline4[1],zline4[2]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        wait(0.020)

rule "Layout 2 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition WallsRandom[1] == 2
    @Condition eventPlayer.AtSafetyy == false
    @Condition RoundInProgress == true

    while WallsRandom[1] == 2:
        if Impulse1Hori(zline1[2].x,zline1[1].x + 2,zline1[2],zline1[1]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1HoriRed(zline4[3].x - 2,zline4[4].x,zline4[3],zline4[4]) and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline1[3],zline1[4],zline1[4].z,zline1[3].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline2[3],zline2[4],zline2[3].z - 2,zline2[4].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline3[2].x,zline3[1].x,zline3[1],zline3[2]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline4[1].x,zline4[2].x,zline4[1],zline4[2]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        wait(0.020)

rule "Layout 3 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition WallsRandom[1] == 3
    @Condition eventPlayer.AtSafetyy == false
    @Condition RoundInProgress == true

    while WallsRandom[1] == 3:
        if Impulse1Vert(zline1[1],zline1[2],zline1[2].z,zline1[1].z + 2) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline1[4].x,zline1[3].x,zline1[4],zline1[3]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline2[4].x,zline2[3].x,zline2[4],zline2[3]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline2[1],zline2[2],zline2[1].z,4.25) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert2, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline2[1],zline2[2],4.25,zline2[2].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline3[1].x - 2,zline3[2].x,zline3[1],zline3[2]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Hori(zline3[3].x - 2,zline3[4].x,zline3[3],zline3[4]) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1HoriRed(zline4[4].x - 0.5,zline4[3].x + 2,zline4[3],zline4[4]) and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline4[1],zline4[2],zline4[1].z,zline4[2].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert2, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        wait(0.020)

rule "Layout 4 Impulse":
    @Event eachPlayer
    @Hero all
    @Condition WallsRandom[1] == 4
    @Condition eventPlayer.AtSafetyy == false
    @Condition RoundInProgress == true

    while WallsRandom[1] == 4:
        if Impulse1Vert(zline1[1],zline1[2],zline1[2].z,zline1[1].z + 2) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline1[3],zline1[3],zline1[4].z,zline1[3].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline2[1],zline2[2],zline2[2].z,zline2[1].z + 2) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline2[3],zline2[4],zline2[4].z,zline2[3].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if raycast(zline3[1], zline3[2], eventPlayer, null, true).getPlayerHit() == true or raycast(zline3[1] + vect(0,0.5,0), zline3[2] + vect(0,0.5,0), eventPlayer, null, true).getPlayerHit() == true or raycast(zline3[1] + vect(0,1,0), zline3[2] + vect(0,1,0), eventPlayer, null, true).getPlayerHit() == true and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline3[3],zline3[4],zline3[4].z,zline3[3].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1Vert(zline4[1],zline4[2],zline4[1].z - 2,zline4[2].z) and eventPlayer.Phasing != true and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulsevert, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START
        if Impulse1HoriRed(zline4[4].x,zline4[3].x + 2,zline4[3],zline4[4]) and eventPlayer.MoiraPhase != true:
            eventPlayer.applyImpulse(zlineimpulse, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
            wait(0.1)
            if RULE_CONDITION:
                goto RULE_START     
        wait(0.020)

rule "Global Variable Round":
    Round = 1


# ----------------- ROUNDS --------------------


rule "Even Round":
    @Condition Round % 2 == 0
    
    Direc2()
    #RoundSpeed1()
    #wait(1.25, Wait.ABORT_WHEN_FALSE)
    DeathDirec2()
    Direct2 = true
    Direct1 = false


rule "Odd Round":
    @Condition Round % 2 == 1
    
    Direc1()
    #RoundSpeed2()
    #wait(1.25, Wait.ABORT_WHEN_FALSE)
    DeathDirec1()
    Direct2 = false
    Direct1 = true


def Direc1():
    @Name "Direction 1"
    
    zlineimpulse = vect(0, 1, 2)
    zlineimpulsevert = vect(2, 1, 0)
    zlineimpulsevert2 = vect(-2, 1, 0)
    Safety = vect(-17, 46, -17)
    LinePosXY1 = vect(21, 46, 30)
    LinePosXY2 = vect(-21, 46, 30)
    Oppositesafety = vect(17, 46, 17)


def Direc2():
    @Name "Direction 2"
    
    zlineimpulse = vect(0, 1, -2)
    zlineimpulsevert = vect(-2, 1, 0)
    zlineimpulsevert2 = vect(2, 1, 0)
    Safety = vect(17, 46, 17)
    LinePosXY1 = vect(21, 46, -30)
    LinePosXY2 = vect(-21, 46, -30)
    Oppositesafety = vect(-17, 46, -17)


rule "Safety Register":
    @Event eachPlayer
    @Hero all
    @Condition distance(eventPlayer, Safety) <= 3.8
    @Condition eventPlayer.isDummy() == false
    @Condition GameOver == false
    
    eventPlayer.Safe = true
    Game0 = 1


rule "Safety":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.Safe == true
    @Condition eventPlayer.isDeaad == false
    @Condition GameOver == false
    
    eventPlayer.teleport(Safety)
    eventPlayer.setInvisibility(Invis.ALL)
    heal(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.disallowButton(Button.MELEE)
    LineSpeed += 0.05
    Alive += 1
    eventPlayer.addToScore(1)
    eventPlayer.AtSafetyy = true


rule "Round End/Restart":
    @Condition Alive == (len([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]))
    @Condition Alive > 1
    
    bigMessage(getAllPlayers(), "Round {0} over!".format(Round))
    RoundInProgress = false
    stopChasingVariable(LinePos)
    KillAllEffects = true
    ByeEffectsxoxo()
    wait(6)
    getAllPlayers().setInvisibility(Invis.NONE)
    NextRound = true
    Round += 1
    Alive = 0
    LineSpeed = LineSpeedPrev
    LineSpeed += 0.1
    LineSpeedPrev = LineSpeed
    wait(0.1)
    getLivingPlayers(Team.ALL).Safe = false
    wait(1)
    RandomOrbs()
    getAllPlayers().AtSafetyy = false
    ([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]).teleport(Oppositesafety)
    getLivingPlayers(Team.ALL).clearStatusEffect(Status.INVINCIBLE)
    getLivingPlayers(Team.ALL).clearStatusEffect(Status.ROOTED)
    getLivingPlayers(Team.ALL).clearStatusEffect(Status.PHASED_OUT)
    getAllPlayers().allowButton(Button.MELEE)
    RoundInProgress = true
    #bigMessage(getAllPlayers(), "Dead Players are voting")
    VoteInProgress = true
    #VoteTimer = 6
    #chase(VoteTimer, 0, duration=6, ChaseReeval.DESTINATION_AND_DURATION)


rule "Player Died":
    @Event playerDied
    @Hero all
    
    #eventPlayer.startForcingHero(Hero.ZENYATTA)
    eventPlayer.teleport(vect(0, 0, 0))
    eventPlayer.disableRespawn()
    eventPlayer.enableDeathSpectateAllPlayers()
    wait(0.25)
    eventPlayer.isDeaad = true
    eventPlayer.Safe = false
    eventPlayer.addToScore(1)


rule "Game Restart":
    @Event eachPlayer
    @Hero all
    @Condition Alive == 0
    @Condition isGameInProgress() == true
    @Condition len([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]) == 0
    #@Condition all([player.isDummy() == false for player in getLivingPlayers(Team.ALL)]) == 0
    
    VoteInProgress = false
    RoundInProgress = false
    wait(0.25)
    GameOver = true
    bigMessage(eventPlayer, "Game Over!")
    getAllPlayers().stopForcingCurrentHero()
    ByeEffectsxoxo()
    wait(2)
    stopChasingVariable(LinePos)
    eventPlayer.GenjiUlt = 0
    eventPlayer.MoiraUlt = 0
    eventPlayer.LucioUlt = 0
    eventPlayer.MeiUlt = 0
    eventPlayer.SombraEMP = 0
    GenerateWalls = true
    LinePos = 10
    LineSpeed = 1
    LineSpeedPrev = LineSpeed
    Round = 1
    getAllPlayers().AtSafetyy = false
    getAllPlayers().Safe = true
    getAllPlayers().respawn()
    getAllPlayers().setInvisibility(Invis.NONE)
    eventPlayer.startForcingHero(random.choice(eventPlayer.getAllowedHeroes()))
    getAllPlayers().disallowButton(Button.MELEE)
    getAllPlayers().isDeaad = false
    bigMessage(eventPlayer, "Loading")
    wait(3)
    GenerateWalls = false
    getLivingPlayers(Team.ALL).setStatusEffect(null, Status.ROOTED, 4.25)
    wait(0.25)
    getAllPlayers().teleport(vect(17, 50, 17))
    getAllPlayers().setMoveSpeed(100)
    bigMessage(eventPlayer, "Race To The Other Side!")
    #destroyAllDummies()
    wait(1)
    smallMessage(eventPlayer, "3")
    wait(1)
    smallMessage(eventPlayer, "2")
    wait(1)
    smallMessage(eventPlayer, "1")
    wait(1)
    smallMessage(eventPlayer, "GO!")
    RandomOrbs()
    DeathDirec1()
    getAllPlayers().Safe = false
    GameOver = false
    getLivingPlayers(Team.ALL).clearStatusEffect(Status.INVINCIBLE)
    getLivingPlayers(Team.ALL).clearStatusEffect(Status.ROOTED)
    getLivingPlayers(Team.ALL).clearStatusEffect(Status.PHASED_OUT)
    getAllPlayers().allowButton(Button.MELEE)
    RoundInProgress = true


rule "Player Win":
    @Condition len([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]) == 1
    @Condition Alive == 1
    
    GameOver = true
    getLivingPlayers(Team.ALL).addToScore(5)
    bigMessage(getAllPlayers(), "{0} Wins!".format([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]))
    #playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, getLivingPlayers(Team.ALL), 3)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.GREEN, [player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false], 3)
    RoundInProgress = false
    wait(3)
    getAllPlayers().AtSafetyy = false
    kill(getLivingPlayers(Team.ALL), null)
    getLivingPlayers(Team.ALL).isDeaad = true
    Alive = 0
    getLivingPlayers(Team.ALL).Safe = false
    #LinePos = 10


# ------------------ KILL LINE ----------------------


rule "Lines":
    RunText = "RUN"
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 0, LinePos) - vect(1, 1, 0), LinePosXY1 + vect(0.0001, 9, LinePos) - vect(1, 0, 0), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY2 + vect(0, 0, LinePos) + vect(1, 0, 0) - vect(0, 1, 0), LinePosXY2 + vect(0.0001, 9, LinePos) + vect(1, 0, 0), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 0, LinePos), LinePosXY2 + vect(0, 0, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 1, LinePos), LinePosXY2 + vect(0, 1, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 2, LinePos), LinePosXY2 + vect(0, 2, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 3, LinePos), LinePosXY2 + vect(0, 3, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 4, LinePos), LinePosXY2 + vect(0, 4, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 5, LinePos), LinePosXY2 + vect(0, 5, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 6, LinePos), LinePosXY2 + vect(0, 6, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 7, LinePos), LinePosXY2 + vect(0, 7, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.BAD, LinePosXY1 + vect(0, 8, LinePos), LinePosXY2 + vect(0, 8, LinePos), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "{0}".format(RunText), LinePosXY1 + vect(-21, 3, LinePos), 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.GREEN, Safety, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, Safety, 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "Reach Here!", Safety + vect(0, 3, 0), 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.GREEN, SpecVisibility.DEFAULT)


def DeathDirec1():
    @Name "Death Direc 1"
    
    LinePos = 10
    chase(LinePos, -60, rate=LineSpeed, ChaseReeval.DESTINATION_AND_RATE)


def DeathDirec2():
    @Name "Death Direc 2"
    
    LinePos = -10
    chase(LinePos, 60, rate=LineSpeed, ChaseReeval.DESTINATION_AND_RATE)


def RoundSpeed1():
    @Name "RoundEndSpeed1"
    @Disabled
    
    stopChasingVariable(LinePos)
    wait()
    chase(LinePos, vect(0, 30, 0), duration=1, ChaseReeval.DESTINATION_AND_DURATION)


def RoundSpeed2():
    @Name "RoundEndSpeed2"
    @Disabled
    
    stopChasingVariable(LinePos)
    wait()
    chase(LinePos, vect(0, -30, 0), duration=1, ChaseReeval.DESTINATION_AND_DURATION)


rule "Kill Wall Odd":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getPosition().z > LinePos + 30
    @Condition Direct1 == true
    @Condition eventPlayer.Safe == false
    
    kill(eventPlayer, null)


rule "Kill Wall Even":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getPosition().z < LinePos + -30
    @Condition Direct2 == true
    @Condition eventPlayer.Safe == false
    
    kill(eventPlayer, null)


# ----------------- TRAPS -------------------


rule "Random Select traps Round 2":
    @Condition Round == 2
    
    wait(1.001)
    Traps2 = random.randint(1, 3)


rule "Random Select traps Round 3":
    @Condition Round == 3
    
    wait(1.001)
    Traps2 = random.randint(1, 3)
    wait(1)
    Traps3 = random.randint(1, 5)


rule "Random Select traps Round 4+":
    @Condition Round > 3
    @Condition NextRound == true
    
    wait(1.001)
    Traps1 = random.randint(1, 5)
    wait(1)
    Traps2 = random.randint(1, 3)
    wait(1)
    Traps3 = random.randint(1, 5)
    NextRound = false
    wait()


def ByeEffectsxoxo():
    @Name "Delete effects + Dummy"
    
    Traps1 = 0
    Traps2 = 0
    Traps3 = 0
    stopChasingVariable(TrapZPos1)
    stopChasingVariable(TrapZPos2)
    stopChasingVariable(TrapZPos3)
    stopChasingVariable(TrapXPos1)
    stopChasingVariable(TrapXPos2)
    stopChasingVariable(TrapXPos3)
    stopChasingVariable(Trap1pos)
    stopChasingVariable(Trap2pos)
    stopChasingVariable(Trap3pos)
    Trap1pos = 0
    Trap2pos = 0
    Trap3pos = 0
    TrapZPos1 = 0
    TrapZPos2 = 0
    TrapZPos3 = 0
    TrapXPos1 = 0
    TrapXPos2 = 0    
    TrapXPos3 = 0
    destroyAllDummies()
    destroyEffect(EffectID[1])
    destroyEffect(EffectID[2])
    destroyEffect(EffectID[3])
    destroyEffect(EffectID[4])
    destroyEffect(EffectID[5])
    destroyEffect(EffectID[6])
    destroyEffect(EffectID[7])
    destroyEffect(EffectID[8])
    destroyEffect(EffectID[9])
    destroyEffect(EffectID[10])
    destroyEffect(EffectID[11])
    destroyEffect(EffectID[12])
    destroyEffect(EffectID[13])
    destroyEffect(EffectID[14])
    destroyEffect(EffectID[15])
    destroyEffect(EffectID[20])
    destroyEffect(EffectID[21])
    destroyEffect(EffectID[22])
    destroyEffect(EffectID[23])
    destroyEffect(EffectID[24])
    destroyEffect(EffectID[25])
    EffectID = 0
    wait(0.25)
    #KillAllEffects = false
    #Trap2pos = 0
    #Trap2pos = 0
    #Trap3pos = 0
    #TrapZPos2 = 0
    #TrapZPos2 = 0
    #TrapZPos3 = 0


rule "Big Balls Of Death 1":
    @Condition Traps1 == 1
    
    if WallsRandom[1] == 1:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[1] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[2] = getLastCreatedEntity()
        while Traps1 == 1 and WallsRandom[1] == 1:
            chase(Trap1pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap1pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap1pos = 47
        TrapXPos1 = 17
        TrapZPos1 = -4.25
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[1] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[2] = getLastCreatedEntity()
        while Traps1 == 1 and WallsRandom[1] == 2:
            chase(Trap1pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap1pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 4.25
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[1] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[2] = getLastCreatedEntity()
        while Traps1 == 1 and WallsRandom[1] == 3:
            chase(Trap1pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap1pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap1pos = 47
        TrapXPos1 = -17
        TrapZPos1 = 8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[1] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[2] = getLastCreatedEntity()
        while Traps1 == 1 and WallsRandom[1] == 4:
            chase(Trap1pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap1pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)


rule "Big Balls Of Death Damage 1":
    @Event eachPlayer
    @Hero all
    @Condition Traps1 == 1
    @Condition distance(eventPlayer, vect(TrapXPos1, Trap1pos, TrapZPos1)) <= 4
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4)
    if RULE_CONDITION:
        goto RULE_START


rule "Tracer 1":
    @Condition Traps1 == 2
    
    if WallsRandom[1] == 1:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 8.5
        #wait(1)
        createDummy(Hero.TRACER, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), vect(0, 0, 0))
        EffectID[3] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[3].startForcingButton(Button.PRIMARY_FIRE)
        while Traps1 == 2 and WallsRandom[1] == 1:
            EffectID[3].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].setUltCharge(100)
            EffectID[3].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            
    if WallsRandom[1] == 2:
        Trap1pos = 47
        TrapXPos1 = 17
        TrapZPos1 = -4.25
        #wait(1)
        createDummy(Hero.TRACER, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), vect(0, 0, 0))
        EffectID[3] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[3].startForcingButton(Button.PRIMARY_FIRE)
        while Traps1 == 2 and WallsRandom[1] == 2:
            EffectID[3].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].setUltCharge(100)
            EffectID[3].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 4.25
        #wait(1)
        createDummy(Hero.TRACER, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), vect(0, 0, 0))
        EffectID[3] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[3].startForcingButton(Button.PRIMARY_FIRE)
        while Traps1 == 2 and WallsRandom[1] == 3:
            EffectID[3].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].setUltCharge(100)
            EffectID[3].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap1pos = 47
        TrapXPos1 = -17
        TrapZPos1 = 8.5
        #wait(1)
        createDummy(Hero.TRACER, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), vect(0, 0, 0))
        EffectID[3] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[3].startForcingButton(Button.PRIMARY_FIRE)
        while Traps1 == 2 and WallsRandom[1] == 4:
            EffectID[3].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].setUltCharge(100)
            EffectID[3].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[3].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[3].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)


rule "Tracer Damage":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.isDummy() == Hero.TRACER
    @Condition victim.isDummy() == false
    
    victim.setStatusEffect(null, Status.STUNNED, 1)
    wait(1, Wait.ABORT_WHEN_FALSE)


rule "Cassidy Bang 1":
    @Condition Traps1 == 3

    if WallsRandom[1] == 1:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), angleToDirection(0, 0))
        EffectID[4] = getLastCreatedEntity()
        EffectID[4].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[4].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps1 == 3 and WallsRandom[1] == 1:
            EffectID[4].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap1pos = 47
        TrapXPos1 = 17
        TrapZPos1 = -4.25
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), angleToDirection(0, 0))
        EffectID[4] = getLastCreatedEntity()
        EffectID[4].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[4].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps1 == 3 and WallsRandom[1] == 2:
            EffectID[4].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 4.25
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), angleToDirection(0, 0))
        EffectID[4] = getLastCreatedEntity()
        EffectID[4].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[4].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps1 == 3 and WallsRandom[1] == 3:
            EffectID[4].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap1pos = 47
        TrapXPos1 = -17
        TrapZPos1 = 8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 10, vect(TrapXPos1, Trap1pos, TrapZPos1), angleToDirection(0, 0))
        EffectID[4] = getLastCreatedEntity()
        EffectID[4].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[4].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps1 == 3 and WallsRandom[1] == 4:
            EffectID[4].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)


rule "Red Ball Horizontal 1":
    @Condition Traps1 == 4

    if WallsRandom[1] == 1:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 8
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[5] = getLastCreatedEntity()
        while Traps1 == 4 and WallsRandom[1] == 1:
            chase(TrapZPos1, 4, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos1, 12, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap1pos = 47
        TrapXPos1 = 17
        TrapZPos1 = -4.25
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[5] = getLastCreatedEntity()
        while Traps1 == 4 and WallsRandom[1] == 2:
            chase(TrapXPos1, 21, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos1, 12.75, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap1pos = 47
        TrapXPos1 = 0
        TrapZPos1 = 4.25
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[5] = getLastCreatedEntity()
        while Traps1 == 4 and WallsRandom[1] == 3:
            chase(TrapXPos1, 4.25, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos1, -4.25, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap1pos = 47
        TrapXPos1 = -17
        TrapZPos1 = 8
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, TrapZPos1), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[5] = getLastCreatedEntity()
        while Traps1 == 4 and WallsRandom[1] == 4:
            chase(TrapXPos1, -12.75, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos1, -21, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

rule "Red Ball Horizontal Damage 1":
    @Event eachPlayer
    @Hero all
    @Condition Traps1 == 4
    @Condition distance(eventPlayer, vect(TrapXPos1, Trap1pos, TrapZPos1)) <= 2.1
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4)
    if RULE_CONDITION:
        goto RULE_START


rule "Growing Ball 1":
    @Condition Traps1 == 5

    if WallsRandom[1] == 1:
        Trap1pos = 48
        TrapXPos1 = 0
        TrapZPos1 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, 8.5), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[20] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, 8.5), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[21] = getLastCreatedEntity()
        while Traps1 == 5 and WallsRandom[1] == 1:
            chase(TrapZPos1, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos1, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)
        
    if WallsRandom[1] == 2:
        Trap1pos = 48
        TrapXPos1 = 17
        TrapZPos1 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, -4.25), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[20] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, -4.25), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[21] = getLastCreatedEntity()
        while Traps1 == 5 and WallsRandom[1] == 2:
            chase(TrapZPos1, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos1, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap1pos = 48
        TrapXPos1 = 0
        TrapZPos1 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, 4.25), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[20] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, 4.25), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[21] = getLastCreatedEntity()
        while Traps1 == 5 and WallsRandom[1] == 3:
            chase(TrapZPos1, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos1, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap1pos = 48
        TrapXPos1 = -17
        TrapZPos1 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos1, Trap1pos, 8.5), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[20] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos1, Trap1pos, 8.5), TrapZPos1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[21] = getLastCreatedEntity()
        while Traps1 == 5 and WallsRandom[1] == 4:
            chase(TrapZPos1, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos1, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

rule "Growing Ball Damage 1":
    @Event eachPlayer
    @Hero all
    @Condition Traps1 == 5
    @Condition WallsRandom[1] == 1
    @Condition distance(eventPlayer, vect(TrapXPos1, Trap1pos, 8.5)) <= TrapZPos1 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Growing Ball Damage 1 2":
    @Event eachPlayer
    @Hero all
    @Condition Traps1 == 5
    @Condition WallsRandom[1] == 2
    @Condition distance(eventPlayer, vect(TrapXPos1, Trap1pos, -4.25)) <= TrapZPos1 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Growing Ball Damage 1 3":
    @Event eachPlayer
    @Hero all
    @Condition Traps1 == 5
    @Condition WallsRandom[1] == 3
    @Condition distance(eventPlayer, vect(TrapXPos1, Trap1pos, 4.25)) <= TrapZPos1 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Growing Ball Damage 1 4":
    @Event eachPlayer
    @Hero all
    @Condition Traps1 == 5
    @Condition WallsRandom[1] == 4
    @Condition distance(eventPlayer, vect(TrapXPos1, Trap1pos, 8.5)) <= TrapZPos1 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Big Balls Of Death 2":
    @Condition Traps2 == 1

    if WallsRandom[1] == 1:
        Trap2pos = 47
        TrapXPos2 = 0
        TrapZPos2 = 0
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[6] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[7] = getLastCreatedEntity()
        while Traps2 == 1 and WallsRandom[1] == 1:
            chase(Trap2pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap2pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap2pos = 47
        TrapXPos2 = 0
        TrapZPos2 = 8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[6] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[7] = getLastCreatedEntity()
        while Traps2 == 1 and WallsRandom[1] == 2:
            chase(Trap2pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap2pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap2pos = 47
        TrapXPos2 = 17
        TrapZPos2 = -8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[6] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[7] = getLastCreatedEntity()
        while Traps2 == 1 and WallsRandom[1] == 3:
            chase(Trap2pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap2pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap2pos = 47
        TrapXPos2 = 17
        TrapZPos2 = -8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[6] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[7] = getLastCreatedEntity()
        while Traps2 == 1 and WallsRandom[1] == 4:
            chase(Trap2pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap2pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)


rule "Big Balls Of Death Damage 2":
    @Event eachPlayer
    @Hero all
    @Condition Traps2 == 1
    @Condition distance(eventPlayer, vect(TrapXPos2, Trap2pos, TrapZPos2)) <= 4
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Growing Ball 2":
    @Condition Traps2 == 3

    if WallsRandom[1] == 1:
        Trap2pos = 48
        TrapXPos2 = 0
        TrapZPos2 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, 0), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[22] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, 0), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[23] = getLastCreatedEntity()
        while Traps2 == 3 and WallsRandom[1] == 1:
            chase(TrapZPos2, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos2, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)
        
    if WallsRandom[1] == 2:
        Trap2pos = 48
        TrapXPos2 = 0
        TrapZPos2 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, 8.5), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[22] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, 8.5), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[23] = getLastCreatedEntity()
        while Traps2 == 3 and WallsRandom[1] == 2:
            chase(TrapZPos2, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos2, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap2pos = 48
        TrapXPos2 = 17
        TrapZPos2 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, -8.5), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[22] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, -8.5), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[23] = getLastCreatedEntity()
        while Traps2 == 3 and WallsRandom[1] == 3:
            chase(TrapZPos2, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos2, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap2pos = 48
        TrapXPos2 = 17
        TrapZPos2 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, -8.5), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[22] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos2, Trap2pos, -8.5), TrapZPos2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[23] = getLastCreatedEntity()
        while Traps2 == 3 and WallsRandom[1] == 4:
            chase(TrapZPos2, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos2, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)


rule "Growing Ball Damage 2":
    @Event eachPlayer
    @Hero all
    @Condition Traps2 == 3
    @Condition WallsRandom[1] == 1
    @Condition distance(eventPlayer, vect(TrapXPos2, Trap2pos, 0)) <= TrapZPos2 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Growing Ball Damage 2 2":
    @Event eachPlayer
    @Hero all
    @Condition Traps2 == 3
    @Condition WallsRandom[1] == 2
    @Condition distance(eventPlayer, vect(TrapXPos2, Trap2pos, 8.5)) <= TrapZPos2 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Growing Ball Damage 2 3":
    @Event eachPlayer
    @Hero all
    @Condition Traps2 == 3
    @Condition WallsRandom[1] == 3
    @Condition distance(eventPlayer, vect(TrapXPos2, Trap2pos, -8.5)) <= TrapZPos2 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Growing Ball Damage 2 4":
    @Event eachPlayer
    @Hero all
    @Condition Traps2 == 3
    @Condition WallsRandom[1] == 4
    @Condition distance(eventPlayer, vect(TrapXPos2, Trap2pos, -8.5)) <= TrapZPos2 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Red Ball Horizontal 2":
    @Condition Traps2 == 2

    if WallsRandom[1] == 1:
        Trap2pos = 47
        TrapXPos2 = 0
        TrapZPos2 = 0
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[8] = getLastCreatedEntity()
        while Traps2 == 2 and WallsRandom[1] == 1:
            chase(TrapZPos2, 4, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos2, -4, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap2pos = 47
        TrapXPos2 = 0
        TrapZPos2 = 8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[8] = getLastCreatedEntity()
        while Traps2 == 2 and WallsRandom[1] == 2:
            chase(TrapZPos2, 4.25, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos2, 12.75, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap2pos = 47
        TrapXPos2 = 17
        TrapZPos2 = -8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[8] = getLastCreatedEntity()
        while Traps2 == 2 and WallsRandom[1] == 3:
            chase(TrapXPos2, 12.75, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos2, 21, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap2pos = 47
        TrapXPos2 = 17
        TrapZPos2 = -8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos2, Trap2pos, TrapZPos2), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[8] = getLastCreatedEntity()
        while Traps2 == 2 and WallsRandom[1] == 4:
            chase(TrapXPos2, 12.75, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos2, 21, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)


rule "Red Ball Horizontal Damage 2":
    @Event eachPlayer
    @Hero all
    @Condition Traps2 == 2
    @Condition distance(eventPlayer, vect(TrapXPos2, Trap2pos, TrapZPos2)) <= 2.1
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4)
    if RULE_CONDITION:
        goto RULE_START


rule "Big Balls Of Death 3":
    @Condition Traps3 == 1

    if WallsRandom[1] == 1:
        Trap3pos = 47
        TrapXPos3 = 0
        TrapZPos3 = -8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[9] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[10] = getLastCreatedEntity()
        while Traps3 == 1 and WallsRandom[1] == 1:
            chase(Trap3pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap3pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap3pos = 47
        TrapXPos3 = -17
        TrapZPos3 = -4.25
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[9] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[10] = getLastCreatedEntity()
        while Traps3 == 1 and WallsRandom[1] == 2:
            chase(Trap3pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap3pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = -8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[9] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[10] = getLastCreatedEntity()
        while Traps3 == 1 and WallsRandom[1] == 3:
            chase(Trap3pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap3pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = 8.5
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3.8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[9] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[10] = getLastCreatedEntity()
        while Traps3 == 1 and WallsRandom[1] == 4:
            chase(Trap3pos, 55, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)
            chase(Trap3pos, 47, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2.5, Wait.ABORT_WHEN_FALSE)


rule "Big Balls Of Death Damage 3":
    @Event eachPlayer
    @Hero all
    @Condition Traps3 == 1
    @Condition distance(eventPlayer, vect(TrapXPos3, Trap3pos, TrapZPos3)) <= 4
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Tracer 3":
    @Condition Traps3 == 2
    
    if WallsRandom[1] == 1:
        Trap3pos = 47
        TrapXPos3 = 0
        TrapZPos3 = -8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.TRACER, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), vect(0, 0, 0))
        EffectID[11] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[11].startForcingButton(Button.PRIMARY_FIRE)
        while Traps3 == 2 and WallsRandom[1] == 1:
            EffectID[11].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].setUltCharge(100)
            EffectID[11].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            
    if WallsRandom[1] == 2:
        Trap3pos = 47
        TrapXPos3 = -17
        TrapZPos3 = -4.25
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.TRACER, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), vect(0, 0, 0))
        EffectID[11] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[11].startForcingButton(Button.PRIMARY_FIRE)
        while Traps3 == 2 and WallsRandom[1] == 2:
            EffectID[11].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].setUltCharge(100)
            EffectID[11].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = -8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.TRACER, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), vect(0, 0, 0))
        EffectID[11] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[11].startForcingButton(Button.PRIMARY_FIRE)
        while Traps3 == 2 and WallsRandom[1] == 3:
            EffectID[11].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].setUltCharge(100)
            EffectID[11].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = 8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.TRACER, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), vect(0, 0, 0))
        EffectID[11] = getLastCreatedEntity()
        #EffectID[3].setStatusEffect(null, Status.PHASED_OUT, 9999)
        EffectID[11].startForcingButton(Button.PRIMARY_FIRE)
        while Traps3 == 2 and WallsRandom[1] == 4:
            EffectID[11].startFacing(angleToDirection(0, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].setUltCharge(100)
            EffectID[11].setUltEnabled(true)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(90, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            EffectID[11].forceButtonPress(Button.ULTIMATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(180, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)
            EffectID[11].startFacing(angleToDirection(270, 18), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            wait(0.5, Wait.ABORT_WHEN_FALSE)


rule "Cassidy Bang 3":
    @Condition Traps3 == 3

    if WallsRandom[1] == 1:
        Trap3pos = 47
        TrapXPos3 = 0
        TrapZPos3 = -8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), angleToDirection(0, 0))
        EffectID[12] = getLastCreatedEntity()
        EffectID[12].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[12].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps3 == 3 and WallsRandom[1] == 1:
            EffectID[12].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap3pos = 47
        TrapXPos3 = -17
        TrapZPos3 = -4.25
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), angleToDirection(0, 0))
        EffectID[12] = getLastCreatedEntity()
        EffectID[12].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[12].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps3 == 3 and WallsRandom[1] == 2:
            EffectID[12].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = -8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), angleToDirection(0, 0))
        EffectID[12] = getLastCreatedEntity()
        EffectID[12].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[12].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps3 == 3 and WallsRandom[1] == 3:
            EffectID[12].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = 8.5
        #wait(1, Wait.ABORT_WHEN_FALSE)
        createDummy(Hero.CASSIDY, Team.ALL, 11, vect(TrapXPos3, Trap3pos, TrapZPos3), angleToDirection(0, 0))
        EffectID[12] = getLastCreatedEntity()
        EffectID[12].startFacing(angleToDirection(0, 90), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        #EffectID[12].setStatusEffect(null, Status.PHASED_OUT, 9999)
        while Traps3 == 3 and WallsRandom[1] == 4:
            EffectID[12].forceButtonPress(Button.ABILITY_2)
            wait(1.5, Wait.ABORT_WHEN_FALSE)


rule "Red Ball Horizontal 3":
    @Condition Traps3 == 4
    
    if WallsRandom[1] == 1:
        Trap3pos = 47
        TrapXPos3 = 0
        TrapZPos3 = -8
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[13] = getLastCreatedEntity()
        while Traps3 == 4 and WallsRandom[1] == 1:
            chase(TrapZPos3, -12, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos3, -4, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
    
    if WallsRandom[1] == 2:
        Trap3pos = 47
        TrapXPos3 = -17
        TrapZPos3 = -4.25
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[13] = getLastCreatedEntity()
        while Traps3 == 4 and WallsRandom[1] == 2:
            chase(TrapXPos3, -21, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos3, -12, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap3pos = 47
        TrapXPos3 = 0
        TrapZPos3 = -8
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[13] = getLastCreatedEntity()
        while Traps3 == 4 and WallsRandom[1] == 3:
            chase(TrapZPos3, -12, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos3, -4, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap3pos = 47
        TrapXPos3 = -4.25
        TrapZPos3 = 12.75
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, TrapZPos3), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[13] = getLastCreatedEntity()
        while Traps3 == 4 and WallsRandom[1] == 4:
            chase(TrapXPos3, 4.25, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)
            chase(TrapXPos3, -12.75, duration=1, ChaseReeval.DESTINATION_AND_DURATION)
            wait(1, Wait.ABORT_WHEN_FALSE)


rule "Red Ball Horizontal Damage 3":
    @Event eachPlayer
    @Hero all
    @Condition Traps3 == 4
    @Condition distance(eventPlayer, vect(TrapXPos3, Trap3pos, TrapZPos3)) <= 2.1
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4)
    if RULE_CONDITION:
        goto RULE_START


rule "Growing Ball 3":
    @Condition Traps3 == 5

    if WallsRandom[1] == 1:
        Trap3pos = 48
        TrapXPos3 = 0
        TrapZPos3 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, -8.5), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[24] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, -8.5), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[25] = getLastCreatedEntity()
        while Traps3 == 5 and WallsRandom[1] == 1:
            chase(TrapZPos3, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos3, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)
        
    if WallsRandom[1] == 2:
        Trap3pos = 48
        TrapXPos3 = -17
        TrapZPos3 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, -4.25), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[24] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, -4.25), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[25] = getLastCreatedEntity()
        while Traps3 == 5 and WallsRandom[1] == 2:
            chase(TrapZPos3, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos3, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 3:
        Trap3pos = 48
        TrapXPos3 = 0
        TrapZPos3 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, -8.5), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[24] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, -8.5), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[25] = getLastCreatedEntity()
        while Traps3 == 5 and WallsRandom[1] == 3:
            chase(TrapZPos3, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos3, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

    if WallsRandom[1] == 4:
        Trap3pos = 48
        TrapXPos3 = -4.25
        TrapZPos3 = 4.2
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, vect(TrapXPos3, Trap3pos, 8.5), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[24] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ORB, Color.RED, vect(TrapXPos3, Trap3pos, 8.5), TrapZPos3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        EffectID[25] = getLastCreatedEntity()
        while Traps3 == 5 and WallsRandom[1] == 4:
            chase(TrapZPos3, 0, rate=3, ChaseReeval.DESTINATION_AND_RATE)
            wait(2, Wait.ABORT_WHEN_FALSE)
            chase(TrapZPos3, 4.2, rate=5, ChaseReeval.DESTINATION_AND_RATE)
            wait(1.5, Wait.ABORT_WHEN_FALSE)

rule "Growing Ball Damage 3":
    @Event eachPlayer
    @Hero all
    @Condition Traps3 == 5
    @Condition WallsRandom[1] == 1
    @Condition distance(eventPlayer, vect(TrapXPos3, Trap3pos, -8.5)) <= TrapZPos3 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Growing Ball Damage 3 2":
    @Event eachPlayer
    @Hero all
    @Condition Traps3 == 5
    @Condition WallsRandom[1] == 2
    @Condition distance(eventPlayer, vect(TrapXPos3, Trap3pos, -4.25)) <= TrapZPos3 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Growing Ball Damage 3 3":
    @Event eachPlayer
    @Hero all
    @Condition Traps3 == 5
    @Condition WallsRandom[1] == 3
    @Condition distance(eventPlayer, vect(TrapXPos3, Trap3pos, -8.5)) <= TrapZPos3 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START

rule "Growing Ball Damage 3 4":
    @Event eachPlayer
    @Hero all
    @Condition Traps3 == 5
    @Condition WallsRandom[1] == 4
    @Condition distance(eventPlayer, vect(TrapXPos3, Trap3pos, 12.75)) <= TrapZPos3 + 0.2
    
    damage(eventPlayer, null, 50)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    wait(4, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


# ----------------------------- HEROES ------------------------------


rule "Melee":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.isDummy() == false
    @Condition attacker.isMeleeing() == true
    @Condition attacker.getCurrentHero() != Hero.MOIRA
    @Condition eventAbility == Button.MELEE
    
    victim.applyImpulse(attacker.getFacingDirection(), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.02)
    victim.setStatusEffect(null, Status.KNOCKED_DOWN, 0.5)


rule "Ana Sleep":
    @Event playerTookDamage
    @Hero all
    @Condition eventAbility == Button.ABILITY_1
    @Condition attacker.getCurrentHero() == Hero.ANA
    #@Condition victim.hasStatusEffect(Status.ASLEEP) == true
    
    wait(2)
    damage(victim, null, 0.001)
    victim.setAimSpeed(300)
    wait(2)
    victim.setAimSpeed(100)


rule "Ana Heal":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.ANA
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.AnaHealCD == 0
    
    eventPlayer.AnaHealCD = 10
    heal(eventPlayer, null, 50)
    eventPlayer.setMoveSpeed(125)
    chase(eventPlayer.AnaHealCD, 0, duration=10, ChaseReeval.DESTINATION_AND_DURATION)
    wait(2)
    eventPlayer.setMoveSpeed(100)


rule "Ashe Mine":
    @Event playerTookDamage
    @Hero all
    @Condition victim.hasStatusEffect(Status.BURNING) == true
    #@Condition attacker == Hero.ASHE
    
    victim.setMoveSpeed(60)
    wait(5)
    victim.setMoveSpeed(100)


rule "Mercy Sprint":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MercySprint > 0
    @Condition eventPlayer.getCurrentHero() == Hero.MERCY
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition eventPlayer.IsPoisoned != true
    
    stopChasingVariable(eventPlayer.MercySprint)
    eventPlayer.setMoveSpeed(150)
    chase(eventPlayer.MercySprint, 0, rate=15, ChaseReeval.DESTINATION_AND_RATE)


rule "Mercy Not Sprint":
    @Event eachPlayer
    @Hero all
    #@Condition eventPlayer.MercySprint > 0
    @Condition eventPlayer.getCurrentHero() == Hero.MERCY
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == false
    
    stopChasingVariable(eventPlayer.MercySprint)
    chase(eventPlayer.MercySprint, 50, rate=2, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.setMoveSpeed(100)


rule "Mercy Sprint Reset":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MERCY
    
    eventPlayer.MercySprint = 50


rule "Mercy Sprint Meter = 0":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MercySprint == 0
    @Condition eventPlayer.getCurrentHero() == Hero.MERCY
    
    eventPlayer.setMoveSpeed(100)


rule "Mercy Cease 1":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MERCY
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.isAlive() == true
    @Condition Round % 2 == 0
    @Condition eventPlayer.AtSafetyy == false
    @Condition RoundInProgress == true

    stopChasingVariable(LinePos)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 60)
    smallMessage(getAllPlayers(), "Mercy Has Stopped the line for 4 seconds!")
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 250)
    RunText = "FROZEN"
    wait(4)
    RunText = "RUN"
    if RoundInProgress == true:
        chase(LinePos, 60, rate=LineSpeed, ChaseReeval.DESTINATION_AND_RATE)



rule "Mercy Cease 2":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MERCY
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.isAlive() == true
    @Condition Round % 2 == 1
    @Condition eventPlayer.AtSafetyy == false
    @Condition RoundInProgress == true

    stopChasingVariable(LinePos)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 60)
    smallMessage(getAllPlayers(), "Mercy Has Stopped the line for 4 seconds!")
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 250)
    RunText = "FROZEN"
    wait(4)
    RunText = "RUN"
    if RoundInProgress == true:
        chase(LinePos, -60, rate=LineSpeed, ChaseReeval.DESTINATION_AND_RATE)
    


rule "Sombra Hack/EMP":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasStatusEffect(Status.HACKED) == true
    
    #eventPlayer.setStatusEffect(null, Status.ASLEEP, 2)
    eventPlayer.setStatusEffect(null, Status.FROZEN, 0.5)
    eventPlayer.setStatusEffect(null, Status.ASLEEP, 1)
    wait(1)
    eventPlayer.setAimSpeed(9999)
    wait(1)
    eventPlayer.setAimSpeed(100)
    eventPlayer.clearStatusEffect(Status.HACKED)


rule "Sombra Invis":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility1() == true
    
    smallMessage(eventPlayer, "Invis for 6 Seconds")
    wait(6)
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "Sombra Ult Charge":
    @Event playerDealtDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.SOMBRA
    @Condition attacker.isMeleeing() == true
    
    eventPlayer.SombraEMP += 10
    eventPlayer.setUltCharge(eventPlayer.SombraEMP)


rule "Sombra Ult Usage":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    
    wait()
    eventPlayer.SombraEMP = 0


rule "Roadhog Heal Wall":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.ROADHOG
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setMoveSpeed(50)
    eventPlayer.Phasing = true


rule "Roadhog Not Heal Wall":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.ROADHOG
    @Condition eventPlayer.isUsingAbility2() == false
    
    eventPlayer.setMoveSpeed(100)
    eventPlayer.Phasing = false
    #eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 1)


rule "Mei Firing":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MeiAmmo > 1
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    
    stopChasingVariable(eventPlayer.MeiAmmo)
    #eventPlayer.allowButton(Button.PRIMARY_FIRE)
    chase(eventPlayer.MeiAmmo, 0, rate=25, ChaseReeval.DESTINATION_AND_RATE)


rule "Mei Allow Gun":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MeiAmmo > 1
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)


rule "Mei Not Firing":
    @Event eachPlayer
    @Hero all
    #@Condition eventPlayer.MercySprint > 0
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    
    stopChasingVariable(eventPlayer.MeiAmmo)
    chase(eventPlayer.MeiAmmo, 50, rate=15, ChaseReeval.DESTINATION_AND_RATE)


rule "Mei Firing Reset":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    
    eventPlayer.MeiAmmo = 50


rule "Mei Fire Meter = 0":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MeiAmmo < 1
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)


rule "Mei Ult Charge":
    @Event playerDealtDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.MEI
    @Condition attacker.isMeleeing() == true
    
    eventPlayer.MeiUlt += 10
    eventPlayer.setUltCharge(eventPlayer.MeiUlt)


rule "Mei Ult Usage":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    
    wait()
    eventPlayer.MeiUlt = 0


rule "Lucio Ult Charge":
    @Event playerDealtDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.LUCIO
    @Condition attacker.isMeleeing() == true
    
    eventPlayer.LucioUlt += 10
    eventPlayer.setUltCharge(eventPlayer.LucioUlt)


rule "Lucio Ult Usage":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    
    wait()
    eventPlayer.LucioUlt = 0


rule "Lucio Ult":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    
    smallMessage(getAllPlayers(), "Lucio Has Slown Down Time!")
    setSlowMotion(50)
    getLivingPlayers(Team.ALL).disallowButton(Button.ULTIMATE)
    eventPlayer.setMoveSpeed(200)
    wait(4)
    setSlowMotion(100)
    eventPlayer.setMoveSpeed(100)
    getAllPlayers().allowButton(Button.ULTIMATE)


rule "Widow Snipe Hit":
    @Event playerDealtDamage
    @Hero all
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition attacker.getCurrentHero() == Hero.WIDOWMAKER
    @Condition attacker.WidowCD == 0
    
    attacker.WidowOldPos = attacker.getPosition()
    #attacker.WidowCD = 35
    #chase(attacker.WidowCD, 0, duration=35, ChaseReeval.DESTINATION_AND_DURATION)
    #wait()
    attacker.teleport(victim)
    victim.teleport(attacker.WidowOldPos)
    #attacker.disallowButton(Button.PRIMARY_FIRE)
    smallMessage(victim, "Widow Swapped Positions With You! ")
    smallMessage(attacker, "Teleported")


rule "Widow Snipe Miss/cancel":
    @Event eachPlayer
    @Hero all
    #@Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.getCurrentHero() == Hero.WIDOWMAKER
    @Condition eventPlayer.WidowCD == 0
    #@Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isFiringPrimaryFire() == true
    
    eventPlayer.WidowCD = 35
    chase(eventPlayer.WidowCD, 0, duration=35, ChaseReeval.DESTINATION_AND_DURATION)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    #smallMessage(eventPlayer, "Missed! ")


rule "Widow Allow Gun":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.WidowCD == 0
    @Condition eventPlayer.getCurrentHero() == Hero.WIDOWMAKER
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)


rule "Venom Mine Slowdown":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.WIDOWMAKER
    @Condition eventAbility == Button.ABILITY_2
    
    victim.IsPoisoned = true
    victim.setMoveSpeed(50)
    wait(2)
    victim.setMoveSpeed(100)
    victim.IsPoisoned = false


rule "Genji Dash":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.GENJI
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition eventPlayer.IsPoisoned != true
    @Condition eventPlayer.GenjiCD == 0
    
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setMoveSpeed(200)
    eventPlayer.communicate(Comms.VOICE_LINE_UP)
    eventPlayer.setCamera(worldVector(vect(0, 1.5, -5), eventPlayer, Transform.ROTATION_AND_TRANSLATION), worldVector(vect(0, 1.5, 0), eventPlayer, Transform.ROTATION_AND_TRANSLATION), 0)
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, eventPlayer.getPosition(), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.EffectIDPlayers[1] = getLastCreatedEntity()
    wait(4)
    eventPlayer.GenjiCD = 26
    destroyEffect(eventPlayer.EffectIDPlayers[1])
    eventPlayer.setMoveSpeed(100)
    eventPlayer.stopCamera()
    chase(eventPlayer.GenjiCD, 0, duration=26, ChaseReeval.DESTINATION_AND_DURATION)
    if eventPlayer.AtSafetyy != true:
        eventPlayer.setInvisibility(Invis.NONE)

rule "Genji Ult":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.GENJI
    @Condition eventPlayer.IsPoisoned != true
    
    eventPlayer.setMoveSpeed(150)
    wait(5)
    eventPlayer.setMoveSpeed(100)


rule "Genji Attack":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.GENJI
    @Condition attacker.isUsingUltimate() == true
    
    victim.applyImpulse(attacker.getFacingDirection(), 15, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.02)
    victim.setStatusEffect(null, Status.KNOCKED_DOWN, 1)


rule "Genji Ult Charge":
    @Event playerDealtDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.GENJI
    @Condition attacker.isMeleeing() == true
    
    eventPlayer.GenjiUlt += 5
    eventPlayer.setUltCharge(eventPlayer.GenjiUlt)


rule "Genji Ult Usage":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.GENJI
    
    wait()
    eventPlayer.GenjiUlt = 0


rule "Melee CD":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isMeleeing() == true
    @Condition eventPlayer.Safe == false
    
    eventPlayer.MeleeCD = 4
    chase(eventPlayer.MeleeCD, 0, duration=4, ChaseReeval.DESTINATION_AND_DURATION)
    eventPlayer.disallowButton(Button.MELEE)


rule "Melee CD Off":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MeleeCD == 0
    @Condition eventPlayer.Safe == false
    
    eventPlayer.allowButton(Button.MELEE)


rule "Junkrat Primary":
    @Event playerDealtDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.JUNKRAT
    #@Condition attacker.isFiringPrimaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    victim.setStatusEffect(null, Status.KNOCKED_DOWN, 1)
    victim.applyImpulse(attacker.getFacingDirection(), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Genji ULT fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.GenjiUlt > 100
    @Condition eventPlayer.getCurrentHero() == Hero.GENJI
    
    eventPlayer.GenjiUlt = 90


rule "Sombra ULT fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.SombraEMP > 100
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    
    eventPlayer.SombraEMP = 90


rule "Mei ULT fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MeiUlt > 100
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    
    eventPlayer.MeiUlt = 90


rule "Lucio ULT fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.LucioUlt > 100
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    
    eventPlayer.LucioUlt = 90


rule "Junkrat Fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.JUNKRAT
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setDamageDealt(1)


rule "MEI Fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MEI
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setDamageDealt(1)


rule "Damage Fix for all non-junkrats":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() != Hero.JUNKRAT
    @Condition eventPlayer.isDummy() == false

    
    eventPlayer.setDamageDealt(100)

rule "Tracer Fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.TRACER
    
    eventPlayer.setDamageDealt(1)    

rule "Moira Melee":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.isDummy() == false
    @Condition attacker.isMeleeing() == true
    @Condition attacker.getCurrentHero() == Hero.MOIRA
    @Condition eventAbility == Button.MELEE
    
    victim.applyImpulse(attacker.getFacingDirection(), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.02)
    victim.setStatusEffect(null,Status.FROZEN,1)

rule "Moira Ult Charge":
    @Event playerDealtDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.MOIRA
    @Condition attacker.isMeleeing() == true
    
    eventPlayer.MoiraUlt += 10
    eventPlayer.setUltCharge(eventPlayer.MoiraUlt)

rule "Moira ULT fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.MoiraUlt > 100
    @Condition eventPlayer.getCurrentHero() == Hero.MOIRA
    
    eventPlayer.MoiraUlt = 90

rule "Moira Ult 100":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MOIRA
    @Condition eventPlayer.getUltCharge() == 100
    
    eventPlayer.setAbility1Enabled(true)
    smallMessage(eventPlayer,"Phase Enabled")
    eventPlayer.MoiraUlt = 0
    eventPlayer.setUltCharge(eventPlayer.MoiraUlt)

rule "Moira Phase":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MOIRA
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.MoiraPhase = true
    wait(0.5)
    eventPlayer.setAbility1Enabled(false)
    wait(0.3)
    eventPlayer.MoiraPhase = false

def MoiraFix():
    @Name "MoriaFix"
    
    switch eventPlayer.getCurrentHero():
        case Hero.MOIRA:
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.WIDOWMAKER:
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.MoiraPhase = false
            break
        case Hero.GENJI:
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.MEI:
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.MoiraPhase = false
            break
        case Hero.LUCIO:
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.ROADHOG:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.MERCY:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.ASHE:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.ANA:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.JUNKRAT:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.MoiraPhase = false
            break
        case Hero.SOMBRA:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.MoiraPhase = false
            break
        case Hero.PHARAH:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.MoiraPhase = false
            break

rule "Moira Not Phase":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.MOIRA
    @Condition eventPlayer.isUsingAbility1() == false
    
    eventPlayer.MoiraPhase = false

rule "Moira Orb":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.MOIRA
    @Condition eventAbility == Button.ABILITY_2
    @Condition victim.IsPoisoned != true
    
    victim.setMoveSpeed(60)
    wait(4)
    victim.setMoveSpeed(100)

rule "Pharah Hit":
    @Event playerTookDamage
    @Hero all
    @Condition attacker.getCurrentHero() == Hero.PHARAH
    @Condition eventAbility == Button.PRIMARY_FIRE

    victim.setStatusEffect(null,Status.KNOCKED_DOWN, 1)
    wait(4)

rule "Pharah Fix":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() == Hero.PHARAH
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setMaxAmmo(0,1)
    eventPlayer.setDamageDealt(1)
    

# ------------- HUDS --------------


rule "Player HUD":
    #@Condition isGameInProgress() == true
    
    hudText(getAllPlayers(), "", "Round", null, HudPosition.LEFT, 0, Color.TURQUOISE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), " {0} ".format(Round), "", null, HudPosition.LEFT, 1, Color.TURQUOISE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "", "Death Line Speed", null, HudPosition.LEFT, 2, Color.TURQUOISE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), " {0} ".format(LineSpeed), "", null, HudPosition.LEFT, 3, Color.TURQUOISE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "4T6VF", "{0} Join Our Discord @".format(abilityIconString(Hero.ORISA, Button.SECONDARY_FIRE)), "discord.gg/Y2PFｂｗ6", HudPosition.LEFT, -1, Color.TURQUOISE, Color.ORANGE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudText(getAllPlayers(), "", "Join Our Discord @ discord.gg/", null, HudPosition.LEFT, 4, Color.TURQUOISE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "", "                         Back n' Forth!\n      Version 2.0.0, Made by Hazno#21688\n         Use Code 4T6VF for latest version", null, HudPosition.TOP, 0, Color.TURQUOISE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getLivingPlayers(Team.ALL), "", "  \n \n \n \n \n \n \n \n \n \n  \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ", null, HudPosition.TOP, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Melee Hud":
    @Event eachPlayer
    @Hero all
    
    #hudHeader(eventPlayer if eventPlayer.getCurrentHero() == Hero.MERCY and eventPlayer.isAlive() == true else [], "{1} Sprint Charge {0}".format(round(eventPlayer.MercySprint), abilityIconString(Hero.SOLDIER, Button.ABILITY_1)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudHeader(eventPlayer if eventPlayer.getCurrentHero() == Hero.GENJI and eventPlayer.isAlive() == true else [], "{1} Dragon Orb {0}".format(ceil(eventPlayer.GenjiCD), abilityIconString(Hero.HANZO, Button.ULTIMATE)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudHeader(eventPlayer if eventPlayer.getCurrentHero() == Hero.ANA and eventPlayer.isAlive() == true else [], "{1} Heal Bomb CD {0}".format(ceil(eventPlayer.AnaHealCD), abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudHeader(eventPlayer if eventPlayer.getCurrentHero() == Hero.MEI and eventPlayer.isAlive() == true else [], "{1} Ammo {0}".format(ceil(eventPlayer.MeiAmmo), abilityIconString(Hero.MEI, Button.RELOAD)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudHeader(eventPlayer if eventPlayer.getCurrentHero() == Hero.WIDOWMAKER and eventPlayer.isAlive() == true else [], "{1} Teleport {0}".format(ceil(eventPlayer.WidowCD), abilityIconString(Hero.TRACER, Button.ABILITY_1)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudText(getLivingPlayers(Team.ALL), "", "  \n \n \n \n \n \n \n \n \n \n  \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ", null, HudPosition.TOP, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.isAlive() else [], "{1} Melee CD {0}".format(ceil(eventPlayer.MeleeCD), abilityIconString(Hero.BAPTISTE, Button.MELEE)), HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.disableGamemodeHud()


rule "Hud Fix":
    @Event eachPlayer
    @Hero all
    
    eventPlayer.NewHud = "what r u doing in my swamp"


rule "CooldownHUDS":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getCurrentHero() != eventPlayer.hero
    

    wait()
    MoiraFix()
    eventPlayer.hero = eventPlayer.getCurrentHero()
    #eventPlayer.NewHud = 10000
    if eventPlayer.getCurrentHero() == Hero.MERCY:
        destroyHudText(eventPlayer.NewHud)
        hudHeader(eventPlayer if eventPlayer.isAlive() == true else [], "{1} Sprint Charge {0}".format(round(eventPlayer.MercySprint), abilityIconString(Hero.SOLDIER, Button.ABILITY_1)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        eventPlayer.NewHud = getLastCreatedText()
    elif eventPlayer.getCurrentHero() == Hero.ANA:
        destroyHudText(eventPlayer.NewHud)
        hudHeader(eventPlayer if eventPlayer.isAlive() == true else [], "{1} Heal Bomb CD {0}".format(ceil(eventPlayer.AnaHealCD), abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        eventPlayer.NewHud = getLastCreatedText()
    elif eventPlayer.getCurrentHero() == Hero.GENJI:
        destroyHudText(eventPlayer.NewHud)
        hudHeader(eventPlayer if eventPlayer.isAlive() == true else [], "{1} Dragon Orb {0}".format(ceil(eventPlayer.GenjiCD), abilityIconString(Hero.HANZO, Button.ULTIMATE)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        eventPlayer.NewHud = getLastCreatedText()
    elif eventPlayer.getCurrentHero() == Hero.MEI:
        destroyHudText(eventPlayer.NewHud)
        hudHeader(eventPlayer if eventPlayer.isAlive() == true else [], "{1} Ammo {0}".format(ceil(eventPlayer.MeiAmmo), abilityIconString(Hero.MEI, Button.RELOAD)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        eventPlayer.NewHud = getLastCreatedText()
    elif eventPlayer.getCurrentHero() == Hero.WIDOWMAKER:
        destroyHudText(eventPlayer.NewHud)
        hudHeader(eventPlayer if eventPlayer.isAlive() == true else [], "{1} Teleport {0}".format(ceil(eventPlayer.WidowCD), abilityIconString(Hero.TRACER, Button.ABILITY_1)), HudPosition.TOP, 5, Color.AQUA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        eventPlayer.NewHud = getLastCreatedText()
    elif eventPlayer.NewHud != 0:
        destroyHudText(eventPlayer.NewHud)
    #wait(0.25)
    #goto RULE_START


rule "Ana Hud":
    hudText(getPlayersOnHero(Hero.ANA, Team.ALL), "{0}".format(heroIcon(Hero.ANA)), " \nAna can Sleep enemies and Heal herself                          ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.ANA, Team.ALL), "{0}".format(abilityIconString(Hero.ANA, Button.ABILITY_1)), "Sleep Dart                                                                                   \n12s CD  ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.ANA, Team.ALL), "{0}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), "Heal Bomb - Instantly heal 50hp and go 25% faster   \n10s CD                                        ", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Mercy Hud":
    hudText(getPlayersOnHero(Hero.MERCY, Team.ALL), "{0}".format(heroIcon(Hero.MERCY)), " \nMercy can Sprint fast and regenerate passively", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MERCY, Team.ALL), "{0}".format(abilityIconString(Hero.SOLDIER, Button.ABILITY_1)), "Sprint Burst - Run 50% Faster                                     \nRecharging Ability                                          ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MERCY, Team.ALL), "{0}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), "Angelic Regeneration - Passively Heal                    \nNo CD                                                    ", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MERCY, Team.ALL), "{0}".format(abilityIconString(Hero.MERCY, Button.ABILITY_2)), "Cease - Stop The Line for 4s                                          \n60s CD                                ", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Roadhog Hud":
    hudText(getPlayersOnHero(Hero.ROADHOG, Team.ALL), "{0}".format(heroIcon(Hero.ROADHOG)), " \nRoadhog can Displace enemies and Phase through walls         ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.ROADHOG, Team.ALL), "{0}".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_1)), "Chain Hook                                                                                                 \n24s CD", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.ROADHOG, Team.ALL), "{0}".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_2)), "Phase Change - Walk through walls while healing                      \n24s CD", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Ashe Hud":
    hudText(getPlayersOnHero(Hero.ASHE, Team.ALL), "{0}".format(heroIcon(Hero.ASHE)), " \nAshe can Displace and Slow down enemies                      ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.ASHE, Team.ALL), "{0}".format(abilityIconString(Hero.ASHE, Button.ABILITY_1)), "Boop - Boop an enemy in the direction hit                         \n20s CD                                       ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.ASHE, Team.ALL), "{0}".format(abilityIconString(Hero.ASHE, Button.ABILITY_2)), "Grenade - Anyone hit will be slowed down 50%            \n16s CD                        ", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Sombra Hud":
    hudText(getPlayersOnHero(Hero.SOMBRA, Team.ALL), "{0}".format(heroIcon(Hero.SOMBRA)), " \nSombra can stun enemies and go invisible                     ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.SOMBRA, Team.ALL), "{0}".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_1)), "Stealth - Stealth for 6 seconds                                            \n12s CD                                        ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.SOMBRA, Team.ALL), "{0}".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_2)), "Hack - Stun enemies who get hacked                                 \n20s CD", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.SOMBRA, Team.ALL), "{0}".format(abilityIconString(Hero.SOMBRA, Button.ULTIMATE)), "EMP - Hack multiple enemies at once                                   \nCharges 10% per melee", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Mei Hud":
    hudText(getPlayersOnHero(Hero.MEI, Team.ALL), "{0}".format(heroIcon(Hero.MEI)), " \nMei craves the blood of her enemies, freeze and block paths  ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MEI, Team.ALL), "{0}".format(abilityIconString(Hero.MEI, Button.PRIMARY_FIRE)), "Freeze - Satan slows down her enemies                                           \nRecharging Ability ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MEI, Team.ALL), "{0}".format(abilityIconString(Hero.MEI, Button.ABILITY_2)), "Ice Wall                                                                                                       \n36s CD ", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MEI, Team.ALL), "{0}".format(abilityIconString(Hero.MEI, Button.ULTIMATE)), "Snowball - Call upon satan and freeze everyone in an area \nCharges 10% per melee", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Lucio Hud":
    hudText(getPlayersOnHero(Hero.LUCIO, Team.ALL), "{0}".format(heroIcon(Hero.LUCIO)), " \nLucio can Manipulate time and Boop enemies                               ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.LUCIO, Team.ALL), "{0}".format(abilityIconString(Hero.LUCIO, Button.SECONDARY_FIRE)), "Boop - Boop an enemy in the direction hit                                     \n10s CD", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.LUCIO, Team.ALL), "{0}".format(abilityIconString(Hero.TRACER, Button.ABILITY_2)), "Timestop - Move 2x faster and slowdown time for everyone \nCharges 10% per melee", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Widow Hud":
    hudText(getPlayersOnHero(Hero.WIDOWMAKER, Team.ALL), "{0}".format(heroIcon(Hero.WIDOWMAKER)), " \nWidowmaker can Teleport and Slow down enemies                ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.WIDOWMAKER, Team.ALL), "{0}".format(abilityIconString(Hero.WIDOWMAKER, Button.ABILITY_2)), "Venom Mine - Slowdown enemies who hit it                                \n30s CD", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.WIDOWMAKER, Team.ALL), "{0}".format(abilityIconString(Hero.TRACER, Button.ABILITY_1)), "Teleport - Snipe a target to swap positions with them              \n36s CD", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Genji Hud":
    hudText(getPlayersOnHero(Hero.GENJI, Team.ALL), "{0}".format(heroIcon(Hero.GENJI)), " \nGenji can negate Damage and Stun enemies                              ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.GENJI, Team.ALL), "{0}".format(abilityIconString(Hero.HANZO, Button.ULTIMATE)), "Dragon Orb - Become Unvulnerable and move faster           \n26s CD", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.GENJI, Team.ALL), "{0}".format(abilityIconString(Hero.GENJI, Button.ABILITY_2)), "Deflect                                                                                                     \n16s CD", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.GENJI, Team.ALL), "{0}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE)), "Dragonstrike - Move faster and get unlimited attacks          \nCharges 5% per melee", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Junkrat Hud":
    hudText(getPlayersOnHero(Hero.JUNKRAT, Team.ALL), "{0}".format(heroIcon(Hero.JUNKRAT)), " \nJunkrat can trap and knockback other players                 ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.JUNKRAT, Team.ALL), "{0}".format(abilityIconString(Hero.JUNKRAT, Button.PRIMARY_FIRE)), "Bombs - Knockback enemies                                                         \n1 Bullet ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.JUNKRAT, Team.ALL), "{0}".format(abilityIconString(Hero.JUNKRAT, Button.ABILITY_1)), "Mines - Knockback enemies                                                           \n32s CD", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.JUNKRAT, Team.ALL), "{0}".format(abilityIconString(Hero.JUNKRAT, Button.ABILITY_2)), "Trap - Trap enemies in place!                                                          \n30s CD", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

rule "Moira Hud":
    hudText(getPlayersOnHero(Hero.MOIRA, Team.ALL), "{0}".format(heroIcon(Hero.MOIRA)), " \nMoira can phase through walls and slowdown enemies             ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MOIRA, Team.ALL), "{0}".format(abilityIconString(Hero.MOIRA, Button.ABILITY_1)), "Phase - Phase through all walls                                                              \nCharges 10% per melee ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MOIRA, Team.ALL), "{0}".format(abilityIconString(Hero.MOIRA, Button.ABILITY_2)), "Orbs - Slowdown enemies hit for 4 seconds by 20%                          \n20s CD", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.MOIRA, Team.ALL), "{0}".format(abilityIconString(Hero.MOIRA, Button.MELEE)), "Melee - Melee applies a frozen effect on players                                  \n4s CD", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

rule "Pharah Hud":
    hudText(getPlayersOnHero(Hero.PHARAH, Team.ALL), "{0}".format(heroIcon(Hero.PHARAH)), " \nPharah can hack enemies and jump over walls             ", null, HudPosition.RIGHT, 0, Color.BLUE, Color.BLUE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.PHARAH, Team.ALL), "{0}".format(abilityIconString(Hero.PHARAH, Button.PRIMARY_FIRE)), "Bomb - Enemies hit are stunned                                              \n2 Bullets ", null, HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.PHARAH, Team.ALL), "{0}".format(abilityIconString(Hero.PHARAH, Button.ABILITY_1)), "Leap - Jump over walls                                                              \n40s CD ", null, HudPosition.RIGHT, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getPlayersOnHero(Hero.PHARAH, Team.ALL), "{0}".format(abilityIconString(Hero.PHARAH, Button.ABILITY_2)), "Boop - Boop Enemies Hit                                                            \n27s CD", null, HudPosition.RIGHT, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


# ------------------------ VOTING --------------------


rule "Voting HUD + Array":
    Vote1 = []
    Vote2 = []
    Vote3 = []
    Vote4 = []
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == true], "", " ", "- Voting -", HudPosition.TOP, 4, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == true and EventCD[1] < 2], l"{0} - {1}".format(iconString(Icon.SPIRAL), len(Vote1)), "Speed Up Laser Speed +0.1                                   ", "Ability 1", HudPosition.TOP, 5, Color.RED, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == true and EventCD[2] < 2], l"{0} - {1}".format(iconString(Icon.DIZZY), len(Vote2)), "Sleep All Players for 3s                                     ", "Ability 2", HudPosition.TOP, 6, Color.GREEN, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == true and EventCD[3] < 2], l"{0} - {1}".format(iconString(Icon.HAPPY), len(Vote3)), "Allow Walls to be walked through for 3s", "Reload", HudPosition.TOP, 7, Color.PURPLE, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == true and EventCD[4] < 2], l"{0} - {1}".format(iconString(Icon.DIAMOND), len(Vote4)), "Force all Players to crouch for 5s              ", "Crouch", HudPosition.TOP, 8, Color.AQUA, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == true], "", " \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ", "", HudPosition.TOP, 12, Color.AQUA, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getDeadPlayers(Team.ALL) if VoteInProgress == false], "", "", " \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ", HudPosition.TOP, 12, Color.AQUA, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getDeadPlayers(Team.ALL), "Press Space To Spectate", "      ", "", HudPosition.TOP, 13, Color.AQUA, Color.WHITE, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText([player for player in getAllPlayers() if VoteTimer > 0], "{0} Players Are Voting {0}\n                          {1}".format(iconString(Icon.FIRE), VoteTimer), "", "", HudPosition.TOP, 2, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Ability 1":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDead() == true
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition eventPlayer in Vote1 == false
    @Condition VoteInProgress == true
    @Condition eventPlayer.VoteCD == 0
    @Condition EventCD[1] < 2
    
    Vote1.append(eventPlayer)
    Vote2.remove(eventPlayer)
    Vote3.remove(eventPlayer)
    Vote4.remove(eventPlayer)
    eventPlayer.VoteCD = 1
    chase(eventPlayer.VoteCD, 0, duration=1, ChaseReeval.DESTINATION_AND_DURATION)


rule "Ability 2":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDead() == true
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer in Vote2 == false
    @Condition VoteInProgress == true
    @Condition eventPlayer.VoteCD == 0
    @Condition EventCD[2] < 2
    
    Vote1.remove(eventPlayer)
    Vote2.append(eventPlayer)
    Vote3.remove(eventPlayer)
    Vote4.remove(eventPlayer)
    eventPlayer.VoteCD = 1
    chase(eventPlayer.VoteCD, 0, duration=1, ChaseReeval.DESTINATION_AND_DURATION)


rule "Reload":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDead() == true
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer in Vote3 == false
    @Condition VoteInProgress == true
    @Condition eventPlayer.VoteCD == 0
    @Condition EventCD[3] < 2
    
    Vote1.remove(eventPlayer)
    Vote2.remove(eventPlayer)
    Vote3.append(eventPlayer)
    Vote4.remove(eventPlayer)
    eventPlayer.VoteCD = 1
    chase(eventPlayer.VoteCD, 0, duration=1, ChaseReeval.DESTINATION_AND_DURATION)


rule "Crouch":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDead() == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer in Vote4 == false
    @Condition VoteInProgress == true
    @Condition eventPlayer.VoteCD == 0
    @Condition EventCD[4] < 2
    
    Vote1.remove(eventPlayer)
    Vote2.remove(eventPlayer)
    Vote3.remove(eventPlayer)
    Vote4.append(eventPlayer)
    eventPlayer.VoteCD = 1
    chase(eventPlayer.VoteCD, 0, duration=1, ChaseReeval.DESTINATION_AND_DURATION)


rule "Vote Timer":
    @Condition VoteInProgress == true
    @Condition [i for i in getNumberOfDeadPlayers(Team.ALL) if i.isDummy() == false] > 0
    
    smallMessage(getAllPlayers(), "Dead Players Are Voting!")
    VoteTimer = 9
    chase(VoteTimer, 0, duration=9, ChaseReeval.DESTINATION_AND_DURATION)
    wait(9, Wait.ABORT_WHEN_FALSE)
    VoteInProgress = false
    VoteFinal[1] = len(Vote1)
    VoteFinal[2] = len(Vote2)
    VoteFinal[3] = len(Vote3)
    VoteFinal[4] = len(Vote4)
    HighestVoteFinal = sorted(VoteFinal).last()
    if len([player for player in VoteFinal if player == HighestVoteFinal]) != 1:
        bigMessage(getAllPlayers(), "Draw! Picking Random Event")
        wait(2)
        RandomEvent = random.randint(1,4)
        switch (RandomEvent):
            case 1:
                bigMessage(getAllPlayers(), "Line Speed Increased +0.1!")
                smallMessage(getAllPlayers(), "Event!")
                LineSpeed += 0.1
                LineSpeedPrev = LineSpeed
                VoteFinal = 0
                HighestVoteFinal = 0
                Vote1 = []
                Vote2 = []
                Vote3 = []
                Vote4 = []
                EventCD[1] = 0
                EventCD[2] = 0
                EventCD[3] = 0
                EventCD[4] = 0
                RandomEvent = 0
                break
            case 2:
                bigMessage(getAllPlayers(), "Slept All Players for 3s!")
                smallMessage(getAllPlayers(), "Event!")
                ([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]).setStatusEffect(null, Status.ASLEEP, 3)
                VoteFinal = 0
                HighestVoteFinal = 0
                Vote1 = []
                Vote2 = []
                Vote3 = []
                Vote4 = []
                EventCD[1] = 0
                EventCD[2] = 0
                EventCD[3] = 0
                EventCD[4] = 0
                RandomEvent = 0
                break
            case 3:
                bigMessage(getAllPlayers(), "Walls Can Be Walked through for 3s!")
                smallMessage(getAllPlayers(), "Event!")
                ([player for player in getAllPlayers() if player.isDummy() == false]).WallEvent = true
                wait(3)
                ([player for player in getAllPlayers() if player.isDummy() == false]).WallEvent = false
                smallMessage(getAllPlayers(), "Event Over!")
                VoteFinal = 0
                HighestVoteFinal = 0
                Vote1 = []
                Vote2 = []
                Vote3 = []
                Vote4 = []
                EventCD[1] = 0
                EventCD[2] = 0
                EventCD[3] = 0
                EventCD[4] = 0
                RandomEvent = 0
                break
            case 4:
                bigMessage(getAllPlayers(), "All Players Crouched for 5s!")
                smallMessage(getAllPlayers(), "Event!")
                getLivingPlayers(Team.ALL).startForcingButton(Button.CROUCH)
                wait(5)
                getAllPlayers().stopForcingButton(Button.CROUCH)
                smallMessage(getAllPlayers(), "Event Over!")
                VoteFinal = 0
                HighestVoteFinal = 0
                Vote1 = []
                Vote2 = []
                Vote3 = []
                Vote4 = []
                EventCD[1] = 0
                EventCD[2] = 0
                EventCD[3] = 0
                EventCD[4] = 0
                RandomEvent = 0
                break

    elif len(Vote1) == HighestVoteFinal:
        bigMessage(getAllPlayers(), "Line Speed Increased +0.1!")
        smallMessage(getAllPlayers(), "Event!")
        LineSpeed += 0.1
        LineSpeedPrev = LineSpeed
        VoteFinal = 0
        HighestVoteFinal = 0
        Vote1 = []
        Vote2 = []
        Vote3 = []
        Vote4 = []
        EventCD[1] += 1
        EventCD[2] = 0
        EventCD[3] = 0
        EventCD[4] = 0
    elif len(Vote2) == HighestVoteFinal:
        bigMessage(getAllPlayers(), "Slept All Players for 3s!")
        smallMessage(getAllPlayers(), "Event!")
        ([player for player in getLivingPlayers(Team.ALL) if player.isDummy() == false]).setStatusEffect(null, Status.ASLEEP, 3)
        VoteFinal = 0
        HighestVoteFinal = 0
        Vote1 = []
        Vote2 = []
        Vote3 = []
        Vote4 = []
        EventCD[1] = 0
        EventCD[2] += 1
        EventCD[3] = 0
        EventCD[4] = 0
    elif len(Vote3) == HighestVoteFinal:
        bigMessage(getAllPlayers(), "Walls Can Be Walked through for 3s!")
        smallMessage(getAllPlayers(), "Event!")
        ([player for player in getAllPlayers() if player.isDummy() == false]).WallEvent = true
        wait(3)
        ([player for player in getAllPlayers() if player.isDummy() == false]).WallEvent = false
        smallMessage(getAllPlayers(), "Event Over!")
        VoteFinal = 0
        HighestVoteFinal = 0
        Vote1 = []
        Vote2 = []
        Vote3 = []
        Vote4 = []
        EventCD[1] = 0
        EventCD[2] = 0
        EventCD[3] += 1
        EventCD[4] = 0
    elif len(Vote4) == HighestVoteFinal:
        bigMessage(getAllPlayers(), "All Players Crouched for 5s!")
        smallMessage(getAllPlayers(), "Event!")
        getLivingPlayers(Team.ALL).startForcingButton(Button.CROUCH)
        wait(5)
        getAllPlayers().stopForcingButton(Button.CROUCH)
        smallMessage(getAllPlayers(), "Event Over!")
        VoteFinal = 0
        HighestVoteFinal = 0
        Vote1 = []
        Vote2 = []
        Vote3 = []
        Vote4 = []
        EventCD[1] = 0
        EventCD[2] = 0
        EventCD[3] = 1
        EventCD[4] += 0

rule "Vote Fix":
    @Condition VoteInProgress == true
    @Condition [i for i in getNumberOfDeadPlayers(Team.ALL) if i.isDummy() == false] == 0
    
    VoteInProgress = false

rule "Create Orbs":

    createEffect(getAllPlayers(),Effect.SPHERE,Color.ORANGE,RandomOrbs,1,EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

def RandomOrbs():
    @Name "RandomOrbs"

    RandomOrbs = vect(random.uniform(-12,12),46.5,random.uniform(-12,12))

rule "ClaimOrb":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == false
    @Condition distance(eventPlayer,RandomOrbs) <= 1.2

    RandomOrbs = vect(0,-5,0)
    RandomOrbsEvent = random.randint(1,5)
    switch RandomOrbsEvent:
        case 1:
            playEffect(eventPlayer,DynamicEffect.GOOD_PICKUP_EFFECT,Color.WHITE,eventPlayer.getPosition(),100)
            heal(eventPlayer,null,50)
            smallMessage(eventPlayer,"Healed 50!")
            RandomOrbsEvent = 0
            break
        case 2:
            playEffect(eventPlayer,DynamicEffect.GOOD_PICKUP_EFFECT,Color.WHITE,eventPlayer.getPosition(),100)
            smallMessage(eventPlayer,"20% Ultimate Gain!")
            RandomOrbsEvent = 0
            if eventPlayer.getCurrentHero() == Hero.GENJI:
                eventPlayer.GenjiUlt += 20
                eventPlayer.setUltCharge(eventPlayer.GenjiUlt)
            
            elif eventPlayer.getCurrentHero() == Hero.LUCIO:
                eventPlayer.LucioUlt += 20
                eventPlayer.setUltCharge(eventPlayer.LucioUlt)
            
            elif eventPlayer.getCurrentHero() == Hero.MEI:
                eventPlayer.MeiUlt += 20
                eventPlayer.setUltCharge(eventPlayer.MeiUlt)
            
            elif eventPlayer.getCurrentHero() == Hero.SOMBRA:
                eventPlayer.SombraEMP += 20
                eventPlayer.setUltCharge(eventPlayer.SombraEMP)
            
            elif eventPlayer.getCurrentHero() == Hero.MOIRA:
                eventPlayer.MoiraUlt += 20
                eventPlayer.setUltCharge(eventPlayer.MoiraUlt)
            
        case 3:
            playEffect(eventPlayer,DynamicEffect.BAD_PICKUP_EFFECT,Color.WHITE,eventPlayer.getPosition(),100)
            eventPlayer.setStatusEffect(null,Status.STUNNED,2)
            smallMessage(eventPlayer,"Stunned!")
            RandomOrbsEvent = 0
            break
        case 4:
            playEffect(eventPlayer,DynamicEffect.BAD_PICKUP_EFFECT,Color.WHITE,eventPlayer.getPosition(),100)
            damage(eventPlayer,null,25)
            smallMessage(eventPlayer,"Ouch!")
            RandomOrbsEvent = 0
            break
        case 5:
            playEffect(eventPlayer,DynamicEffect.GOOD_PICKUP_EFFECT,Color.WHITE,eventPlayer.getPosition(),100)
            eventPlayer.teleport(Safety)
            smallMessage(eventPlayer,"Teleported To Safety!")
            RandomOrbsEvent = 0
            break

rule "Variation 4 circle of DOOM":
    @Condition WallsRandom[1] == 4

    CircleTrapHeight = 46
    CircleTrapAngle = 0
    while WallsRandom[1] == 4:
        CircleTrapAngle = 20
        chase((CircleTrapAngle), 380, duration=1.5 ,ChaseReeval.DESTINATION_AND_DURATION)
        chase(CircleTrapHeight, 51, duration=0.75, ChaseReeval.DESTINATION_AND_DURATION)
        wait(0.75)
        chase(CircleTrapHeight, 46, duration=0.75, ChaseReeval.DESTINATION_AND_DURATION)
        wait(0.75)
        

rule "Variation 4 Circle of DOOM stun":
    @Event eachPlayer
    @Condition raycast(((angleToDirection(CircleTrapAngle + 180, 0) * 7) + vect(0, CircleTrapHeight, -14.5)), ((angleToDirection(CircleTrapAngle, 0) * 7) + vect(0, CircleTrapHeight, -14.5)), eventPlayer, null, true).getPlayerHit() == true
    @Condition WallsRandom[1] == 4

    eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 2)
    wait(4)
    if RULE_CONDITION:
        goto RULE_START

rule "Variation 4 delete doom":

    createBeam([player for player in getAllPlayers() if WallsRandom[1] == 4],Beam.BAD,((angleToDirection(CircleTrapAngle + 180, 0) * 7.5) + vect(0, CircleTrapHeight, -14.5)), ((angleToDirection(CircleTrapAngle, 0) * 7.5) + vect(0, CircleTrapHeight, -14.5)),Color.RED,EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect([player for player in getAllPlayers() if WallsRandom[1] == 4],Effect.ORB, Color.RED, vect(0, CircleTrapHeight, -14.5),  0.5,EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect([player for player in getAllPlayers() if WallsRandom[1] == 4],Effect.SPHERE, Color.PURPLE, vect(0, 46, -14.5), 0.5,EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam([player for player in getAllPlayers() if WallsRandom[1] == 4],Beam.GRAPPLE, vect(0, 46, -14.5), vect(0, CircleTrapHeight, -14.501), Color.WHITE,EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

