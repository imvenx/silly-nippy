extends Node3D

var pad: ArcanePad
var speed = 1.5
var playerRotation := Quaternion.IDENTITY

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout

	pad = Arcane.pads[0]
	pad.startGetQuaternion()
	pad.onGetQuaternion(onGetQuaternion2)
	

func _process(delta: float) -> void:
	translate(Vector3(0, 0, speed * delta))
	
	# Apply rotation incrementally to avoid scale issues
	var rotation_basis = Basis(playerRotation.normalized())
	#transform.basis = rotation_basis * transform.basis
	var scale = transform.basis.get_scale()  # Preserve the current scale
	transform.basis = Basis(playerRotation).scaled(scale)  # Apply rotation and restore scale

func onGetQuaternion2(e):
	if e.w == null or e.x == null or e.y == null or e.z == null:
		return
	#playerRotation.x = -e.x
	playerRotation.y = -e.y
	#playerRotation.z = e.z
	playerRotation.w = e.w

	# Normalize the quaternion to prevent scaling issues
	playerRotation = playerRotation.normalized()
