#!setupTags
#!extension spawnMoreDummyBots

#!include "config/Statics.opy"
#!include "config/GlobalVars.opy"
#!include "config/PlayerVars.opy"
#!include "util/"
#!include "sampling/"
#!include "heroes/"

# settings {
#     "main": {
#         "modeName": w"Stadium Box",
#         "description": f"Stadium Box by Hazno. v{VERSION}"
#     },
#     "gamemodes": {
#         "practiceRange": {
#         }
#     }
# }


rule "Debug":
    @Event eachPlayer
    hudText(eventPlayer, "Position: {0}".format(eventPlayer.getPosition()))
    hudText(eventPlayer, "Facing: {0}".format(eventPlayer.getFacingDirection()))

rule "Debug Start":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.isAlive() and eventPlayer.hasSpawned()
    eventPlayer.CurrentMode = MoiraMode.DamageOrb
    eventPlayer.startSample()

# rule "DebugPlayer":
#     @Event eachPlayer
#     @Condition eventPlayer.isAlive() and eventPlayer.hasSpawned()
#     eventPlayer.teleport(vect(200, 10, -46.5))

# rule "Teleport player on pressing interact":
#     @Event eachPlayer
#     @Condition eventPlayer.isHoldingButton(Button.INTERACT)
#     eventPlayer.teleport(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection()*5)
#     #Hold the player in place, to reset falling velocity
#     eventPlayer.startForcingPosition(eventPlayer.getPosition(), false)
#     wait()
#     eventPlayer.stopForcingPosition()

# rule "Display position":
#     @Event eachPlayer
#     print("Position of {}: {}".format(eventPlayer, eventPlayer.getPosition()))
#     #print("Distance: {}".format(eventPlayer.ABCDistance))
#     #while true:
#     #    wait()
#     #    setTargetLine(RING_CENTER, RING_CENTER + vect(10, 0, 0))
#     #    eventPlayer.targetLineDist()