# Workflow: Asset Pipeline

## Objective
Process, validate, and integrate new game assets (sprites, audio, UI) into the project.

## Trigger
New files added to `assets/` directory or manual invocation.

## Inputs
- File path of new asset
- Asset type (sprite, audio, UI, tileset)
- Intended use in game

## Steps
1. **Scan**: Identify new or modified files in `assets/`
2. **Validate**: Check format, dimensions, naming conventions
3. **Optimize**: Compress if necessary, convert formats
4. **Integrate**: Update manifest and import settings
5. **Report**: Generate validation report

## Tools
| Step | Tool | Command |
|---|---|---|
| 1 | `tools/validate_assets.py` | `python3 tools/validate_assets.py assets/` |
| 2 | `tools/optimize_sprites.py` | `python3 tools/optimize_sprites.py {file}` |
| 3 | `tools/generate_manifest.py` | `python3 tools/generate_manifest.py assets/` |

## Outputs
- Validated assets in `assets/`
- Manifest in `assets/manifest.json`
- Report in `.tmp/asset_report.json`

## Validation Rules

### Sprites
- Dimensions: 16x16, 32x32, 64x64, 128x128 (power of 2)
- Format: PNG with transparency
- Naming: `lowercase_with_underscores.png`
- Max size: 512KB per file

### Audio
- Format: OGG (music/ambient), WAV (SFX)
- Sample rate: 44100 Hz
- Bit depth: 16-bit
- Max size: 1MB per file

### UI Elements
- Format: PNG
- Naming: `ui_{element_name}.png`
- Must include 9-slice data if scalable

## Error Handling
- If dimensions are wrong: suggest correct size, do not import
- If format is unsupported: attempt conversion, flag if fails
- If naming is wrong: rename automatically, log change
- If file is corrupted: move to `.tmp/failed_assets/`

## Notes
- Always backup before optimization
- Keep original files in `.tmp/originals/`
- Update Godot import settings after integration
