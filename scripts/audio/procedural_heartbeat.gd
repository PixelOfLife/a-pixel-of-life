extends Node
class_name ProceduralHeartbeat

## Generador de latido cardíaco procedural
## Genera el sonido del corazón en tiempo real, sin archivos externos.

var playback: AudioStreamGeneratorPlayback
var sample_rate: float = 22050.0
var bpm: float = 60.0
var phase: float = 0.0
var beat_phase: float = 0.0

# Forma del latido: dos pulsos (lub-dub)
var beat_sequence = [
	{"freq": 50.0, "duration": 0.08, "volume": 0.6},   # lub
	{"freq": 0.0, "duration": 0.06, "volume": 0.0},     # pausa
	{"freq": 65.0, "duration": 0.06, "volume": 0.4},    # dub
	{"freq": 0.0, "duration": 0.0, "volume": 0.0},      # silencio hasta next beat
]
var current_step = 0
var step_timer = 0.0
var is_playing_beat = false

func _ready():
	_setup_audio()

func _setup_audio():
	var stream = AudioStreamGenerator.new()
	stream.mix_rate = sample_rate
	stream.buffer_length = 0.1
	
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.bus = "Master"
	add_child(player)
	player.play()
	playback = player.get_stream_playback()

func set_bpm(new_bpm: float):
	bpm = clampf(new_bpm, 40.0, 180.0)

func _process(delta):
	if playback == null:
		return
	
	var frames_available = playback.get_frames_available()
	var beat_interval = 60.0 / bpm
	
	beat_phase += delta
	
	# Iniciar nuevo latido
	if beat_phase >= beat_interval:
		beat_phase -= beat_interval
		current_step = 0
		step_timer = 0.0
		is_playing_beat = true
	
	for i in range(frames_available):
		var sample = 0.0
		
		if is_playing_beat and current_step < beat_sequence.size():
			var step = beat_sequence[current_step]
			step_timer += 1.0 / sample_rate
			
			if step["freq"] > 0:
				# Generar tono con envelope suave
				var t = step_timer / step["duration"]
				var envelope = 1.0
				if t < 0.1:
					envelope = t / 0.1  # Attack
				elif t > 0.5:
					envelope = (1.0 - t) / 0.5  # Decay
				
				envelope = clampf(envelope, 0.0, 1.0)
				sample = sin(phase * TAU) * step["volume"] * envelope
				phase += step["freq"] / sample_rate
				if phase >= 1.0:
					phase -= 1.0
			else:
				step_timer += 1.0 / sample_rate
			
			# Avanzar al siguiente paso
			if step["duration"] > 0 and step_timer >= step["duration"]:
				current_step += 1
				step_timer = 0.0
				if current_step >= beat_sequence.size():
					is_playing_beat = false
		
		playback.push_frame(Vector2(sample, sample))
