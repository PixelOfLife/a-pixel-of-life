# Workflow: Pixel Art Generation

## Objective
Generate pixel art assets programmatically based on game design specifications.

## Trigger
- New asset needed for game
- Refactoring visual design
- Batch generation of sprites

## Inputs
- `workflows/visual_design.md` - Design specs and palette
- `workflows/game_bible.md` - Character/object definitions
- Asset type to generate (cell, ring, particle, etc.)

## Steps
1. **Read Specs:** Load visual design guide
2. **Design Asset:** Create pixel data based on specs
3. **Generate PNG:** Use `tools/generate_pixel_art.py`
4. **Validate:** Check against palette and size rules
5. **Import to Godot:** Register in scene or SpriteFrames

## Tools
| Step | Tool | Command |
|---|---|---|
| 1 | Read files | Manual inspection |
| 2 | `tools/generate_pixel_art.py` | `python3 tools/generate_pixel_art.py` |
| 3 | Output | Files in `assets/sprites/` |
| 4 | `tools/validate_assets.py` | `python3 tools/validate_assets.py assets/sprites/` |

## Outputs
- PNG files in `assets/sprites/`
- SpriteFrames for animations
- Updated asset manifest

## Available Asset Types

### Cell (Protagonist)
```
- cell_idle_XX.png (4 frames, 16x16)
- cell_appear_XX.png (6 frames, 16x16)
- cell_dissolve_XX.png (8 frames, 48x48)
```

### Heartbeat (Pulse effect)
```
- heartbeat_ring_XX.png (3 frames, 48x48)
- Multiple rings for layering
```

### Particles (Environment)
```
- particle_XX.png (5 variants, 4x4)
- bg_tile.png (32x32)
```

## Palette Validation
All generated assets must use colors from `workflows/visual_design.md`:
- Rosa: #ff99cc, #ff66aa, #ffcc ee
- Púrpura: #1a0a2e, #331155
- Blanco: #fff5ee
- Azul: #99ccff

## Error Handling
- If color not in palette: Add with alpha or skip
- If size wrong: Resize to nearest power of 2
- If generation fails: Log error, continue with next

## Notes
- Run from project root
- Generates ~30KB total
- Use `generate_pixel_art.py --help` for options