class_name Unit

extends Node

@export var unitName : String;
@export var attackSpeed : float;
@export var attackPower : int;
@export var magicPower : int;
@export var currentMana : int;
@export var maxMana : int;
@export var manaPerAttack : int;
@export var attackRange : int;
@export var currentHealth : int;
@export var maxHealth : int;
var isInCombat : bool = false;
var attackCooldown : float;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.attackCooldown = self.attackSpeed;
	self.currentHealth = self.maxHealth;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!isInCombat):
		#print("Not in combat");
		pass
	else:
		if (self.canAttack(delta)):
			attack();
		
		if (self.canCastAbility()):
			castAbility();
		
	pass
	
	
	
func attack() -> void:
	print(self.unitName + ": attacked")
	self.currentMana += self.manaPerAttack;
	self.resetAttackCooldown();
	
	
	
func canAttack(delta : float) -> bool:
	self.attackCooldown -= delta;
	return self.attackCooldown <= 0;



func resetAttackCooldown() -> void:
	self.attackCooldown = self.attackSpeed;	
	
	
	
func canCastAbility() -> bool:
	return self.currentMana >= self.maxMana
	
	
	
func castAbility() -> void:
	print(self.unitName + ": Casted ability")
	self.resetMana();
	
func resetMana() -> void:
	self.currentMana = 0;
	
func getStatsString() -> String:
	return "Name: " + self.unitName + "
	Attack Speed: %f" % self.attackSpeed + "
	Attack Power: %d" % self.attackPower + "
	Magic Power : %d" % self.magicPower + "
	Current Mana: %d" % self.currentMana + "
	Max Mana: %d" % self.maxMana + "
	Mana Per Attack: %d" % self.manaPerAttack + "
	Attack Range: %d" % self.attackRange + "
	Current Health: %d" % self.currentHealth + "
	Max Health: %d" % self.maxHealth
