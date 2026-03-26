# Workflow: Chapter Creation

## Objective
Develop a complete game chapter from outline to playable state, including narrative, mechanics, and assets.

## Trigger
Previous chapter completed or new chapter planned.

## Inputs
- Chapter outline from Game Bible
- Target duration (10-15 minutes)
- Emotional themes and mechanics to introduce
- Previous chapter's ending state

## Steps
1. **Outline**: Define scenes, beats, and emotional arc
2. **Narrative**: Write dialogue and narration
3. **Mechanics**: Implement new gameplay systems
4. **Assets**: Create or acquire needed sprites/audio
5. **Integration**: Build chapter scene in Godot
6. **Testing**: Playtest and iterate

## Tools
| Step | Tool | Command |
|---|---|---|
| 2 | `tools/generate_dialogue.py` | `python3 tools/generate_dialogue.py {outline}` |
| 5 | `tools/create_scene.py` | `python3 tools/create_scene.py {chapter_num}` |
| 6 | `tools/run_tests.py` | `python3 tools/run_tests.py --chapter {num}` |

## Outputs
- Chapter scene in `scenes/chapters/chapter_{num}.tscn`
- Dialogue scripts in `scripts/dialogue/chapter_{num}/`
- Chapter config in `config/chapter_{num}.json`
- Test report in `.tmp/chapter_{num}_test.json`

## Chapter Structure Template

### Scene 1: Hook (1-2 min)
- Capture attention immediately
- Establish emotional tone
- Introduce core mechanic of this chapter

### Scene 2: Exploration (3-5 min)
- Player explores and interacts
- Choices shape temperamento
- Musical communication introduced

### Scene 3: Challenge (3-5 min)
- Rhythm-based combat or puzzle
- Tests skills introduced in scene 2
- Emotional stakes raised

### Scene 4: Resolution (2-3 min)
- Consequences of choices visible
- Temperamento summary shown
- Emotional payoff

### Scene 5: Cliffhanger (1 min)
- Hook for next chapter
- "To be continued..." moment
- Purchase prompt (if applicable)

## Quality Checklist
- [ ] All dialogue is age-appropriate (6+)
- [ ] BPM system works correctly
- [ ] Choices affect temperamento visibly
- [ ] No placeholder content
- [ ] Performance is smooth (30+ FPS)
- [ ] All assets validated
- [ ] Cliffhanger is compelling

## Error Handling
- If narrative is too complex: simplify language
- If mechanics are confusing: add tutorial moment
- If performance drops: optimize assets
- If pacing is off: adjust scene lengths

## Notes
- Always playtest with fresh eyes
- Keep emotional core clear
- Music should enhance, not distract
