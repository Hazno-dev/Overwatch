#!mainFile "../StadiumBox.opy"

playervar DealtDamage = 0
playervar DealtDamagePerSecond = 0

playervar DealtHealing = 0
playervar DealtHealingPerSecond = 0

playervar DealtDamageTicks = [0, 0]
playervar DealtDamageTickQ = 0
playervar DealtHealingTicks = [0, 0]
playervar DealtHealingTickQ = 0

playervar DealtDamageTime = []
playervar DealtDamageArray = []

playervar LostHP = 0

#Sample Data
playervar CurrentCellIndex = -1
playervar SampleReady = false
playervar CurrentMode = 0
playervar Bots = []
playervar Duration = 0

#Stat Data
playervar CumulativeDamage = 0
playervar CumulativeHealing = 0
playervar CumulativeTimeMS = 0
playervar CumulativeTime = 0
playervar LastTickTime

# Free variable for random runtime purposes
playervar PlayerIterator

# UI Variables
playervar CurrentDuration = 0
playervar CurrentDurationElement = null
playervar StatsTextElement = null
playervar StatsTextElements = []