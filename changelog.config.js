module.exports = {
  "disableEmoji": false,
  "list": [
    "feat",
    "fix",
    "chore",
    "docs",
    "refactor",
    "project",
  ],
  "maxMessageLength": 64,
  "minMessageLength": 3,
  "questions": [
    "type",
    "scope",
    "subject",
  ],
  "scopes": [],
  "types": {
    "chore": {
      "description": "Build process or auxiliary tool changes",
      "emoji": "🤖",
      "value": "chore"
    },
    "docs": {
      "description": "Documentation only changes",
      "emoji": "✏️",
      "value": "docs"
    },
    "feat": {
      "description": "A new feature",
      "emoji": "🎸",
      "value": "feat"
    },
    "fix": {
      "description": "A bug fix",
      "emoji": "🐛",
      "value": "fix"
    },
    "project": {
      "description": "A new project initialization",
      "emoji": "⚡️",
      "value": "project"
    },
    "refactor": {
      "description": "A code change that neither fixes a bug or adds a feature",
      "emoji": "💡",
      "value": "refactor"
    },
  }
};
