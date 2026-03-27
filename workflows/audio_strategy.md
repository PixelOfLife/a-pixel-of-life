# Workflow: Audio Strategy - "A Pixel of Life"

## Audio es el protagonista principal
La música y el sonido NO son complemento. Son el lenguaje del juego.

---

## Opción 1: Audio Procedural (RECOMENDADA para el juego)
Generar sonidos DIRECTAMENTE en Godot, sin archivos externos.

### Ventajas:
- Cero archivos de audio que descargar
- Se adapta en tiempo real al BPM del juego
- Peso mínimo en el build
- Perfecto para el heartbeat y las ondas

### Godot tiene `AudioStreamGenerator`:
- Genera ondas sinusoidales en tiempo real
- Control total sobre frecuencia, volumen, duración
- Ideal para: heartbeat, ondas de ripple, vibraciones

### Qué generamos proceduralmente:
| Sonido | Método |
|---|---|
| Heartbeat (latido) | Onda sinusoidal + filtro low-pass |
| Ripple (onda expansiva) | Ruido blanco suave con decay |
| Vibración positiva | Tono agudo suave (440Hz+) |
| Vibración negativa | Tono grave tenso (100-200Hz) |
| Vibración calma | Onda lenta (alpha waves ~10Hz modulando tono) |

---

## Opción 2: Tu Voz (PARA DIÁLOGOS - SÍ, GRABATE VOS)

### Por qué tu voz:
- Autenticidad única que ningún TTS puede replicar
- El juego es sobre conexión humana
- La voz de la "madre" es TU voz
- Genera empatía inmediata

### Cómo grabar:
1. **App:** Audacity (gratis) o la app de Grabación de voz del iPhone
2. **Formato:** WAV o OGG (44100 Hz, 16-bit)
3. **Tono:** Suave, cálido, como si hablaras a un bebé
4. **Diálogos a grabar:**
   - "¿Cuál es el sonido del silencio?"
   - "No lo sabemos..."
   - "pero podemos saber..."
   - "cuál es el sonido..."
   - "del comienzo de la vida..."
   - Frases de vibración positiva (amor, alegría)
   - Frases de vibración calma (descanso, paz)
   - Frases de vibración negativa (preocupación, miedo - suave)

### Procesamiento de la voz:
- Reverb ligero (para sensación de espacio)
- Filtro low-pass (para sensación de "dentro del útero")
- Volumen bajo + compresión suave

---

## Opción 3: Recursos Gratuitos

| Fuente | Contenido | Licencia |
|---|---|---|
| **Freesound.org** | Heartbeat, water drops, ambient | CC0 / CC BY |
| **Kenney.nl** | SFX packs completos | CC0 |
| **jsfxr** (online) | Generador de SFX 8-bit | Gratis |
| **ElevenLabs** (free tier) | Generar heartbeat con IA | Gratis (límite) |
| **Pixabay** | Música ambiental | Royalty-free |

---

## Plan de Implementación

### Fase 1: Sonidos Core (Ahora)
1. Script GDScript para generar heartbeat procedural
2. Tu voz grabada para los diálogos
3. Sonido de ripple (gotas) desde Freesound

### Fase 2: Ambiente (Próximo)
1. Música ambiental de fondo (Freesound o generada)
2. Sonidos de vibración (procedural)
3. Efectos de UI (clicks, transiciones)

### Fase 3: Producción (Final)
1. Mezcla final de todos los sonidos
2. Masterización para móviles
3. Compresión de archivos para build

---

## Herramientas Gratuitas para Grabar y Editar

| Herramienta | Plataforma | Uso |
|---|---|---|
| **Audacity** | Mac/Win/Linux | Grabar y editar voz |
| **GarageBand** | Mac/iOS | Grabar con efectos |
| **Voice Memos** | iPhone | Grabación rápida |
| **Ocenaudio** | Mac/Win/Linux | Editor ligero |
| **jsfxr** | Browser | Generar SFX retro |
