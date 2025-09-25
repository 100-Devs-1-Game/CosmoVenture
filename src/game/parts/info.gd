class_name GlobalInfo extends Node
## Contains info about all the rocket parts.

# All enums have explicit numbering to prevent breaking things in the future.
# ALWAYS set the numbering when new values are added.
enum RocketPartType {
	NoseMk1 = 0,
	PodMk1 = 1,
	FuelMk1 = 2,
	ThrusterMk1 = 3,
	BurnThrusterMk1 = 4,
}
