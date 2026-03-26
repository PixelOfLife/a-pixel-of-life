extends Node2D

## Escena de Apertura: "El Primer Latido"
## Una célula que respira, un diálogo poético, y el primer latido como una gota en un estanque.

var dialogue_lines = [
	"¿Cuál es el sonido del silencio?",
	"No lo sabemos...",
	"pero podemos saber...",
	"cuál es el sonido...",
	"del comienzo de la vida..."
]

var current_line = 0
var dialogue_finished = false
var ripple_active = false
var heartbeat_active = false

@onready var cell = $Cell
@onready var cell_glow = $Cell/Glow
@onready var label = $DialogueLabel
@onready var ripple_container = $RippleContainer

var heartbeat_timer = 0.0
var heartbeat_interval = 1.0  # 60 BPM inicial
var ripple_count = 0

func _ready():
	label.modulate.a = 0.0
	cell.modulate.a = 0.0
	cell_glow.modulate.a = 0.0
	
	# Secuencia de inicio
	await get_tree().create_timer(1.5).timeout
	_fade_in_cell()
	await get_tree().create_timer(2.0).timeout
	_start_dialogue()

func _process(delta):
	if heartbeat_active:
		heartbeat_timer += delta
		if heartbeat_timer >= heartbeat_interval:
			heartbeat_timer -= heartbeat_interval
			_spawn_ripple()
	
	# Respiración de la célula
	if not dialogue_finished and cell.modulate.a > 0:
		var breath = sin(Time.get_ticks_msec() * 0.002) * 0.15
		cell.scale = Vector2(1.0 + breath, 1.0 + breath)
		cell_glow.modulate.a = 0.3 + breath * 0.5

func _fade_in_cell():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(cell, "modulate:a", 1.0, 2.0)
	tween.tween_property(cell_glow, "modulate:a", 0.3, 2.0)
	tween.tween_property(cell, "scale", Vector2(1.0, 1.0), 2.0).from(Vector2(0.0, 0.0))

func _start_dialogue():
	for i in dialogue_lines.size():
		_show_line(dialogue_lines[i])
		await get_tree().create_timer(3.0).timeout
		_hide_line()
		await get_tree().create_timer(0.5).timeout
	
	dialogue_finished = true
	await get_tree().create_timer(1.0).timeout
	_transition_to_heartbeat()

func _show_line(text: String):
	label.text = text
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.8)

func _hide_line():
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 0.6)

func _transition_to_heartbeat():
	# La célula se disipa hacia afuera
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(cell, "scale", Vector2(3.0, 3.0), 1.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell, "modulate:a", 0.0, 1.5).set_ease(Tween.EASE_IN)
	tween.tween_property(cell_glow, "scale", Vector2(4.0, 4.0), 1.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell_glow, "modulate:a", 0.0, 1.5).set_ease(Tween.EASE_IN)
	
	await tween.finished
	
	# Un punto sutil queda, empieza el latido
	cell.visible = false
	cell_glow.visible = false
	heartbeat_active = true
	
	# Mostrar hint
	label.text = "siente..."
	label.modulate.a = 0.0
	var hint_tween = create_tween()
	hint_tween.tween_property(label, "modulate:a", 0.5, 1.0)

func _spawn_ripple():
	ripple_count += 1
	
	# Crear onda expansiva (como gota en estanque)
	var ripple = ColorRect.new()
	ripple.color = Color(1.0, 0.6, 0.8, 0.4)  # Rosa suave
	ripple.offset_left = -2
	ripple.offset_top = -2
	ripple.offset_right = 2
	ripple.offset_bottom = 2
	ripple.pivot_offset = Vector2(2, 2)
	ripple.position = Vector2(320, 180)
	ripple_container.add_child(ripple)
	
	# Animación de expansión delicada
	var duration = 3.0
	var max_size = 120.0 + (ripple_count * 10)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ripple, "scale", Vector2(max_size, max_size), duration).set_ease(Tween.EASE_OUT)
	tween.tween_property(ripple, "modulate:a", 0.0, duration).set_ease(Tween.EASE_IN)
	
	await tween.finished
	ripple.queue_free()
