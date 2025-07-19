#!setupTags

#!include "config/Statics.opy"
#!include "core/Collision.opy"
#!include "core/Math.opy"
#!include "game/State.opy"
#!include "game/Laser.opy"

settings {
    "main": {
        "modeName": w"Laser Survival",
        "description": f"Laser Survival by Hazno. v{VERSION}"
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [
                "havana"
            ]
        },
        "general": {
            "heroLimit": "off",
            "respawnTime%": 30
        }
    }
}

rule "Debug":
    createEffect(true[0], Effect.SPHERE, Color.RED, RING_CENTER, 7.5, EffectReeval.NONE)
    addChaseLaser(0, 20)

rule "DebugPlayer":
    @Event eachPlayer
    @Condition eventPlayer.isAlive() and eventPlayer.hasSpawned()
    eventPlayer.teleport(vect(200, 10, -46.5))

rule "Teleport player on pressing interact":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    eventPlayer.teleport(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection()*5)
    #Hold the player in place, to reset falling velocity
    eventPlayer.startForcingPosition(eventPlayer.getPosition(), false)
    wait()
    eventPlayer.stopForcingPosition()

rule "Display position":
    @Event eachPlayer
    print("Position of {}: {}".format(eventPlayer, eventPlayer.getPosition()))
    #print("Distance: {}".format(eventPlayer.ABCDistance))
    #while true:
    #    wait()
    #    setTargetLine(RING_CENTER, RING_CENTER + vect(10, 0, 0))
    #    eventPlayer.targetLineDist()