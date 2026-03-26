# Core Mechanic: Ripple Effect System (Lo que das, vuelve)

## Concept
Every action the player takes creates a "ripple" that travels outward and eventually returns. Good actions return as positive outcomes. Bad actions return as negative consequences. The delay between action and consequence varies, creating surprise and teaching cause-and-effect.

## How It Works

### The Ripple Cycle
```
Player Action → Ripple Created → Ripple Travels → Ripple Returns → Consequence
     ↓               ↓               ↓               ↓               ↓
  "Help NPC"    [Kindness +0.2]   [3 chapters]   [NPC helps you]  [Positive]
  "Ignore cry"  [Kindness -0.1]   [1 chapter]    [Lost opportunity] [Negative]
  "Steal item"  [Kindness -0.3]   [5 chapters]   [Betrayal scene]  [Negative]
```

### Timing of Returns
- **Quick return (1-2 scenes):** Small actions, minor consequences
- **Medium return (1 chapter):** Medium actions, noticeable consequences
- **Long return (2-5 chapters):** Major actions, dramatic consequences

### Examples

| Action | Immediate Effect | Short-term Return | Long-term Return |
|---|---|---|---|
| Help a lost spirit | +Kindness | Spirit appears later to guide you | Spirit becomes ally in final battle |
| Ignore someone's pain | -Kindness | Area becomes darker | Boss fight is harder |
| Share your light | +Kindness, light dims briefly | Light returns brighter | Unlocks empathy power |
| Hoard your light | Light stays bright | Others avoid you | Miss empathy power forever |
| Listen to a sad melody | +Curiosity | Discover hidden path | Unlock patience power |
| Rush through without listening | -Curiosity | Miss hidden path | Patience power harder to get |

## Implementation in PersonalityProfile

### Ripple Queue
```gdscript
var ripple_queue: Array = []

func create_ripple(action_type: String, impact: Dictionary, return_delay: int) -> void:
    ripple_queue.append({
        "action": action_type,
        "impact": impact,
        "created_at": current_chapter,
        "return_at": current_chapter + return_delay,
        "returned": false
    })

func check_ripples() -> Array:
    var returned_ripples = []
    for ripple in ripple_queue:
        if not ripple["returned"] and ripple["return_at"] <= current_chapter:
            ripple["returned"] = true
            returned_ripples.append(ripple)
            apply_ripple_consequence(ripple)
    return returned_ripples
```

### Consequence Types
- **Dialogue changes:** NPCs remember your actions
- **Scene availability:** Some paths only open with certain karma
- **Difficulty adjustment:** Harder bosses if you've been cruel
- **Power access:** Some EQ powers require specific karma levels
- **Ending variations:** Final chapter changes based on accumulated karma
