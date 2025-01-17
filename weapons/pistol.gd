extends "res://Scripts/weapones.gd"  # Inherit from Weapons base script

# Optionally override the shoot() method
func shoot():
	super.shoot()  # Call the base class method (optional if no changes needed)
	print("Pistol pew pew")
