# Plan de Generación de Voz AI - "A Pixel of Life"

## Herramientas Recomendadas (Gratis / Freemium)

### 1. ElevenLabs (MEJOR CALIDAD)
- **URL:** https://elevenlabs.io
- **Gratis:** 10,000 caracteres/mes
- **Voces:** Español con emociones (whisper, calm, warm)
- **Formato:** MP3/WAV descargable
- **Ventaja:** La más natural y emocional del mercado

### 2. Murf AI (BUENA ALTERNATIVA)
- **URL:** https://murf.ai
- **Gratis:** 10 minutos de voz
- **Voces:** Español España + Latinoamérica
- **Formato:** MP3/WAV

### 3. Voice.ai (TOTALMENTE GRATIS)
- **URL:** https://voice.ai
- **Gratis:** Sin límite aparente
- **Voces:** Español con tonos variados
- **Formato:** MP3

---

## Frases a Generar

### Diálogo de Apertura (Escena 1 - Oscuridad)
```
¿Cuál es el sonido del silencio?
No lo sabemos...
pero podemos saber...
cuál es el sonido...
del comienzo de la vida...
```

### Vibraciones Positivas (conexión con la madre)
```
Te quiero...
Todo está bien...
Estoy aquí contigo...
Eres fuerte...
Siente la luz...
```

### Vibraciones de Calma
```
Descansa...
Cierra los ojos...
Todo está en paz...
Duerme tranquilo...
La calma te envuelve...
```

### Vibraciones de Preocupación (suave, no agresivo)
```
No tengas miedo...
Estoy preocupada...
Necesito que estés bien...
Todo va a mejorar...
```

### Hint del Sistema
```
siente...
escucha...
presta atención...
el ritmo te guía...
```

---

## Configuración de Voz Ideal

| Parámetro | Valor | Razón |
|---|---|---|
| **Tono** | Femenino, cálido | Sensación materna |
| **Velocidad** | Lenta (0.8x) | Tranquilidad, intimidad |
| **Emoción** | Calm / Whisper / Warm | Conexión emocional |
| **Acento** | Latino neutro o Rioplatense | Coherencia con el usuario |
| **Reverb** | Alto | Sensación de espacio interior |
| **Filtro** | Low-pass suave | Sensación de "dentro del útero" |

---

## Pipeline de Procesamiento

1. **Generar** voz con ElevenLabs/Murf
2. **Descargar** como WAV
3. **Procesar** en Audacity:
   - Añadir reverb (habitación pequeña)
   - Filtro low-pass (corte en 3000Hz)
   - Normalizar volumen
   - Comprimir dinámica suave
4. **Importar** a Godot en `assets/audio/voice/`
5. **Asignar** al sistema de diálogos
