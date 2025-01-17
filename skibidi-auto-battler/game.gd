class_name Game

extends Node2D

var platforms : Dictionary= {}; # contains String keys which point to Array[Platform] for a row
var platformsNodeHolder : Node;
var currRow : Array[Platform]
var rowNumber : int;

# Called when the node enters the scene tree for the first time.
func _ready():
	updateToCurrentPlatformInfo();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getCurrentPlatformInfo() -> Dictionary:
	updateToCurrentPlatformInfo()
	return platforms

func updateToCurrentPlatformInfo():
	platformsNodeHolder = self.get_node("Platforms");
	
	platforms.clear();
	
	for row in platformsNodeHolder.get_children():
		currRow = []
		for platform in row.get_children():
			currRow.append(platform);
		platforms[row.name] = currRow;
	
