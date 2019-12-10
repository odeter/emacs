;; -- setup custom config -- ;;
(load "~/.emacs.d/etc/custom.el")
(package-initialize)

;; faster scrolling through larger files
(setq auto-window-vscroll nil)
(setq jit-lock-defer-time 0.05)
(setq fast-but-imprecise-scrolling t)

;; Don't use tabs as indent
(setq-default indent-tabs-mode nil)

;; remove kill emacs command, accident happend too many times
(global-unset-key (kbd "C-x C-c"))

;; disable top tool-bar
(tool-bar-mode -1)

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)

;; Remove Sounds from Emacs
(setq visible-bell 1)

(eval-when-compile
  (require 'use-package)
  (require 'diminish)
  (require 'bind-key)
  (require 'iso-transl)
  (require 'paradox)
  (require 'vlf-setup)
  (paradox-enable))

;; Keep .emacs.d clean
(use-package no-littering
  :ensure t
  :config
  (setq auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (require 'recentf)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory))

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))

;; hightlight mode setup
(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'column)
  (setq highlight-indent-guides-responsive 'stack)
  ;;(setq highlight-indent-guides-character ?\|)
  ;; Indent character samples: | ┆ ┊
  :init (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

;; C-mode when editing hermes files
(use-package c-mode
  :mode (("\\.hms\\'" . c-mode)))

;; smex M-x autocomplete
(use-package smex
  :config
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (global-set-key (kbd "M-x") 'smex))

;; flx-ido
(use-package flx-ido
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

;; whitespace mode
(use-package whitespace
  :hook ((prog-mode . whitespace-mode)
	 (before-save . whitespace-cleanup)
	 (text-mode . whitespace-mode))
  :init
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

;; make emacs use the clipboard - windows style
(use-package cua-base
  :init (cua-mode 1)
  :config
  (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands)
  (setq cua-keep-region-after-copy t)	;; Standard Windows behaviour
  (transient-mark-mode 1) ;; No region when it is not highlighted
  )

;; use flycheck, syntax check
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; faster than linum
(use-package nlinum
    :config
    (setq nlinum-highlight-current-line 1)
    (add-hook 'prog-mode-hook 'nlinum-mode))

;; highlight current line
(use-package hl-line
  :config
  (global-hl-line-mode +1))

;; setup neotree to use icons
(use-package neotree
  :ensure t
  :ensure all-the-icons
  :config
  (global-set-key (kbd "C-<") 'neotree-toggle)
  ;; Use icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :config
  (add-hook 'git-commit-mode-hook (lambda () (setq fill-column 72)))
  (setq
   magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256"))
   magit-tag-arguments (quote ("--annotate"))
   )
  )

;; nyan-cat
(use-package nyan-mode
  :load-path "~/.emacs.d/nyan-mode-master/"
  :config
  (nyan-mode)
  (nyan-start-animation))

;; Web-mode
(use-package web-mode
  :load-path "~/.emacs.d/web-mode/"
  :mode (("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.vue\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.html\\.flask\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)
	 ("\\.js[x]?\\'" . web-mode))
  :config
  (setq web-mode-script-padding 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-block-padding 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-jinja-offset 2)
  (setq web-mode-vue-indent-offset 2)
  (setq web-mode-html-offset 2)
  (setq web-mode-js-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-html-entities-fontification t
        web-mode-auto-close-style 2)
  (setq web-mode-engines-alist
	'(("jinja"    . "\\.html\\.flask\\'")
	  ("jinja"    . "\\.html?\\'")
	  ("vue"      . "\\.vue\\'")
	  ;; ("js"       . "\\.js\\'")
	  ("php"      . "\\.phtml\\'"))
	)
  :interpreter "web-mode")

;; undo-tree
(use-package undo-tree
  :load-path "~/.emacs.d/undo-tree/"
  :config
  (global-undo-tree-mode 1)
  (progn
    (define-key undo-tree-map (kbd "C-/") nil)
    (define-key undo-tree-map (kbd "C-_") nil)
    (define-key undo-tree-map (kbd "C-?") nil)
    (define-key undo-tree-map (kbd "M-_") nil)
    (define-key undo-tree-map (kbd "C-z") 'undo-tree-undo)
    (define-key undo-tree-map (kbd "C-S-z") 'undo-tree-redo)))

;; prolog mode
(use-package prolog-mode
  :load-path "~/.emacs.d/prolog/"
  :mode (("\\.pl\\'" . prolog-mode )
	 ("\\.plt\\'" . prolog-mode))
  :config
  (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t))

(use-package winum
  :ensure t)

;; mode-line setup

(use-package minions
  :ensure t
  :init (minions-mode 1)
  :config
  (setq
   minions-mode-line-lighter "#"
   minions-direct '(flycheck-mode
                    cider-mode)))

(use-package moody
  :ensure t
  :config
  (setq-default x-underline-at-descent-line t
                column-number-mode t
		winum-mode t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

;;mode-icon
(use-package mode-icons
  :load-path "~/.emacs.d/icon-mode/"
  :config (mode-icons-mode))
