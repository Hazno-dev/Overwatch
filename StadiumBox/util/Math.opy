#!mainFile "../StadiumBox.opy"

macro floorToInterval(value, interval):
    floor(value / interval) * interval

macro ceilToInterval(value, interval):
    ceil(value / interval) * interval

macro roundToInterval(value, interval):
    round(value / interval) * interval