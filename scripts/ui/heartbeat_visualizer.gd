extends CanvasLayer
class_name HeartbeatVisualizer

## Visualizador del Latido del Corazón
## Muestra gráficamente el ritmo cardíaco del embrión.
## El color y la intensidad cambian según el estado emocional.

@onready var pulse_circle: ColorRect = $PulseCircle
@onready var bpm_label: Label = $BPMLabel
@onready var state_label: Label = $StateLabel
@onready var wave_line: Line2D = $WaveLine

var music_system: MusicSystem
var personality: PersonalityProfile

var pulse_scale: float = 1.0
var target_scale: float = 1.0
var base_color: Color = Color("#ff99cc")  # Rosa suave (vida)
var current_color: Color = base_color

func _ready():
	music_system = get_node("/root/Main/MusicSystem") if has_node("/root/Main/MusicSystem") else null
	if music_system:
		music_system.beat_occurred.connect(_on_beat)
		music_system.heart_state_changed.connect(_on_state_changed)

func _process(delta: float):
	# Animación suave del pulso
	pulse_scale = lerpf(pulse_scale, target_scale, delta * 8.0)
	if pulse_circle:
		pulse_circle.scale = Vector2(pulse_scale, pulse_scale)
		pulse_circle.color = current_color
	
	# Actualizar BPM
	if music_system and bpm_label:
		bpm_label.text = "BPM: %d" % int(music_system.current_bpm)

func _on_beat(beat_index: int, bpm: float) -> void:
	# Pulso visual
	target_scale = 1.3
	# Regresar a escala base después de un breve momento
	await get_tree().create_timer(0.1).timeout
	target_scale = 1.0
	
	# Actualizar línea de onda si existe
	if wave_line:
		_update_wave(beat_index)

func _on_state_changed(new_state: MusicSystem.HeartState) -> void:
	match new_state:
		MusicSystem.HeartState.CALM:
			current_color = Color("#99ccff")  # Azul claro: calma
			if state_label: state_label.text = "Estado: Tranquilo"
		MusicSystem.HeartState.NORMAL:
			current_color = Color("#ff99cc")  # Rosa: normal
			if state_label: state_label.text = "Estado: Normal"
		MusicSystem.HeartState.HAPPY:
			current_color = Color("#ffcc66")  # Dorado: alegría
			if state_label: state_label.text = "Estado: Feliz"
		MusicSystem.HeartState.DISTRESSED:
			current_color = Color("#cc3333")  # Rojo oscuro: malestar
			if state_label: state_label.text = "Estado: Intranquilo"

func _update_wave(beat_index: int) -> void:
	if wave_line.get_point_count() > 20:
		wave_line.remove_point(0)
	var y_offset = sin(beat_index * 0.5) * 30.0
	wave_line.add_point(Vector2(beat_index * 10, 180 + y_offset))
