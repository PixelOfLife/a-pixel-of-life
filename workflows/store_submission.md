# Workflow: Store Submission

## Objective
Prepare and submit the game to Google Play Store and Apple App Store, ensuring full compliance.

## Trigger
Release candidate build ready.

## Inputs
- Exported game build (AAB for Android, IPA for iOS)
- App icons and screenshots
- Privacy policy URL
- Store listing metadata

## Steps
1. **Pre-check**: Run compliance validation
2. **Assets**: Generate platform-specific assets
3. **Metadata**: Prepare store listings
4. **Build**: Export final builds
5. **Submit**: Upload to stores
6. **Monitor**: Track review status

## Tools
| Step | Tool | Command |
|---|---|---|
| 1 | `tools/check_store_readiness.py` | `python3 tools/check_store_readiness.py` |
| 2 | `tools/create_store_assets.py` | `python3 tools/create_store_assets.py` |
| 3 | `tools/generate_listing.py` | `python3 tools/generate_listing.py` |

## Outputs
- Compliance report in `.tmp/compliance_report.json`
- Store packages in `.tmp/store_packages/`
- Submission checklist in `.tmp/submission_checklist.md`

## Platform Checklists

### Apple App Store
- [ ] Apple Developer account active ($99/year)
- [ ] App Icon 1024x1024 PNG (no alpha)
- [ ] Screenshots for all device sizes
- [ ] Privacy policy URL (HTTPS)
- [ ] App Privacy declaration complete
- [ ] Demo account provided (if needed)
- [ ] IAP configured with StoreKit
- [ ] No placeholder content
- [ ] Build number incremented

### Google Play Store
- [ ] Google Play Developer account ($25 one-time)
- [ ] App Icon 512x512 PNG (with alpha)
- [ ] Feature Graphic 1024x500 PNG
- [ ] Screenshots 1080x1920 minimum
- [ ] AAB format (not APK)
- [ ] Data Safety section complete
- [ ] Target API level met
- [ ] 14-day testing (if new account)
- [ ] Content rating questionnaire complete

## Submission Process

### Google Play
1. Upload AAB to Play Console
2. Complete store listing
3. Set pricing and distribution
4. Submit for review
5. Monitor status (hours to 7 days)

### Apple App Store
1. Upload IPA via Xcode or Transporter
2. Complete App Store Connect listing
3. Submit for review
4. Monitor status (24-72 hours)

## Error Handling
- If rejected: read rejection reason, fix, resubmit
- If asset format is wrong: auto-convert
- If metadata is incomplete: generate template

## Notes
- Don't modify store listing during review
- Budget 5-7 days for first Apple submission
- Google Play new accounts may take longer
