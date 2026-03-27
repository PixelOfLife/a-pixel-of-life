# Agent: Asset Manager

## Objective
Validate, organize, and optimize all game assets (sprites, audio, UI elements) to ensure consistency, quality, and store compliance.

## Responsibilities
1. Scan `assets/` directories for new or modified files
2. Validate pixel art dimensions (must be power of 2: 16x16, 32x32, 64x64, 128x128)
3. Check file formats (PNG for sprites, OGG/WAV for audio)
4. Verify naming conventions (lowercase, underscores, descriptive)
5. Generate asset manifest for Godot import
6. Flag assets that don't meet quality standards
7. **Pixel Art Validation:** Ensure all sprites follow the visual design guide (`workflows/visual_design.md`)

## Tools Used
| Tool | Purpose |
|---|---|
| `tools/validate_assets.py` | Validates sprite dimensions and formats |
| `tools/generate_pixel_art.py` | Generates pixel art from game specs |
| `tools/generate_manifest.py` | Creates asset manifest for project |
| `tools/optimize_sprites.py` | Compresses and optimizes sprite sheets |
| `tools/check_palette.py` | Validates colors against game palette |

## Workflows Used
| Workflow | Trigger |
|---|---|
| `workflows/asset_pipeline.md` | New assets added to project |
| `workflows/pixel_art_generation.md` | Need new sprites |
| `workflows/sprite_validation.md` | Verify visual consistency |

## Input
- Directory path to scan
- Asset type filter (sprites, audio, UI)
- Quality threshold (strict, standard, permissive)

## Output
- Validation report in `.tmp/asset_report.json`
- Updated manifest in `assets/manifest.json`
- Flagged issues list for human review

## Pixel Art Validation Rules
From `workflows/visual_design.md`:
- **Palette:** Must use defined colors (cell_glow, cell_membrane, nucleus, etc.)
- **Style:** Bioluminescent, organic, no hard edges
- **Animation:** Smooth transitions (no jarring jumps)
- **Sizes:** 16x16 (sprites), 32x32 (environment), 48x48 (effects)

## Error Handling
- If asset is corrupted: move to `.tmp/failed_assets/` with error log
- If dimensions are wrong: suggest correct size in report
- If format is unsupported: convert automatically if possible, flag if not
- If palette is wrong: flag for manual review

## Configuration
```json
{
  "sprite_sizes": [16, 32, 48, 64, 128],
  "supported_formats": ["png", "ogg", "wav"],
  "naming_pattern": "^[a-z][a-z0-9_]*$",
  "max_sprite_size_kb": 512,
  "palette_file": "workflows/visual_design.md"
}
```
