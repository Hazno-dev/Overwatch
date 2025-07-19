#!mainFile "../LaserSurvival.opy"

macro Vector.pivot(angle, radius):
    self + vect(cosDeg(angle) * radius, 0, sinDeg(angle) * radius)

macro Vector.yOffset(offset):
    vect(self.x, self.y + offset, self.z)