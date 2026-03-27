extends Node2D

## Escena de Apertura - "A Pixel of Life"
## Célula → Diálogo con voz argentina → Heartbeat interactivo

@onready var cell = $Cell
@onready var label = $DialogueLabel
@onready var ripple_container = $RippleContainer
@onready var voice_player = $VoicePlayer

var dialogue_data = [
	{"text": "¿Cuál es el sonido del silencio?", "voice": "res://assets/audio/voice/intro_01.mp3"},
	{"text": "No lo sabemos...", "voice": "res://assets/audio/voice/intro_02.mp3"},
	{"text": "pero podemos saber...", "voice": "res://assets/audio/voice/intro_03.mp3"},
	{"text": "cuál es el sonido...", "voice": "res://assets/audio/voice/intro_04.mp3"},
	{"text": "del comienzo de la vida...", "voice": "res://assets/audio/voice/intro_05.mp3"},
]

var hint_texts = ["siente...", "escucha...", "presta atención...", "el ritmo te guía...", "responde..."]

var phase = "init"
var heartbeat_timer = 0.0
var heartbeat_interval = 1.0
var ripple_count = 0
var hint_timer = 0.0
var hint_interval = 5.0
var current_hint = 0
var interaction_count = 0

func _ready():
	_setup_reverb()
	label.modulate.a = 0.0
	cell.modulate.a = 0.0
	
	await get_tree().create_timer(2.0).timeout
	phase = "cell"
	_fade_in_cell()
	
	await get_tree().create_timer(3.0).timeout
	phase = "dialogue"
	_start_dialogue()

func _setup_reverb():
	var reverb = AudioEffectReverb.new()
	reverb.pre_delay = 0.2
	reverb.wet = 0.4
	reverb.damping = 0.6
	reverb.filter_cutoff = 400
	
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.add_bus_effect(bus_idx, reverb, 0)
	AudioServer.set_bus_volume_db(bus_idx, -3.0)

func _process(delta):
	if phase == "cell" or phase == "dialogue":
		var breath = sin(Time.get_ticks_msec() * 0.002) * 0.15
		cell.scale = Vector2(1.0 + breath, 1.0 + breath)
	
	if phase == "heartbeat":
		heartbeat_timer += delta
		if heartbeat_timer >= heartbeat_interval:
			heartbeat_timer -= heartbeat_interval
			_beat()
		
		hint_timer += delta
		if hint_timer >= hint_interval:
			hint_timer = 0.0
			_show_hint()

func _unhandled_input(event):
	if phase == "heartbeat" and event.is_action_pressed("ui_accept"):
		_on_player_interaction()

func _fade_in_cell():
	var tween = create_tween()
	tween.tween_property(cell, "modulate:a", 0.6, 2.0)
	tween.tween_property(cell, "scale", Vector2(1.0, 1.0), 2.0).from(Vector2(0.0, 0.0))

func _start_dialogue():
	for line in dialogue_data:
		_play_voice(line["voice"])
		_show_line(line["text"])
		await get_tree().create_timer(4.0).timeout
		_hide_line()
		await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(1.0).timeout
	phase = "dissolve"
	_dissolve_cell()
	await get_tree().create_timer(2.0).timeout
	phase = "heartbeat"
	_start_heartbeat()

func _play_voice(path: String):
	if ResourceLoader.exists(path):
		voice_player.stream = load(path)
		voice_player.volume_db = -5.0
		voice_player.play()

func _show_line(text: String):
	label.text = text
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.8, 0.8)

func _hide_line():
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 0.6)

func _dissolve_cell():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(cell, "scale", Vector2(4.0, 4.0), 1.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(cell, "modulate:a", 0.0, 1.5)

func _start_heartbeat():
	cell.visible = false
	await get_tree().create_timer(1.5).timeout
	_show_hint()

func _beat():
	ripple_count += 1
	
	var ring = ColorRect.new()
	ring.color = Color(0.5, 0.55, 0.6, 0.35)
	ring.offset_left = -3
	ring.offset_top = -3
	ring.offset_right = 3
	ring.offset_bottom = 3
	ring.pivot_offset = Vector2(3, 3)
	ring.position = Vector2(-3, -3)
	ripple_container.add_child(ring)
	
	var ring_outer = ColorRect.new()
	ring_outer.color = Color(0.3, 0.35, 0.4, 0.15)
	ring_outer.offset_left = -2
	ring_outer.offset_top = -2
	ring_outer.offset_right = 2
	ring_outer.offset_bottom = 2
	ring_outer.pivot_offset = Vector2(2, 2)
	ring_outer.position = Vector2(-2, -2)
	ripple_container.add_child(ring_outer)
	
	var tween1 = create_tween()
	tween1.set_parallel(true)
	tween1.tween_property(ring, "scale", Vector2(80, 80), 2.5).set_ease(Tween.EASE_OUT)
	tween1.tween_property(ring, "modulate:a", 0.0, 2.5).set_ease(Tween.EASE_IN)
	
	var tween2 = create_tween()
	tween2.set_parallel(true)
	tween2.tween_property(ring_outer, "scale", Vector2(140, 140), 3.0).set_ease(Tween.EASE_OUT)
	tween2.tween_property(ring_outer, "modulate:a", 0.0, 3.0).set_ease(Tween.EASE_IN)
	
	tween1.finished.connect(ring.queue_free)
	tween2.finished.connect(ring_outer.queue_free)
	
	_play_heartbeat_sound()

func _on_player_interaction():
	interaction_count += 1
	
	var pulse = ColorRect.new()
	pulse.color = Color(0.7, 0.75, 0.8, 0.4)
	pulse.offset_left = -5
	pulse.offset_top = -5
	pulse.offset_right = 5
	pulse.offset_bottom = 5
	pulse.pivot_offset = Vector2(5, 5)
	pulse.position = Vector2(-5, -5)
	ripple_container.add_child(pulse)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(pulse, "scale", Vector2(60, 60), 1.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(pulse, "modulate:a", 0.0, 1.5)
	tween.finished.connect(pulse.queue_free)
	
	if interaction_count == 1:
		_show_temp_text("sientes...", 2.0)
	elif interaction_count == 3:
		_show_temp_text("bien...", 2.0)
	elif interaction_count == 5:
		_show_temp_text("sigue...", 2.0)

func _show_temp_text(text: String, duration: float):
	label.text = text
	label.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.6, 0.5)
	tween.tween_interval(duration)
	tween.tween_property(label, "modulate:a", 0.0, 0.5)

func _play_heartbeat_sound():
	# Sonidos graves (40-50Hz) para sensación de sumergido
	var lub = _make_tone(40, 0.15, 0.2)
	lub.play()
	await get_tree().create_timer(0.15).timeout
	var dub = _make_tone(50, 0.12, 0.15)
	dub.play()

func _make_tone(freq: float, duration: float, volume: float) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	var stream = AudioStreamGenerator.new()
	stream.mix_rate = 11025.0
	stream.buffer_length = duration + 0.1
	player.stream = stream
	player.volume_db = linear_to_db(volume)
	add_child(player)
	player.play()
	
	var playback = player.get_stream_playback()
	var samples = int(11025.0 * duration)
	var p = 0.0
	for i in range(samples):
		var t = float(i) / float(samples)
		var env = 1.0
		if t < 0.05: env = t / 0.05
		elif t > 0.6: env = (1.0 - t) / 0.4
		env = clampf(env, 0.0, 1.0)
		playback.push_frame(Vector2(sin(p * TAU) * env, sin(p * TAU) * env))
		p += freq / 11025.0
		if p >= 1.0: p -= 1.0
	
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