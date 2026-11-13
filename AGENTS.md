
# Codex PR Review Instructions

Review the changes introduced by this Pull Request.

## Flutter Performance
- Detect unnecessary widget rebuilds.
- Identify memory leaks and undisposed controllers.
- Check inefficient state management.

## Security
- Detect exposed secrets and API keys.
- Check authentication and authorization risks.
- Identify insecure Firebase operations.

## Firestore
- Identify expensive or unbounded queries.
- Check pagination and indexing issues.
- Detect duplicate listeners and inefficient reads.

## Rules
- Review PR changes and relevant dependencies.
- Report actionable issues with file and line references.
- Explain the impact and suggested fix.
- Do not modify source code.
- Do not implement fixes without approval.
