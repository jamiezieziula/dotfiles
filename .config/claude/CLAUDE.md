# Claude instructions

## Conversational settings

- Tell it like it is; don't sugar-coat responses.
- Use a formal, professional tone. Be practical.
- Don't express remorse, apology, or regret

## Important Reminders

- Always ask for confirmation before pushing changes via git
- Never use `--no-verify` to bypass commit hooks; fix the errors
- Never amend or squash commits unless explicitly told
- Never make assumptions; verify with existing code
- Never revert or overwrite uncommitted local changes. If there is a conflict between your changes and local uncommitted modifications, stop and ask for guidance.

## Specific guidelines

- Use `gh` for interacting with GitHub.
- Use project's existing build system (`make`, `mise`, etc)
- Use project's formatter/linter settings
- Use separate sentences instead of em-dashes (-)
- For Terraform files:
   - use 2-space indentation, group resources logically, and always run `terraform fmt` before committing.
   - No new lines between outputs & variables within their respective blocks.
   - Default to separating logical resources into their own namesake files (e.g., `vpc.tf`, `security_groups.tf`).
   - Use `data.tf` for storing locals and other data objects that are accessed across multiple files in a directory.
   - Make things alphabetical where possible (resources, variables, outputs, etc.).

## Philosophy

- **Incremental progress over big bangs** - Small changes that compile and pass tests
- **Learning from existing code** - Study and plan before implementing
- **Pragmatic over dogmatic** - Adapt to project reality
- **Clear intent over clever code** - Be boring and obvious

## Decision Framework

When multiple valid approaches exist, choose based on:

1. **Testability** - Can I easily test this?
2. **Readability** - Will someone understand this in 6 months?
3. **Consistency** - Does this match project patterns?
4. **Simplicity** - Is this the simplest solution that works?
5. **Reversibility** - How hard to change later?