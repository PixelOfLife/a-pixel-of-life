extends Node
class_name VibrationSystem

## Sistema de Vibraciones
## Traduce las "palabras" de la madre/usuario en vibraciones que el embrión percibe.
## Vibraciones blancas/claras = positivas (alegría, amor)
## Vibraciones oscuras = negativas (estrés, enojo)
## Vibraciones suaves = calma (descanso, ternura)

signal vibration_received(vibration_type: String, intensity: float, visual_color: Color)

enum VibrationType {
	LIGHT,   # Blanca/Clara: positiva, alegría
	DARK,    # Oscura: negativa, estrés
	SOFT,    # Suave: calma, descanso
	NEUTRAL  # Neutral: sin impacto emocional fuerte
}

var vibration_colors = {
	VibrationType.LIGHT: Color("#ffffff", 0.7),      # Blanco brillante
	VibrationType.DARK: Color("#330033", 0.7),       # Púrpura oscuro
	VibrationType.SOFT: Color("#aaccff", 0.5),       # Azul muy suave
	VibrationType.NEUTRAL: Color("#cccccc", 0.3)     # Gris claro
}

var vibration_history: Array = []
var max_history: int = 50

func receive_vibration(text: String, intensity: float = 0.5) -> void:
	## Procesa un texto y genera la vibración correspondiente
	var v_type = _classify_text(text)
	var color = vibration_colors[v_type]
	var clamped_intensity = clampf(intensity, 0.1, 1.0)
	
	# Guardar en historial
	vibration_history.append({
		"text": text,
		"type": VibrationType.keys()[v_type],
		"intensity": clamped_intensity,
		"time": Time.get_ticks_msec()
	})
	
	if vibration_history.size() > max_history:
		vibration_history.pop_front()
	
	# Emitir señal
	vibration_received.emit(VibrationType.keys()[v_type], clamped_intensity, color)

func _classify_text(text: String) -> VibrationType:
	var lower = text.to_lower()
	
	# Palabras que generan luz (positivas)
	var light_words = [
		"amor", "feliz", "alegria", "lindo", "bonito", "hermoso",
		"sonrisa", "beso", "abrazo", "cariño", "dulce", "amado"
	]
	
	# Palabras que generan oscuridad (negativas)
	var dark_words = [
		"miedo", "triste", "enojo", "enfadado", "dolor", "odio",
		"bravo", "terrible", "horrible", "feo", "malo"
	]
	
	# Palabras que generan calma (suaves)
	var soft_words = [
		"calma", "tranquilo", "descanso", "sueño", "nana",
		"suave", "silencio", "gentil", "tierno", "acunar"
	]
	
	var light_score = 0
	var dark_score = 0
	var soft_score = 0
	
	for word in light_words:
		if lower.contains(word):
			light_score += 1
	for word in dark_words:
		if lower.contains(word):
			dark_score += 1
	for word in soft_words:
		if lower.contains(word):
			soft_score += 1
	
	if soft_score > 0 and soft_score >= light_score and soft_score >= dark_score:
		return VibrationType.SOFT
	elif light_score > dark_score:
		return VibrationType.LIGHT
	elif dark_score > light_score:
		return VibrationType.DARK
	else:
		return VibrationType.NEUTRAL

func get_recent_vibrations(count: int = 10) -> Array:
	var start = max(0, vibration_history.size() - count)
	return vibration_history.slice(start)

func get_vibration_balance() -> Dictionary:
	## Retorna el balance de vibraciones recibidas (útil para determinar temperamento)
	var light = 0
	var dark = 0
	var soft = 0
	var total = vibration_history.size()
	
	if total == 0:
		return {"light": 0.0, "dark": 0.0, "soft": 0.0, "total": 0}
	
	for v in vibration_history:
		match v["type"]:
			"LIGHT": light += 1
			"DARK": dark += 1
			"SOFT": soft += 1
	
	return {
		"light": float(light) / total,
		"dark": float(dark) / total,
		"soft": float(soft) / total,
		"total": total
	}
