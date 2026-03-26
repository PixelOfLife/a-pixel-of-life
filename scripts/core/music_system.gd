extends Node
class_name MusicSystem

## Sistema Central de Música y Ritmo
## El latido del corazón como primer lenguaje de comunicación del personaje.

signal beat_occurred(beat_index: int, bpm: float)
signal heart_state_changed(new_state: HeartState)
signal emotion_detected(emotion: String, intensity: float)

enum HeartState {
	CALM,      # BPM bajo: tranquilidad, sueño
	NORMAL,    # BPM base: estado normal del embrión
	HAPPY,     # BPM moderado-alto: alegría, respuesta a estímulos positivos
	DISTRESSED # BPM alto: malestar, respuesta a estímulos negativos
}

@export var base_bpm: float = 120.0
@export var current_bpm: float = 120.0

var heart_state: HeartState = HeartState.NORMAL
var beat_index: int = 0
var beat_timer: float = 0.0
var beat_interval: float = 0.0

func _ready():
	_update_beat_interval()
	heart_state_changed.connect(_on_heart_state_changed)

func _process(delta: float):
	beat_timer += delta
	if beat_timer >= beat_interval:
		beat_timer -= beat_interval
		beat_index += 1
		beat_occurred.emit(beat_index, current_bpm)

func set_heart_state(new_state: HeartState) -> void:
	if heart_state == new_state:
		return
	heart_state = new_state
	match heart_state:
		HeartState.CALM:
			current_bpm = 80.0
		HeartState.NORMAL:
			current_bpm = base_bpm
		HeartState.HAPPY:
			current_bpm = base_bpm + 20.0
		HeartState.DISTRESSED:
			current_bpm = base_bpm + 40.0
	_update_beat_interval()
	heart_state_changed.emit(heart_state)

func process_text_input(text: String) -> void:
	## Analiza el texto introducido por el usuario y emite una emoción detectada
	var emotion = _analyze_text_emotion(text)
	var intensity = _calculate_intensity(text)
	emotion_detected.emit(emotion, intensity)
	_apply_emotion_to_heartbeat(emotion, intensity)

func _analyze_text_emotion(text: String) -> String:
	var lower_text = text.to_lower()
	# Palabras positivas
	var positive_words = [
		"amor", "feliz", "alegria", "amable", "cariño", "paz",
		"lindo", "bonito", "hermoso", "dulce", "tierno", "bueno"
	]
	# Palabras negativas
	var negative_words = [
		"miedo", "triste", "enfadado", "enojo", "dolor", "mal",
		"feo", "horrible", "terrible", "odio", "malo", "bravo"
	]
	# Palabras neutras/compasivas
	var calm_words = [
		"calma", "tranquilo", "descanso", "sueño", "suave",
		"silencio", "gentil", "sereno", "placido"
	]
	
	var pos_score = 0.0
	var neg_score = 0.0
	var calm_score = 0.0
	
	for word in positive_words:
		if lower_text.contains(word):
			pos_score += 1.0
	for word in negative_words:
		if lower_text.contains(word):
			neg_score += 1.0
	for word in calm_words:
		if lower_text.contains(word):
			calm_score += 1.0
	
	if calm_score > 0 and calm_score >= pos_score and calm_score >= neg_score:
		return "calm"
	elif pos_score > neg_score:
		return "positive"
	elif neg_score > pos_score:
		return "negative"
	else:
		return "neutral"

func _calculate_intensity(text: String) -> float:
	var length_factor = clampf(text.length() / 50.0, 0.0, 1.0)
	var exclamation_factor = 0.0
	if text.contains("!"):
		exclamation_factor = clampf(text.count("!") * 0.2, 0.0, 0.6)
	return clampf(length_factor + exclamation_factor, 0.1, 1.0)

func _apply_emotion_to_heartbeat(emotion: String, intensity: float) -> void:
	match emotion:
		"positive":
			set_heart_state(HeartState.HAPPY)
		"negative":
			set_heart_state(HeartState.DISTRESSED)
		"calm":
			set_heart_state(HeartState.CALM)
		"neutral":
			set_heart_state(HeartState.NORMAL)

func _update_beat_interval() -> void:
	if current_bpm > 0:
		beat_interval = 60.0 / current_bpm

func _on_heart_state_changed(new_state: HeartState) -> void:
	# Placeholder para efectos visuales y de sonido
	pass
