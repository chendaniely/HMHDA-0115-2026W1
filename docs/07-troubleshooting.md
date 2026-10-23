# Troubleshooting: rebuild the Codespace

Sometimes the cloud computer gets stuck: the Terminal freezes, R crashes, or a package that worked
yesterday can't be found. We don't fix a broken computer: we get a fresh one. **Rebuilding**
is the cloud version of turning it off and on again, and it keeps your saved files.

## When to rebuild

- The Terminal is frozen: you type, and nothing appears.
- Rendering fails with errors that make no sense.
- R can't find a package that was there before.

Don't install software or packages yourself. Rebuild instead.

## Steps

1. Save your files (**Ctrl+S**, or **Cmd+S** on a Mac).
2. Press `F1` to open the Command Palette. A search bar appears at the top of the screen.
3. Type `Rebuild Container`.
4. Click **Codespaces: Rebuild Container**.
5. Wait about 2 to 5 minutes. The screen reloads, and you may see a dark screen with scrolling
   text: this is normal. When your files reappear in the **Explorer**, you're ready.

## Did I lose my work?

- **Saved files:** no. Anything you saved is safe.
- **Unsaved typing:** yes. Save before you rebuild.
- **What R had in memory:** yes. Run your code again from the top.

## Still stuck?

1. Press `F1`, type `creation log`, and click **Codespaces: View Creation Log**.
2. Send the teaching team that log, a screenshot of the problem, the exact error message, and the
   step where you got stuck.

Never send passwords, tokens or account recovery codes.

---

*Adapted from [Troubleshooting: Rebuild Container](https://ehsanx.github.io/HDSx/weeks/week02-modern-workflows/workflows09-troubleshooting.html)
and [Week 0: Asynchronous Onboarding](https://ehsanx.github.io/HDSx/weeks/week00-onboarding/index.html)
in the HDSx course book.*
