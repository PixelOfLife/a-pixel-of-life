# Core Mechanic: Idle Hint System (Anti-Boredom)

## Concept
When the player hasn't interacted for 5 seconds, the game provides subtle hints to guide them. These hints are poetic, encouraging, and never condescending. They keep the player engaged and prevent frustration.

## Hint Categories

### Directional Hints (Where to go)
- "Presta atención a la luz..."
- "El ritmo te guía hacia..."
- "Siente hacia dónde vibra..."
- "La energía fluye hacia..."

### Action Hints (What to do)
- "Presta atención al sonido..."
- "Escucha el latido..."
- "Responde a la vibración..."
- "Siente la conexión..."

### Emotional Hints (What to feel)
- "La calma te envuelve..."
- "La luz te protege..."
- "El ritmo es tu aliado..."
- "Confía en tu instinto..."

### Mystery Hints (Create curiosity)
- "¿Qué hay más allá de la luz?"
- "¿Qué te está esperando?"
- "¿Sientes esa presencia?"
- "Algo nuevo se acerca..."

## Timing System

| Inactividad | Tipo de Hint | Intensidad |
|---|---|---|
| 5 segundos | Susurro suave | Baja (solo texto pequeño) |
| 10 segundos | Texto claro | Media (texto legible) |
| 15 segundos | Pulsación visual | Alta (elemento visual pulsa) |
| 20 segundos | Sonido guía | Muy alta (melodía direccional) |

## Implementation

### IdleTimer
```gdscript
extends Node

signal idle_hint(level: int)

@export var hint_interval: float = 5.0
var idle_time: float = 0.0
var hint_level: int = 0
var is_active: bool = true

func _process(delta: float):
    if not is_active:
        return
    
    idle_time += delta
    
    if idle_time >= hint_interval * (hint_level + 1):
        hint_level = min(hint_level + 1, 3)
        idle_hint.emit(hint_level)

func reset_idle() -> void:
    idle_time = 0.0
    hint_level = 0
```

### HintDisplay
```gdscript
extends CanvasLayer

@onready var hint_label: Label = $HintLabel
@onready var hint_tween: Tween

var hint_texts = {
    1: ["Presta atención a la luz...", "El ritmo te guía...", "Siente la vibración..."],
    2: ["Escucha el latido...", "Responde a la conexión...", "La energía fluye..."],
    3: ["¿Qué hay más allá?", "Algo nuevo se acerca...", "Confía en tu instinto..."]
}

func show_hint(level: int) -> void:
    var texts = hint_texts.get(level, hint_texts[1])
    var text = texts[randi() % texts.size()]
    
    hint_label.text = text
    hint_label.modulate.a = 0.0
    
    if hint_tween:
        hint_tween.kill()
    
    hint_tween = create_tween()
    hint_tween.tween_property(hint_label, "modulate:a", 1.0, 0.5)
    hint_tween.tween_interval(3.0)
    hint_tween.tween_property(hint_label, "modulate:a", 0.0, 0.5)
```

## Integration Points
- **Every scene:** IdleTimer is always active
- **Every input:** Calls `reset_idle()` when player interacts
- **Contextual hints:** Hint texts change based on current scene/chapter
- **Never blocks:** Hints are subtle overlays, never interrupt gameplay
