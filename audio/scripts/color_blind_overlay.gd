extends CanvasLayer

@onready var shader_material: ShaderMaterial = $ColorRect.material

func set_mode(mode: int) -> void:
	if shader_material: # Vérifie que le matériel existe
		shader_material.set_shader_parameter("mode", mode)
	else:
		push_warning("ShaderMaterial manquant sur ColorRect !")
