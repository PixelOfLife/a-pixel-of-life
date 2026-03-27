from gtts import gTTS
import os

output_dir = "assets/audio/voice"
os.makedirs(output_dir, exist_ok=True)

voice_lines = {
    "intro_01": "¿Cuál es el sonido del silencio?",
    "intro_02": "No lo sabemos...",
    "intro_03": "pero podemos saber...",
    "intro_04": "cuál es el sonido...",
    "intro_05": "del comienzo de la vida...",
    "positive_01": "Te quiero...",
    "positive_02": "Todo está bien...",
    "positive_03": "Estoy aquí contigo...",
    "calm_01": "Descansa...",
    "calm_02": "Todo está en paz...",
    "calm_03": "La calma te envuelve...",
    "hint_01": "siente...",
    "hint_02": "escucha...",
    "hint_03": "presta atención...",
    "hint_04": "el ritmo te guía...",
}

for name, text in voice_lines.items():
    tts = gTTS(text=text, lang='es', slow=True)
    filepath = os.path.join(output_dir, f"{name}.mp3")
    tts.save(filepath)
    print(f"Generated: {filepath}")

print(f"\nTotal: {len(voice_lines)} voice files generated.")
