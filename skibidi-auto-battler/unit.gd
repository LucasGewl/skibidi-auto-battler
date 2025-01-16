class_name Unit

extends Node2D

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

var offset : Vector2
var initial_pos : Vector2
var curr_platform
var prev_platform
var is_draggable

# Called when the node enters the scene tree for the first time.
func _ready():
	self.attackCooldown = self.attackSpeed;
	self.currentHealth = self.maxHealth;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_drag()
	
	if (!isInCombat):
		#print("Not in combat");
		pass
	else:
		if (self.canAttack(delta)):
			attack();
		
		if (self.canCastAbility()):
			castAbility();
	
	pass
	
	
func handle_drag():
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("platform"):
			curr_platform = i
		else:
			curr_platform = null

	# Start dragging the unit
	if Input.is_action_just_pressed("left_mouse") and global_position.distance_to(get_global_mouse_position()) <= $CollisionShape2D.shape.radius:
		initial_pos = global_position
		offset = get_global_mouse_position() - global_position
		is_draggable = true
	if is_draggable:
		if Input.is_action_pressed("left_mouse"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("left_mouse"):
			var tween = get_tree().create_tween()
			is_draggable = false
			if curr_platform and not curr_platform.get_occupied():
				if prev_platform:
					prev_platform.set_occupied(false)
				curr_platform.set_occupied(true)
				initial_pos = position
				prev_platform = curr_platform
				tween.tween_property(self, "position", curr_platform.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initial_pos, 0.2).set_ease(Tween.EASE_OUT)
	
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
