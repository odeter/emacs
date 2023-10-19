# My Emacs Setup

Just my *.emacs* lisp file and the *.emacs.d* folder.

![Setup Example](imgs/show_image.png?raw=true "Setup Example")

# Packages used

The following packages are used, sorted into following categories:

## UI

- neotree
- smartparens
- rainbow-delimiters
- all-the-icons
- mode-icons
- doom-themes
- doom-modeline
- ivy
- ivy-prescient
- all-the-icons-ivy-rich
- ivy-rich
- counsel
- counsel-ag-projectile
- hl-line
- nyan-mode
- dashboard
- page-break-lines

## Programming language modes

- sml-mode
- fsharp-mode
- pyenv-mode
- iasm-mode
- haskell-mode
- fountain-mode
- web-mode
- c-mode
- prolog-mode
- docker-compose-mode

## Performance & background

- use-package
- no-littering
- auto-package-update

## Code helpers

- whitespace
- whitespace-cleanup-mode
- flycheck-package
- undo-tree
- cua-base
- flycheck
- flyspell
- move-text
- smart-comment
- which-key
- company
- company-box
- company-anaconda

## Others

- magit
- winum
- chatgpt-shell

# Authinfo

To properly use the `chatgpt-shell` package you must create an authinfo file besides your `.emacs` file. This should contain the following:

```bash
machine api.openai.com password <chatgpt api-key>
```
