---
name: linear-ticket
description: Create a Linear issue when the user asks to "create a linear ticket", "create a linear issue", "file a ticket", "make a linear ticket", or similar phrases about tracking work in Linear.
version: 1.0.0
---

# Create Linear Ticket

Create a Linear issue for the Platform team with the user's specifications.

## Default Settings

Use these defaults unless the user explicitly specifies otherwise:

- **Team**: Platform (ID: `0cf54a8c-b85d-4637-b6fd-89670b625782`)
- **Assignee**: Jamie Zieziula (me) (ID: `4b467fca-5132-49ea-ba89-1c4a642604cc`)
- **Priority**: 3 (Medium)
- **State**: Todo (ID: `04053aff-bb8b-429a-b204-87e16d821853`)
- **Project**: Platform Regular Maintenance: 2026Q1 (ID: `fddaf0c1-ecfc-4c88-917a-196f8ab38750`)

## Instructions

1. The user will ALWAYS provide information about what the issue is about in `$ARGUMENTS` or in the conversation context
2. Generate a clear, concise title based on what the user described
3. Generate a body/description that expands on the title with:
   - Context about the issue
   - Any relevant details from the conversation
   - Keep it conversational and to the point
4. Use the `mcp__linear__save_issue` tool to create the issue with:
   - The generated title
   - The generated description
   - Default team, assignee, priority, state, and project (unless overridden)
5. Return the issue URL to the user so they can view it

## Override Handling

If the user specifies any of these, use their values instead of defaults:
- Different team name
- Different assignee (can be "me", user name, or email)
- Different priority (0=None, 1=Urgent, 2=High, 3=Normal, 4=Low)
- Different state/status
- Different project
- Specific labels to add

## Example Usage

User: "create a linear ticket to investigate the memory leak in the worker process"

You should:
1. Generate title: "Investigate memory leak in worker process"
2. Generate description with context
3. Create issue with defaults
4. Return the Linear URL

User: "file a ticket to upgrade postgres, make it urgent"

You should:
1. Generate title: "Upgrade Postgres"
2. Generate description
3. Override priority to 1 (Urgent)
4. Create issue
5. Return the Linear URL
