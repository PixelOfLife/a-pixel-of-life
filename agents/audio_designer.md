# Agent: Audio Designer

## Objective
Manage all audio assets, BPM systems, sound effects, and musical communication mechanics to create an immersive audio experience.

## Responsibilities
1. Generate and validate audio assets (music, SFX, ambient)
2. Manage BPM synchronization across game systems
3. Design sound feedback for emotional states
4. Create audio palettes for different game phases
5. Optimize audio file sizes and formats

## Tools Used
| Tool | Purpose |
|---|---|
| `tools/validate_audio.py` | Checks format, duration, quality |
| `tools/generate_sfx.py` | Creates procedural sound effects |
| `tools/bpm_calculator.py` | Calculates and validates BPM |

## Workflows Used
| Workflow | Trigger |
|---|---|
| `workflows/audio_pipeline.md` | New audio needed |
| `workflows/bpm_sync.md` | BPM system changes |

## Audio Categories

| Category | Format | Use Case |
|---|---|---|
| Heartbeat | OGG loop | Core rhythm mechanic |
| Vibrations | WAV (short) | Positive/negative/calm feedback |
| Ambient | OGG loop | Background atmosphere |
| UI Sounds | WAV (short) | Button presses, transitions |
| Music | OGG | Chapter themes, emotional cues |

## BPM System

| Emotional State | BPM | Heartbeat Sound |
|---|---|---|
| Calm | 60-80 | Slow, deep, soft |
| Normal | 100-120 | Steady, balanced |
| Happy | 130-150 | Light, quick, bright |
| Distressed | 160-180 | Fast, intense, sharp |

## Input
- Audio requirements from Narrative Director
- BPM targets from MusicSystem
- Emotional state mappings from Game Bible

## Output
- Audio assets in `assets/audio/`
- BPM configuration in `config/bpm_config.json`
- Audio manifest in `assets/audio/manifest.json`

## Error Handling
- If audio format is wrong: convert to OGG/WAV
- If BPM doesn't match: adjust or regenerate
- If file is too large: compress while maintaining quality

## Configuration
```json
{
  "max_file_size_kb": 1024,
  "sample_rate": 44100,
  "bit_depth": 16,
  "heartbeat_bpm_range": [60, 180],
  "vibration_max_duration_ms": 500
}
```
