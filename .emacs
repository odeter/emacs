;;; -- setup custom config -- ;;
;; disable top tool-bar
(tool-bar-mode -1)
;; disable menu bar
(menu-bar-mode -1)

;; setup buffer change keybind
(global-set-key [M-right] 'next-buffer)
(global-set-key [M-left] 'previous-buffer)

;; text zoom
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;; Speed up startup
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold 80000000)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after init."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold 800000)
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'focus-out-hook 'garbage-collect))))


(load "~/.emacs.d/etc/custom.el")
(package-initialize)

;; insert and delete selection window
(delete-selection-mode 1)

;; Setup line numbering
(setq-default display-line-numbers-current-absolute t
              display-line-numbers-width 4
              display-line-numbers-widen t)
(add-hook 'web-mode-hook 'display-line-numbers-mode)
(add-hook 'python-mode-hook 'display-line-numbers-mode)
(add-hook 'lisp-mode-hook 'display-line-numbers-mode)
(add-hook 'eldoc-mode-hook 'display-line-numbers-mode)

;; aggresive indent
;; (global-aggressive-indent-mode)

;; kill scratch buffer form
;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; faster scrolling through larger files
(setq auto-window-vscroll nil)
(setq jit-lock-defer-time 0.05)
(setq fast-but-imprecise-scrolling t)

;; Don't use tabs as indent
(setq-default indent-tabs-mode nil)

;; remove kill emacs command, accident happend too many times
(global-unset-key (kbd "C-x C-c"))

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

;; all the icons
(use-package all-the-icons)

;; color parenthesses and so on
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

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
;; (use-package highlight-indent-guides
;;   :config
;;   (setq highlight-indent-guides-method 'column)
;;   (setq highlight-indent-guides-responsive 'stack)
;;   ;;(setq highlight-indent-guides-character ?\|)
;;   ;; Indent character samples: | ┆ ┊
;;   :init (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

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
  (setq whitespace-line-column 150)
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
  :init (global-flycheck-mode)
  :config
  (add-hook 'js2-mode-hook
            (defun my-js2-mode-setup ()
              (flycheck-mode t)
              (when (executable-find "eslint")
                (flycheck-select-checker 'javascript-eslint))))
  )

;; highlight current line
(use-package hl-line
  :config
  (global-hl-line-mode 1))

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
  ;;:load-path "~/.emacs.d/nyan-mode-master/"
  :config
  (nyan-mode)
  (nyan-start-animation))

;; Web-mode
(use-package web-mode
  ;;:load-path "~/.emacs.d/web-mode/"
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
	  ("js"       . "\\.js\\'")
	  ("php"      . "\\.phtml\\'"))
	)
  :interpreter "web-mode")

;; package auto-update
(use-package auto-package-update
   :ensure t
   :config
   (setq auto-package-update-delete-old-versions t
         auto-package-update-interval 4)
   (auto-package-update-maybe))


;; undo-tree
(use-package undo-tree
  ;;:load-path "~/.emacs.d/undo-tree/"
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

;; move-text package setup
(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

;; setup dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; page-break mode setup
(use-package page-break-lines
  :ensure t
  :hook
  (compilation-mode . page-break-lines-mode)
  (help-mode . page-break-lines-mode)
  (prog-mode . page-break-lines-mode))

;; smart comment setup
(use-package smart-comment
  :ensure t
  :bind ("M-;" . smart-comment))

;; smartparens setup
(use-package smartparens
  :init
  (bind-key "C-M-f" #'sp-forward-sexp smartparens-mode-map)
  (bind-key "C-M-b" #'sp-backward-sexp smartparens-mode-map)
  (bind-key "C-)" #'sp-forward-slurp-sexp smartparens-mode-map)
  (bind-key "C-(" #'sp-backward-slurp-sexp smartparens-mode-map)
  (bind-key "M-)" #'sp-forward-barf-sexp smartparens-mode-map)
  (bind-key "M-(" #'sp-backward-barf-sexp smartparens-mode-map)
  (bind-key "C-S-s" #'sp-splice-sexp)
  (bind-key "C-M-<backspace>" #'backward-kill-sexp)
  (bind-key "C-M-S-<SPC>" (lambda () (interactive) (mark-sexp -1)))

  :config
  (smartparens-global-mode t)

  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem)
  (setq sp-highlight-pair-overlay nil))

;; Org setup
(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c C-w" . org-refile)
         ("C-c j" . org-clock-goto)
         ("C-c C-x C-o" . org-clock-out)
         ([M-left] . previous-buffer)
         ([M-right] . next-buffer))
  :config
  (progn
    ;; The GTD part of this config is heavily inspired by
    ;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
    (setq org-directory "~/org")
    (setq org-agenda-files
          (mapcar (lambda (path) (concat org-directory path))
                  '("/org.org"
                    "/gtd/gtd.org"
                    "/gtd/inbox.org"
                    "/gtd/tickler.org")))
    (setq org-log-done 'time)
    (setq org-src-fontify-natively t)
    (setq org-use-speed-commands t)
    (setq org-capture-templates
          '(("t" "Todo [inbox]" entry
             (file+headline "~/org/gtd/inbox.org" "Tasks")
             "* TODO %i%?")
            ("T" "Tickler" entry
             (file+headline "~/org/gtd/tickler.org" "Tickler")
             "* %i%? \n %^t")))
    (setq org-refile-targets
          '(("~/org/gtd/gtd.org" :maxlevel . 3)
            ("~/org/gtd/someday.org" :level . 1)
            ("~/org/gtd/tickler.org" :maxlevel . 2)))
    (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
    (setq org-agenda-custom-commands
          '(("@" "Contexts"
             ((tags-todo "@email"
                         ((org-agenda-overriding-header "Emails")))
              (tags-todo "@phone"
                         ((org-agenda-overriding-header "Phone")))))))
    (setq org-clock-persist t)
    (org-clock-persistence-insinuate)
    (setq org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))))
(use-package org-inlinetask
  :bind (:map org-mode-map
              ("C-c C-x t" . org-inlinetask-insert-task))
  :after (org)
  :commands (org-inlinetask-insert-task))
(use-package org-bullets
  :ensure t
  :commands (org-bullets-mode)
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


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
  :ensure t
  :load-path "~/.emacs.d/icon-mode/"
  :config (mode-icons-mode)
  )

;; setup company mode
(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t)
  )

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode)
  )

(use-package company-anaconda
  :after (anaconda-mode company)
  :config (add-to-list 'company-backends 'company-anaconda)
  )
