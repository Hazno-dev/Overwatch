#!mainFile "../StadiumBox.opy"

macro MOIRA_DAMAGE_ORB_TEXT = fb"{ABILITY_POWER_ICON} - <fg63666AFF> {abilityIconString(Hero.MOIRA, Button.ABILITY_2)} Damage Orb</fg>
{eventPlayer.CumulativeDamage} / { eventPlayer.DealtDamagePerSecond} DPS"

macro MOIRA_HEAL_ORB_TEXT = fb"{ABILITY_POWER_ICON} - <fg63666AFF> {abilityIconString(Hero.MOIRA, Button.ABILITY_2)} Heal Orb</fg>
{eventPlayer.CumulativeHealing} / { eventPlayer.DealtHealingPerSecond} HPS"

enum MoiraMode:
    DamageOrb = 1
    HealingOrb = 2
    Damage = 3
    Healing = 4


macro MoiraDamageOrbMode(eventPlayer):
    eventPlayer.Duration = 6
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(0.5)
    eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.waitForSample()
    eventPlayer.setResultText(MOIRA_DAMAGE_ORB_TEXT)

macro MoiraHealingOrbMode(eventPlayer):
    eventPlayer.Duration = 6
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(0.5)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.waitForSample()

macro MoiraDamageMode(eventPlayer):
    eventPlayer.Duration = 3
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.waitForSample()

macro MoiraHealingMode(eventPlayer):
    eventPlayer.Duration = 3
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.waitForSample()

rule "Hero - Moira":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.hasSpawned() and eventPlayer.isAlive()
    @Condition eventPlayer.isSampleReady()

    switch (eventPlayer.CurrentMode):
        case MoiraMode.DamageOrb:
            MoiraDamageOrbMode(eventPlayer)
            break
        case MoiraMode.HealingOrb:
            MoiraHealingOrbMode(eventPlayer)
            break
        case MoiraMode.Damage:
            MoiraDamageMode(eventPlayer)
            break
        case MoiraMode.Healing:
            MoiraHealingMode(eventPlayer)
            break
    