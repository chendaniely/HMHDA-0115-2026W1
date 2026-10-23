# HMHDA 0115 2026W1: notes for agents

Students fork this repo and work in it from a Codespace, and most have never coded. Keep the
top level simple: data and code sit there so `read_csv("pew.csv")` needs no folder. Anything
for the instructor or for agents goes in a subfolder. Decisions and next steps are in
`TODO.md`.

## Class notes live in `lectures/`, not at the root

This course is set up for the `class-notes` skill even though there is no `prompt-notes.md`
at the root. `lectures/` holds the prompt, `README-prompt.md` and one dated folder per
session, and it is the course root as far as `class_notes.py` is concerned:

- Pass `--repo lectures` to every `class_notes.py` command, or use the `Makefile` targets,
  which already do (`make help`).
- `--only` takes a path from the repo root (`lectures/2026-10-29`) or the folder name alone.
- `--folder` is resolved against `lectures/`, not the repo root: pass the folder name alone
  (`2026-10-29-lab`), never `lectures/2026-10-29-lab`, which would become
  `lectures/lectures/…`.
- Until the first dated folder exists, `fetch` can't tell where sessions go. Pass
  `--folder "$PWD/lectures/<date>"` from the repo root, with the lecture's date, or create
  that folder first.

Before suggesting a commit for a session, run `make plaud-check`. Daniel told the class the
audio is never published, so each `plaud.md` link must be shared without it
(`is_audio=0`). If the check fails, tell Daniel to reshare the link on Plaud without the
audio; don't drop the file.

The live sessions are Daniel's extra lectures in the weekly office hours (Thursdays, 6 to
7 pm Pacific). The session type comes from Daniel, never from Plaud's title. The R logs are
`history.R` and `R-console.txt`, each optional.

The generator runs `claude -p --setting-sources ""`, so it never sees this file. It reads
only the prompt and each session's `transcript-plaud.md`, `history.*`, `terminal.txt` or
`*console*.txt`, and `materials.md`. The prompt doesn't describe `<course-materials>` yet,
so a `materials.md` would be sent without being explained.
