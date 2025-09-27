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


## Slot where a part fits in.
enum RocketSlot {
	Nose = 0,      # Reduces air resistence
	Pod = 1,       # Payload
	Body = 2,      # Fuel
	Thruster = 3,  # Engine
}

func rocket_slot_for_type(type: RocketPartType) -> RocketSlot:
	match type:
		RocketPartType.NoseMk1: return RocketSlot.Nose
		RocketPartType.PodMk1: return RocketSlot.Pod
		# TODO: Add more
		_: return RocketSlot.Body
