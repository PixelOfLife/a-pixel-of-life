# Agent System: WAD Framework for Game Development

## What is an Agent?
An agent is an intelligent decision-maker that reads workflows, executes tools in sequence, handles failures gracefully, and coordinates complex tasks autonomously.

## Agent Directory
Each agent has a specific domain of responsibility:

| Agent | Domain | Purpose |
|---|---|---|
| `asset_manager` | Assets & Resources | Validates, organizes, and optimizes game assets |
| `narrative_director` | Story & Dialogue | Manages story structure, dialogue trees, chapter flow |
| `store_compliance` | Publishing | Ensures compliance with app store requirements |
| `quality_assurance` | Testing | Runs automated tests, validates functionality |
| `project_manager` | Orchestration | Coordinates agents, tracks progress, manages resources |
| `audio_designer` | Sound & Music | Manages audio assets, BPM, sound design |
| `ui_architect` | Interface | Designs and validates UI/UX components |

## How Agents Communicate
Agents share information through:
1. **Status files** in `.tmp/` (e.g., `.tmp/system_status.json`)
2. **Workflow triggers** (one agent completes a workflow, triggers the next)
3. **Shared configuration** in `config/`

## Creating a New Agent
1. Create a file in `agents/` named `{agent_name}.md`
2. Define: Objective, Required Tools, Workflows Used, Output Format
3. Test the agent with a simple workflow before deploying
