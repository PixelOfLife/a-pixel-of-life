# Workflow System: WAD Framework for Game Development

## What is a Workflow?
A workflow is a Markdown SOP (Standard Operating Procedure) that defines:
- **Objective**: What needs to be accomplished
- **Inputs**: What information or resources are needed
- **Steps**: The exact sequence of actions to take
- **Tools**: Which deterministic scripts to execute
- **Outputs**: What deliverables are produced
- **Edge Cases**: How to handle failures and exceptions

## Workflow Directory

| Workflow | Purpose | Frequency |
|---|---|---|
| `asset_pipeline.md` | Process and validate new assets | Every asset addition |
| `chapter_creation.md` | Develop a new game chapter | Per chapter |
| `store_submission.md` | Prepare and submit to app stores | Per release |
| `test_cycle.md` | Run automated tests | Every commit |
| `sprint_planning.md` | Plan development sprints | Weekly |
| `audio_pipeline.md` | Process audio assets | Every audio addition |
| `ui_creation.md` | Design and implement UI elements | Per UI component |
| `performance_check.md` | Monitor and optimize performance | Daily |

## How Workflows Work

1. **Trigger**: An event occurs (new asset, code commit, time-based)
2. **Agent Reads**: The relevant agent reads the workflow
3. **Execute Steps**: Agent runs tools in sequence
4. **Handle Errors**: Agent follows error handling procedures
5. **Produce Output**: Results are saved to `.tmp/` or project files
6. **Notify**: Next agent or human is notified of completion

## Creating a New Workflow
1. Create a file in `workflows/` named `{workflow_name}.md`
2. Follow the template structure below
3. Test with a simple scenario before deploying

## Workflow Template
```markdown
# Workflow: {Name}

## Objective
{Clear, one-sentence description}

## Trigger
{What initiates this workflow}

## Inputs
- {Input 1}
- {Input 2}

## Steps
1. {Step 1}
2. {Step 2}
3. {Step 3}

## Tools
| Step | Tool | Command |
|---|---|---|
| 1 | {tool_name} | `{command}` |

## Outputs
- {Output 1}
- {Output 2}

## Error Handling
- If {error}: {action}
- If {error}: {action}

## Notes
{Any additional context}
```
