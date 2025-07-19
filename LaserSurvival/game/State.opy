#!mainFile "../LaserSurvival.opy"

enum GameState:
    GAME_NOT_STARTED = 1
    GAME_IN_PROGRESS
    GAME_FINISHED

globalvar CurrentGameState = GameState.GAME_IN_PROGRESS

macro getGameState():
    CurrentGameState