# Agent: Store Compliance

## Objective
Ensure the game meets all technical, legal, and content requirements for Google Play Store, Apple App Store, and other distribution platforms.

## Responsibilities
1. Pre-submission checklist validation
2. Asset format verification for each platform
3. Privacy policy and legal document generation
4. Age rating compliance check
5. Performance and stability validation
6. Metadata and store listing optimization

## Tools Used
| Tool | Purpose |
|---|---|
| `tools/check_store_readiness.py` | Validates all store requirements |
| `tools/generate_privacy_policy.py` | Creates privacy policy from data collection config |
| `tools/create_store_assets.py` | Generates platform-specific screenshots and icons |

## Workflows Used
| Workflow | Trigger |
|---|---|
| `workflows/store_submission.md` | Ready to publish |
| `workflows/platform_optimization.md` | Multi-platform release |

## Input
- Game build (exported from Godot)
- Asset files (icons, screenshots)
- Privacy/data collection configuration

## Output
- Compliance report in `.tmp/compliance_report.json`
- Store-ready asset packages in `.tmp/store_packages/`
- Submission checklist in `.tmp/submission_checklist.md`

## Platform Requirements Matrix

### Apple App Store ($99/year)
| Requirement | Status Check |
|---|---|
| App Icon 1024x1024 PNG (no alpha) | `check_icon()` |
| Screenshots per device size | `check_screenshots()` |
| Privacy Policy URL (HTTPS) | `check_privacy_url()` |
| App Privacy declaration | `check_privacy_declaration()` |
| No placeholder content | `scan_placeholder()` |
| Demo account (if login) | `check_demo_account()` |
| IAP uses StoreKit | `check_iap()` |

### Google Play Store ($25 one-time)
| Requirement | Status Check |
|---|---|
| App Icon 512x512 PNG (with alpha) | `check_icon()` |
| Feature Graphic 1024x500 PNG | `check_feature_graphic()` |
| Screenshots 1080x1920 min | `check_screenshots()` |
| AAB format (not APK) | `check_build_format()` |
| Data Safety section | `check_data_safety()` |
| Target API level | `check_target_api()` |
| 14-day testing (new accounts) | `check_testing_period()` |

## Error Handling
- If asset format is wrong: auto-convert and flag
- If privacy policy is missing: generate template
- If build fails validation: report specific issues with fixes

## Configuration
```json
{
  "target_platforms": ["google_play", "apple_app_store"],
  "game_category": "Games > Simulation",
  "content_rating": "6+",
  "pricing_model": "freemium",
  "iap_products": ["chapter_2", "chapter_3", "cosmetic_pack"]
}
```
