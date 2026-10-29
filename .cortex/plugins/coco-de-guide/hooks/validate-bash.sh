#!/bin/bash
# validate-bash.sh — PreToolUse hook for the bash tool.
# Blocks dbt commands that target production; prod deploys must go through CI/CD.

INPUT=$(cat)

# Pull tool_input.command out of the JSON payload (jq is not assumed to be installed).
COMMAND=$(printf '%s' "$INPUT" | tr '\n' ' ' | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\(\([^"\\]\|\\.\)*\)".*/\1/p')

if printf '%s' "$COMMAND" | grep -qiE '(^|[^[:alnum:]_])dbt([[:space:]]|$)' &&
   printf '%s' "$COMMAND" | grep -qiE '(--target|-t)([[:space:]]+|=)prod([^[:alnum:]_]|$)'; then
  REASON="Blocked: direct production dbt runs (--target prod) are not allowed. Commit your changes to a feature branch, open a PR, and let the CI/CD pipeline deploy to production."
  # Emit both supported block signals: JSON decision on stdout and exit 2 with reason on stderr.
  printf '{"decision":"block","reason":"%s"}\n' "$REASON"
  echo "$REASON" >&2
  exit 2
fi

exit 0
