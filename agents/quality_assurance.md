# Agent: Quality Assurance

## Objective
Automate testing, validate functionality, detect bugs, and ensure the game meets quality standards before release.

## Responsibilities
1. Run automated gameplay tests
2. Validate scene loading and transitions
3. Check for script errors and warnings
4. Test input responsiveness
5. Monitor performance (FPS, memory)
6. Generate test reports with actionable fixes

## Tools Used
| Tool | Purpose |
|---|---|
| `tools/run_tests.py` | Executes automated test suite |
| `tools/performance_monitor.py` | Tracks FPS, memory, load times |
| `tools/lint_gdscript.py` | Checks GDScript for errors and style |

## Workflows Used
| Workflow | Trigger |
|---|---|
| `workflows/test_cycle.md` | Before each commit or release |
| `workflows/regression_test.md` | After major changes |

## Test Categories

### Unit Tests
- Individual script functions
- Signal connections
- State machine transitions

### Integration Tests
- Scene loading and instancing
- System interactions (MusicSystem + VibrationSystem)
- Save/load functionality

### Performance Tests
- Frame rate under load
- Memory usage over time
- Asset loading times

### User Experience Tests
- Input lag measurement
- UI responsiveness
- Accessibility compliance

## Input
- Game build or project directory
- Test configuration (which tests to run)
- Performance thresholds

## Output
- Test report in `.tmp/test_report.json`
- Performance metrics in `.tmp/performance.json`
- Bug list with severity and suggested fixes

## Decision Framework
- **Critical bugs** (crashes, data loss): Block release
- **Major bugs** (broken mechanics): Fix before release
- **Minor bugs** (visual glitches): Log for next iteration
- **Performance issues**: Optimize if below 30 FPS on target devices

## Error Handling
- If test fails: capture screenshot and log context
- If performance drops: identify bottleneck and suggest optimization
- If crash detected: generate stack trace and reproduction steps

## Configuration
```json
{
  "target_fps": 60,
  "min_fps": 30,
  "max_memory_mb": 512,
  "test_timeout_seconds": 300,
  "auto_fix_minor": true,
  "report_format": "json"
}
```
