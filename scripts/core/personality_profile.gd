extends Resource
class_name PersonalityProfile

## Perfil de Personalidad del Personaje
## Define la base emocional formada en el útero y el desarrollo de la Inteligencia Emocional.

# --- Temperamento Base (Formado en el útero) ---
# Estos valores NO se pueden cambiar fácilmente. Solo con grandes esfuerzos.
var base_kindness: float = 0.5      # Bondad (0.0 egoísta, 1.0 bondadoso)
var base_resilience: float = 0.5    # Resiliencia (baja tolerancia a la frustración vs alta)
var base_curiosity: float = 0.5     # Curiosidad (miedo a lo nuevo vs explorador)

# --- Inteligencia Emocional (Desarrollada a lo largo de la vida) ---
# Estos son los "Superpoderes". Se ganan con XP.
var eq_calm: float = 0.0        # Calma: Escudo contra la ansiedad
var eq_empathy: float = 0.0     # Empatía: Curación, conexión
var eq_courage: float = 0.0     # Valentía: Fuerza, resistencia
var eq_joy: float = 0.0         # Alegría: Energía, velocidad
var eq_patience: float = 0.0    # Paciencia: Percepción, estrategia

# --- Sistema de Decisiones del Útero ---
var womb_choices_made: Array = []
var current_phase: String = "womb" # "womb", "childhood", "adolescence", "adult"

# --- Señales ---
signal eq_power_leveled(power_name: String, new_level: float)
signal temperament_changed(trait_name: String, new_value: float)

func _init():
	# Valores por defecto equilibrados
	pass

func apply_womb_choice(choice_type: String, intensity: float) -> void:
	## Aplica una elección hecha por la madre/jugador durante la fase de útero.
	## Las elecciones del útero son MÁS poderosas que las de la vida adulta.
	if current_phase != "womb":
		push_warning("No se pueden aplicar elecciones del útero fuera de la fase 'womb'.")
		return
	
	var impact = intensity * 0.2  # Cada vibración tiene un impacto del 20% de su intensidad
	
	match choice_type:
		"positive":
			base_kindness = clampf(base_kindness + impact, 0.0, 1.0)
			base_curiosity = clampf(base_curiosity + (impact * 0.5), 0.0, 1.0)
		"negative":
			base_resilience = clampf(base_resilience + impact, 0.0, 1.0)
			base_curiosity = clampf(base_curiosity - (impact * 0.3), 0.0, 1.0)
		"calm":
			base_resilience = clampf(base_resilience + (impact * 0.5), 0.0, 1.0)
			base_kindness = clampf(base_kindness + (impact * 0.3), 0.0, 1.0)
	
	womb_choices_made.append({
		"type": choice_type,
		"intensity": intensity,
		"phase": current_phase
	})

func grow_eq_power(power: String, amount: float) -> void:
	## Crece un poder de Inteligencia Emocional.
	## La facilidad de crecimiento depende del temperamento base.
	var growth_modifier = 1.0
	match power:
		"calm":
			growth_modifier = 1.0 + (base_resilience * 0.5)
			eq_calm = clampf(eq_calm + (amount * growth_modifier), 0.0, 10.0)
			eq_power_leveled.emit("calm", eq_calm)
		"empathy":
			growth_modifier = 1.0 + (base_kindness * 0.5)
			eq_empathy = clampf(eq_empathy + (amount * growth_modifier), 0.0, 10.0)
			eq_power_leveled.emit("empathy", eq_empathy)
		"courage":
			growth_modifier = 1.0 + ((1.0 - base_resilience) * 0.3) + (base_curiosity * 0.2)
			eq_courage = clampf(eq_courage + (amount * growth_modifier), 0.0, 10.0)
			eq_power_leveled.emit("courage", eq_courage)
		"joy":
			growth_modifier = 1.0 + (base_kindness * 0.3) + (base_curiosity * 0.2)
			eq_joy = clampf(eq_joy + (amount * growth_modifier), 0.0, 10.0)
			eq_power_leveled.emit("joy", eq_joy)
		"patience":
			growth_modifier = 1.0 + (base_resilience * 0.4)
			eq_patience = clampf(eq_patience + (amount * growth_modifier), 0.0, 10.0)
			eq_power_leveled.emit("patience", eq_patience)

func get_temperament_summary() -> Dictionary:
	return {
		"kindness": snappedf(base_kindness, 0.01),
		"resilience": snappedf(base_resilience, 0.01),
		"curiosity": snappedf(base_curiosity, 0.01)
	}

func get_eq_summary() -> Dictionary:
	return {
		"calm": snappedf(eq_calm, 0.01),
		"empathy": snappedf(eq_empathy, 0.01),
		"courage": snappedf(eq_courage, 0.01),
		"joy": snappedf(eq_joy, 0.01),
		"patience": snappedf(eq_patience, 0.01)
	}

func get_total_eq() -> float:
	return eq_calm + eq_empathy + eq_courage + eq_joy + eq_patience

func set_phase(new_phase: String) -> void:
	current_phase = new_phase
