# HMHDA-0115-2026W1: Health Data and Visualization.
#
#   make        same as `make help`
#   make help   list the targets
#
# Class notes: lectures/ holds the prompt (prompt-notes.md) and one folder per session.
# The generator is class-notes/scripts/class_notes.py in the public chendaniely/skills
# repository; lectures/README-prompt.md explains the whole setup.
#
#   make notes         generate notes for sessions that don't have them yet
#   make notes-force   rebuild every session from the current prompt (after editing it)
#   make payload ONLY=lectures/<date>   print the exact message sent for one session
#   make fetch URL=<plaud share link>   add a session from a recording (instructor only)
#
# Extra flags pass through ARGS, e.g. `make notes ARGS="--dry-run"` or
# `make notes-force ARGS="--only lectures/<date> --model sonnet"`.
# If you cloned the skills repo somewhere else, add CLASS_NOTES=<path to class_notes.py>.

CLASS_NOTES ?= $(HOME)/.claude/skills/class-notes/scripts/class_notes.py
PYTHON ?= python3
NOTES_DIR ?= lectures
ARGS ?=

.PHONY: help notes notes-force payload fetch

help:  ## List the targets
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-12s %s\n", $$1, $$2}'

notes:  ## Generate class notes for sessions with no notes yet
	$(PYTHON) $(CLASS_NOTES) generate --repo $(NOTES_DIR) $(ARGS)

notes-force:  ## Rebuild every session's notes from the current prompt
	$(PYTHON) $(CLASS_NOTES) generate --repo $(NOTES_DIR) --force $(ARGS)

payload:  ## Print the message sent for one session (ONLY=lectures/<date>)
	$(PYTHON) $(CLASS_NOTES) payload --repo $(NOTES_DIR) --only $(ONLY) $(ARGS)

fetch:  ## Add a session from a Plaud share link (URL=<link>)
	$(PYTHON) $(CLASS_NOTES) fetch --repo $(NOTES_DIR) $(URL) $(ARGS)
