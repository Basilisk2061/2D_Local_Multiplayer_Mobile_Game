extends CharacterBody2D


const SPEED = 500.0
const JETPACK_FORCE = -700.0
const GRAVITY = 1000.0
const MAX_FUEL = 100.0  # Maximum fuel capacity
const FUEL_USAGE_RATE = 30.0  # Fuel consumed per second
const FUEL_REGEN_RATE = 10.0  # Fuel restored per second
const MIN_FUEL_FOR_JETPACK = 10.0  # Minimum fuel required for the jetpack to function
var current_fuel = MAX_FUEL

func _physics_process(delta: float) -> void:
	# Add the gravity if no fuel in jetpack.
	if not Input.is_action_pressed("Up") or current_fuel <= MIN_FUEL_FOR_JETPACK:
		velocity.y += GRAVITY * delta

	# Handle jetpack movement when holding the "Up" key and there's fuel
	if Input.is_action_pressed("Up") and current_fuel > MIN_FUEL_FOR_JETPACK:
		velocity.y = JETPACK_FORCE
		current_fuel -=  FUEL_USAGE_RATE * delta
		current_fuel = max(current_fuel, MIN_FUEL_FOR_JETPACK)
		
	  # Regenerate fuel over time when not using the jetpack
	if  not Input.is_action_pressed("Up") and current_fuel < MAX_FUEL:
		current_fuel += FUEL_REGEN_RATE * delta
		current_fuel = min(current_fuel, MAX_FUEL)  # Ensure fuel doesn't exceed max capacity

	 # Handle jumping when on the floor and no jetpack fuel is left
	if Input.is_action_just_pressed("Up") and is_on_floor() and current_fuel <= MIN_FUEL_FOR_JETPACK:
		velocity.y = JETPACK_FORCE

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	print(current_fuel)
