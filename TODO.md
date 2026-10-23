# TODO

Daniel, 2026-10-22: "i want to move over all our .devcontainer work (and remove the python
parts) we just need vscode + r + quarto all working in a dev container. then in the readme copy
over the instructions from the HDSx textbook we just created and how to use the codespace (we
dont' need the AI edit comments, but we shoudl refernce and give credit to the HDSx textbook and
workspace repo for origninal source)"

## 1. Dev container: VS Code, R and Quarto

Done on 2026-10-22. `.devcontainer/` and `.gitattributes` were copied unchanged from
`ehsanx/HDSx-workspace` main at `990153f` (PR #15), and then the Codespace was renamed. That
keeps the same course image, `ghcr.io/chendaniely/hdsx-workspace`, with Python in it.

Daniel's reasons, both on 2026-10-22:

- "let's use the same setup if python is built into the container. at least for now."
- "let's just copy over the same devcontainer setup for now i can optimize later and fork the
  changes"

Python is 133 MB of the 1.9 GB image, a small part of the roughly 4-minute start, which is
mostly the image download. Compiling Python takes about 4 minutes, but only when the image is
rebuilt, never when a student opens a Codespace.

- `build-image.yml` stays in HDSx-workspace. It pushes to `ghcr.io/<owner>/hdsx-workspace`,
  the image SPPH 381H students pull, and its check renders `practice_report.qmd`, which this
  repo doesn't have. To build this course's own image, copy the workflow and change both.
- Still to do: push, then open a fresh Codespace from this repo in the browser and work through
  the checklist in `.devcontainer/README.md`.
- Open question for Daniel: is the R package list the same as SPPH 381H's?
- Later, when Daniel optimizes: give this course its own image, without Python, and perhaps
  without the RStudio Server that comes with the rocker base (1.18 GB of the 1.9 GB).

## 2. README: how to use the Codespace

Copy from the HDSx book, `ehsanx/HDSx` main at `4056e84` (PR #1), published at
<https://ehsanx.github.io/HDSx/>. Local clone: `~/git/ubc/SPPH-381H/HDSx`.

- `weeks/week02-modern-workflows/workflows03-open-codespace.qmd` and
  `workflows07-render-quarto.qmd`, plus `_snippets/render-how.qmd`. Also see `workflows04`
  (reopen), `05` (VS Code tour), `08` (commit) and `10` (stop). The screenshots are in
  `assets/images/workflowN/`.
- Leave out the `AI-EDIT` comments.
- Credit both the HDSx book and `ehsanx/HDSx-workspace` as the original source, with links.
- The steps name the HDSx repos, so rewrite them for this repo.

## Rules carried over from the HDSx work

These were memories in the HDSx-workspace sessions, and a session in this folder doesn't load
them.

- **Release builds only, pinned for the whole term.** Pin extensions as
  `publisher.name@x.y.z`, and pin feature versions. Bump vscode-R and its `sess` R package
  together. Why: on 2026-10-15 an unpinned vscode-R update (3.2.0) broke plots for students
  mid-term.
- **Works out of the box for people who have never coded.** No errors, pop-ups, dialogs or
  steps they have to remember. A friendly error still counts as a failure. Test in a fresh
  Codespace in the browser, the way a student would, using the checklist in
  `.devcontainer/README.md`. Leave harmless notices alone, and ask before adding a setting
  just to hide one.
- **Paths that don't work get turned off, not explained.** Quarto preview is off because it
  doesn't work in the Codespaces browser client; students click the rendered `.html` instead.
  There are no forwarded ports, and the R Debugger is excluded. PDFs go through Typst.
