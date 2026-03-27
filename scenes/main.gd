extends Node2D

## Escena de Apertura - "A Pixel of Life"
## Célula que respira → Diálogo con voz → Latido como gota en estanque

# --- Referencias ---
@onready var cell = $Cell
@onready var cell_glow = $Cell/Glow
@onready var label = $DialogueLabel
@onready var ripple_container = $RippleContainer
@onready var voice_player = $VoicePlayer
@onready var heartbeat_player = $HeartbeatPlayer
@onready var ripple_player = $RipplePlayer

# --- Diálogo con voces ---
var dialogue_data = [
	{"text": "¿Cuál es el sonido del silencio?", "voice": "res://assets/audio/voice/intro_01.mp3"},
	{"text": "No lo sabemos...", "voice": "res://assets/audio/voice/intro_02.mp3"},
	{"text": "pero podemos saber...", "voice": "res://assets/audio/voice/intro_03.mp3"},
	{"text": "cuál es el sonido...", "voice": "res://assets/audio/voice/intro_04.mp3"},
	{"text": "del comienzo de la vida...", "voice": "res://assets/audio/voice/intro_05.mp3"},
]

var hint_texts = [
	"siente...",
	"escucha...",
	"presta atención...",
	"el ritmo te guía...",
]

# --- Estado ---
var phase = "init"  # init → cell → dialogue → dissolve → heartbeat
var heartbeat_timer = 0.0
var heartbeat_interval = 1.0  # 60 BPM
var ripple_count = 0
var hint_timer = 0.0
var hint_interval = 5.0
var current_hint = 0

func _ready():
	label.modulate.a = 0.0
	cell.modulate.a = 0.0
	cell_glow.modulate.a = 0.0
	
	# Iniciar secuencia
	await get_tree().create_timer(2.0).timeout
	phase = "cell"
	_fade_in_cell()
	
	await get_tree().create_timer(3.0).timeout
	phase = "dialogue"
	_start_dialogue()

func _process(delta):
	# Respiración de la célula
	if phase == "cell" or phase == "dialogue":
		var breath = sin(Time.get_ticks_msec() * 0.002) * 0.15
		cell.scale = Vector2(1.0 + breath, 1.0 + breath)
		cell_glow.modulate.a = 0.3 + breath * 0.5
	
	# Heartbeat + ondas
	if phase == "heartbeat":
		heartbeat_timer += delta
		if heartbeat_timer >= heartbeat_interval:
			heartbeat_timer -= heartbeat_interval
			_spawn_ripple()
			_play_heartbeat_sound()
		
		# Hint cada 5 segundos
		hint_timer += delta
		if hint_timer >= hint_interval:
			hint_timer = 0.0
			_show_hint()

func _fade_in_cell():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(cell, "modulate:a", 1.0, 2.0).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell_glow, "modulate:a", 0.3, 2.0).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell, "scale", Vector2(1.0, 1.0), 2.0).from(Vector2(0.0, 0.0))

func _start_dialogue():
	for line in dialogue_data:
		# Reproducir voz
		_play_voice(line["voice"])
		
		# Mostrar texto
		_show_line(line["text"])
		
		# Esperar a que termine la voz + pausa
		await get_tree().create_timer(3.5).timeout
		_hide_line()
		await get_tree().create_timer(0.5).timeout
	
	# Transición al heartbeat
	await get_tree().create_timer(1.0).timeout
	phase = "dissolve"
	_dissolve_cell()
	
	await get_tree().create_timer(2.0).timeout
	phase = "heartbeat"
	_start_heartbeat()

func _play_voice(path: String):
	if ResourceLoader.exists(path):
		var stream = load(path)
		if stream:
			voice_player.stream = stream
			voice_player.volume_db = -5.0
			voice_player.play()

func _show_line(text: String):
	label.text = text
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.8)

func _hide_line():
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 0.6)

func _dissolve_cell():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(cell, "scale", Vector2(4.0, 4.0), 1.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell, "modulate:a", 0.0, 1.5).set_ease(Tween.EASE_IN)
	tween.tween_property(cell_glow, "scale", Vector2(6.0, 6.0), 1.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell_glow, "modulate:a", 0.0, 1.5).set_ease(Tween.EASE_IN)
	
	# Sonido de disolución (onda baja)
	_play_dissolve_sound()

func _start_heartbeat():
	cell.visible = false
	cell_glow.visible = false
	
	# Primer hint
	await get_tree().create_timer(2.0).timeout
	_show_hint()

func _spawn_ripple():
	ripple_count += 1
	
	var ripple = ColorRect.new()
	ripple.color = Color(1.0, 0.6, 0.8, 0.35)
	ripple.offset_left = -2
	ripple.offset_top = -2
	ripple.offset_right = 2
	ripple.offset_bottom = 2
	ripple.pivot_offset = Vector2(2, 2)
	ripple.position = Vector2(-2, -2)
	ripple_container.add_child(ripple)
	
	var duration = 3.5
	var max_size = 100.0 + (ripple_count * 8)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ripple, "scale", Vector2(max_size, max_size), duration).set_ease(Tween.EASE_OUT)
	tween.tween_property(ripple, "modulate:a", 0.0, duration).set_ease(Tween.EASE_IN)
	
	await tween.finished
	ripple.queue_free()

func _play_heartbeat_sound():
	# Generar sonido procedural "lub-dub" usando AudioStreamPlayer
	# Dos tonos cortos: grave + agudo
	var lub = _create_tone_player(55, 0.1, 0.3)
	lub.play()
	await get_tree().create_timer(0.12).timeout
	var dub = _create_tone_player(70, 0.08, 0.2)
	dub.play()

func _play_dissolve_sound():
	# Onda grave larga
	var dissolve = _create_tone_player(40, 0.8, 0.15)
	dissolve.play()

func _create_tone_player(freq: float, duration: float, volume: float) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	var stream = AudioStreamGenerator.new()
	stream.mix_rate = 11025.0
	stream.buffer_length = duration + 0.1
	player.stream = stream
	player.volume_db = linear_to_db(volume)
	add_child(player)
	
	# Generar el tono
	player.play()
	var playback = player.get_stream_playback()
	var samples = int(11025.0 * duration)
	var phase_val = 0.0
	
	for i in range(samples):
		var t = float(i) / float(samples)
		var envelope = 1.0
		if t < 0.05:
			envelope = t / 0.05
		elif t > 0.6:
			envelope = (1.0 - t) / 0.4
		envelope = clampf(envelope, 0.0, 1.0)
		
		var sample = sin(phase_val * TAU) * envelope
		phase_val += freq / 11025.0
		if phase_val >= 1.0:
			phase_val -= 1.0
		playback.push_frame(Vector2(sample, sample))
	
	# Auto-remover después de reproducir
	player.finished.connect(func(): player.queue_free())
	
	return player

func _show_hint():
	var text = hint_texts[current_hint % hint_texts.size()]
	current_hint += 1
	
	label.text = text
	label.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.4, 0.8)
	tween.tween_interval(3.0)
	tween.tween_property(label, "modulate:a", 0.0, 0.8)
