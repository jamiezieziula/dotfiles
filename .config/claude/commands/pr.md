pr.md
Create a PR based on our current branch using the `gh` command-line tool.

Additional context from me to include in the PR and commit messages: $ARGUMENTS

First, make sure all of the current files are committed. If `pre-commit` hooks
fail, just re-add the files that failed and commit them again. NEVER EVER
`amend` a commit under any circumstances.

Then, use `gh pr create --draft` to create the PR in draft state (unless the user
explicitly specifies to create it as ready for review). If there is only a single
commit, use the commit message as the PR message. If there are multiple commits,
synthesize a new one that covers all of those changes.

CRITICAL: After creating or updating the PR with new commits, ALWAYS validate that
the PR title and body accurately represent ALL changes on the branch:
1. Review the full diff from base branch to current branch HEAD
2. Compare the PR title and body against the actual changes
3. If the PR description is outdated or incomplete, update it using `gh pr edit`
4. Ensure all significant changes are reflected in the description

## Commit/PR descriptions

- IMPORTANT: THIS STYLE GUIDE IS REQUIRED AND MANDATORY
- Be concise. Brief, focus on what/why not how
- No checklists or file lists (but change lists OK)
- Always relate to a Linear issue. Based on our conversation, use "Closes #1234"
  or "Closes PLA-1234". If you cannot find a related Linear issue, ask before
  creating the PR.
- Include contextual links (logs, issues, PRs, materials) that would help a
  reviewer get oriented on what we're talking about

## Test plan

- Always include a test plan section in the PR body
- Test plans must include exact ways to validate the changes: specific commands
  to run, expected outputs, and things to watch for
- Never leave test steps vague. If it involves kubectl, curl, or other CLI tools,
  include the full commands