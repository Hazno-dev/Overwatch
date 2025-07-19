#!mainFile "../LaserSurvival.opy"

#!include "Vector.opy"

#macro proj(a, b):
    #k = dot(a, b) / dot(b, b)
    #return {x: k * b.x, y: k * b.y}

globalvar i

macro add(a, b):
    a + b

macro sub(a, b):
    a - b