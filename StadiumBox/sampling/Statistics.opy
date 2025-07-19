#!mainFile "../StadiumBox.opy"

macro eventPlayer.resetStatistics():
    eventPlayer.CumulativeDamage = 0
    eventPlayer.CumulativeHealing = 0
    eventPlayer.CumulativeTime = 0
    eventPlayer.CumulativeTimeMS = 0
    eventPlayer.DealtDamage = 0
    eventPlayer.DealtDamagePerSecond = 0
    eventPlayer.DealtDamageTicks = [0, 0]
    eventPlayer.DealtDamageTickQ = 0
    eventPlayer.DealtDamageTime = []
    eventPlayer.DealtDamageArray = []
    eventPlayer.DealtHealing = 0
    eventPlayer.DealtHealingPerSecond = 0
    eventPlayer.DealtHealingTicks = [0, 0]
    eventPlayer.DealtHealingTickQ = 0
    eventPlayer.Duration = 0
    eventPlayer.Bots = []
    eventPlayer.SampleReady = false

macro eventPlayer.finalizeStatistics():
    eventPlayer.CumulativeTime = eventPlayer.CumulativeTimeMS / 1000
    eventPlayer.DealtDamagePerSecond = round(eventPlayer.CumulativeDamage / eventPlayer.CumulativeTime)
    eventPlayer.DealtHealingPerSecond = round(eventPlayer.CumulativeHealing / eventPlayer.CumulativeTime)

    eventPlayer.CumulativeTimeMS = floorToInterval(eventPlayer.CumulativeTimeMS, 250)
    eventPlayer.CumulativeTime = eventPlayer.CumulativeTimeMS / 1000
    eventPlayer.CumulativeDamage = eventPlayer.DealtDamagePerSecond * eventPlayer.CumulativeTime
    eventPlayer.CumulativeHealing = eventPlayer.DealtHealingPerSecond * eventPlayer.CumulativeTime

macro eventPlayer.cacheDamageTick(eventTick):
    eventPlayer.DealtDamageTime.append(TimeMS - eventPlayer.LastTickTime)
    eventPlayer.DealtDamageArray.append(eventTick)
    eventPlayer.DealtDamageTickQ += 1
    eventPlayer.PlayerIterator = eventPlayer.DealtDamageTickQ % 2 

    if eventPlayer.DealtDamageTicks[eventPlayer.PlayerIterator] != 0:
        eventPlayer.DealtDamage += eventPlayer.DealtDamageTicks[eventPlayer.PlayerIterator]
  
    eventPlayer.DealtDamageTicks[eventPlayer.PlayerIterator] = eventTick

macro eventPlayer.processDamageTick(eventTick):
    updateTimeMS()
    eventPlayer.CumulativeDamage += eventTick
    eventPlayer.CumulativeTimeMS += eventPlayer.getLastTimeDifferenceMS()
    eventPlayer.cacheDamageTick(eventTick)
    eventPlayer.updateLastTimeMS()
    
rule "Sample - Damage Dealt":
    @Event playerDealtDamage
    @Condition attacker.isSampling()
    @Condition victim.isDummy()

    attacker.processDamageTick(eventDamage)
    victim.LostHP = victim.getMaxHealth() - victim.getHealth()

rule "Sample - Healing Dealt":
    @Event playerDealtHealing
    @Condition healer.isSampling()
    @Condition healee.isDummy()
    
    eventPlayer.DealtHealing += eventHealing
    healee.setHealth(10)