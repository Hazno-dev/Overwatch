#!mainFile "../LaserSurvival.opy"


globalvar ATarget
globalvar ABVector
globalvar ABLengthSquared

playervar ACVector
playervar TClamped
playervar ABCDistance

macro setTargetLine(a, b):
    ATarget = a
    ABVector = vect(b.x - a.x, b.y - a.y, b.z - a.z)
    ABLengthSquared = dotProduct(ABVector, ABVector)

macro Player.targetLineDist():
    self.TClamped = min(max(dotProduct(vect(self.getPosition().x - ATarget.x, self.getPosition().y - ATarget.y, self.getPosition().z - ATarget.z), ABVector) / ABLengthSquared, 0), 1 )
    self.ABCDistance = magnitude(vect(
        self.getPosition().x - (ATarget.x + ABVector.x * self.TClamped),
        self.getPosition().y - (ATarget.y + ABVector.y * self.TClamped),
        self.getPosition().z - (ATarget.z + ABVector.z * self.TClamped)
    ))