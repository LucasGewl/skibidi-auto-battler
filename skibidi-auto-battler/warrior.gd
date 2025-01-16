class_name Warrior
extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	self.isInCombat = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func castAbility() -> void:
	super()
	print(self.getStatsString())
	self.maxHealth += 100
	self.currentHealth += 100
	self.attackPower += 5
	print(self.getStatsString())
	
