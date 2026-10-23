# The class notes prompt

> This is all AI/Claude generated

The notes in this folder are written by an AI model from a recording of each session. One
prompt, kept all term, tells the model how. When the prompt improves, **all** of the term's
notes get regenerated from it, so a fix made in week 4 also improves the notes for week 1.

| File | What it is |
|---|---|
| [`prompt-notes.md`](prompt-notes.md) | **The prompt.** Every word of it is sent to the model, followed by a session's transcript and R logs. |
| `prompt-notes-<name>.md` | Optional variants, for trying an idea next to the main prompt. |
| `README-prompt.md` | This file: how it all works, and how to suggest a change. |
| [`../Makefile`](../Makefile) | Shortcuts for running the generator (`make help` lists them). |

## What it produces

Each class session has a folder here in `lectures/`, named by date, with a suffix such as
`-lab` when there were two classes that day:

| File | What it is |
|---|---|
| `plaud.md` | share link to Plaud's page for the session: its transcript and notes, without the audio |
| `transcript-plaud.md` | the transcript: machine-generated, lightly cleaned up by Plaud ← input |
| `history.R` | the R code that was run: the R history, or the script written in class ← input, optional |
| `R-console.txt` | the R console, with everything R printed back ← input, optional |
| `notes-plaud.md` | Plaud's own AI notes, the baseline to beat |
| `notes-class-main--<model>.md` | what `prompt-notes.md` produced, and which model wrote it ← output |

Reading `notes-plaud.md` and `notes-class-main--<model>.md` side by side is the point.
Plaud's notes come from a generic summariser that has never heard of this course. Ours
know what the course is about, turn "due Saturday" into a real date, and keep the
questions people asked.

The R logs make a big difference. Speech is a bad way to record code: a microphone hears
"gg plot pew A E S X equals income", and the details disappear. When a session folder has
an R log, the prompt treats it as the authority on what was actually run.

## How to suggest a change

Notice something the notes keep getting wrong, such as a section that comes out thin, a due
date that's wrong, or a kind of question that gets dropped? You can suggest a change to the
prompt on the GitHub website:

1. Open [`prompt-notes.md`](prompt-notes.md) on GitHub and click the pencil icon.
2. Make your edit.
3. Click **Propose changes**, then **Create pull request**.

In the pull request, say **what problem the change fixes**, and quote the part of a
session's notes that shows it. "Make it better" is not something we can evaluate.

## Running it yourself

You don't need to. If you're curious, you can see the exact message the model receives (the
prompt, then the transcript and R logs) and give it to GitHub Copilot yourself. In your
Codespace's terminal, with a session folder in place of `lectures/<date>`:

```bash
git clone https://github.com/chendaniely/skills ~/skills      # once per Codespace
python3 ~/skills/class-notes/scripts/class_notes.py payload --repo lectures --only lectures/<date> > message.txt
```

Then give `message.txt` to Copilot Chat. The generator, `class_notes.py`, is in the
`class-notes/scripts/` folder of the public
[`chendaniely/skills`](https://github.com/chendaniely/skills) repository.

## The version history is the Git history

There is one prompt file, not `v1.md`, `v2.md`, `v3.md`: the **History** button on
`prompt-notes.md`'s GitHub page shows every revision and what changed. Every generated notes
file ends with a footer that records where it came from:

```
---

- prompt: prompt-notes.md @ a1b2c3d
- prompt-hash: 3f9c0e2b7a41
- model: claude-opus-5-5 (requested: opus)
- backend: claude
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-29
```

`opus` is an **alias** meaning "the latest Opus", and what it points at changes over time;
`claude-opus-5-5` is the model that actually ran, which is why it is also in the filename.
When the alias moves to a newer model, regenerated notes land in a new file next to the
old one, so models can be compared too. `inputs` says whether the notes had the R logs or
only the transcript. `prompt-hash` is a fingerprint of the prompt's words, so a change that
doesn't touch them never makes old notes look out of date.

## A note on privacy

The sessions are recorded, but only the text is published: the audio isn't, so your voice
never is. This repository is public, so anyone on the internet can read the transcripts, and
the link in each `plaud.md` opens the same text on Plaud's site. Students appear in the
transcript as `Speaker 2`, `Speaker 4`, and so on. The prompt instructs the model to keep it
that way and never to attach a name to a question. If you change the prompt, keep that rule.
