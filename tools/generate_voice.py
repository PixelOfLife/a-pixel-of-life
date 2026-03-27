import asyncio
import edge_tts
import os

VOICE = "es-AR-ElenaNeural"
OUTPUT_DIR = "assets/audio/voice"
os.makedirs(OUTPUT_DIR, exist_ok=True)

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

async def generate_all():
    for name, text in voice_lines.items():
        filepath = os.path.join(OUTPUT_DIR, f"{name}.mp3")
        # Rate -30% for VERY slow (submerged), pitch -20Hz for MUCH deeper (underwater)
        communicate = edge_tts.Communicate(text, VOICE, rate="-30%", pitch="-20Hz")
        await communicate.save(filepath)
        print(f"Generated: {filepath}")
    print(f"\nTotal: {len(voice_lines)} files with voice {VOICE}")

asyncio.run(generate_all())
