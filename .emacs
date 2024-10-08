;;; -- setup custom config -- ;;

;; disable top tool-bar
(tool-bar-mode -1)
;; disable menu bar
(menu-bar-mode -1)
;; disable scroll-bar
(scroll-bar-mode -1)

;; ESC cancels all
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; setup buffer change keybind
(global-set-key [M-right] 'next-buffer)
(global-set-key [C-right] 'next-buffer)
(global-set-key [M-left] 'previous-buffer)
(global-set-key [C-left] 'next-buffer)

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

;; kill scratch buffer form
;; Makes *scratch* empty.
;; (setq initial-scratch-message "")

;; Thanks, but no thanks
(setq inhibit-startup-message t)

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

;; Backup files settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )


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

;; Theme package and setup
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-outrun-electric t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))

;; modeline package
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq column-number-mode t)
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-position-column-line-format '("(%l:%c)"))
  (setq doom-modeline-total-line-number t)
  (setq doom-modeline-hud t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-highlight-modified-buffer-name t))

;; C-mode when editing hermes files
(use-package c-mode
  :mode (("\\.hms\\'" . c-mode)))

;; Setup ivy + counsel for nice M-X command overview
(use-package ivy :ensure t
  :diminish ivy-mode
  :init (setq projectile-completion-system 'ivy)
  :bind
  (:map ivy-mode-map ("C-'" . ivy-avy))
  :config
  (ivy-mode 1)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done)
  (setq ivy-extra-directories nil) ; default value: ("../" "./")
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 13)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-virtual-abbreviate 'full) ; Show the full virtual file paths
  (setq ivy-wrap t)
  (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                (counsel-ag . ivy--regex-plus)
                (counsel-grep-or-swiper . ivy--regex-plus)
                (t . ivy--regex-fuzzy))))

(use-package counsel :ensure t
  :bind*
  (("M-x" . counsel-M-x)
   ("C-c d d" . counsel-descbinds)
   ("C-c s s" . counsel-ag)
   ("C-c s d" . counsel-ag-projectile)
   ("C-x C-f" . counsel-find-file)
   ("C-x r f" . counsel-recentf)
   ("C-c g g" . counsel-git)
   ("C-c g G" . counsel-git-grep)
   ("C-x l" . counsel-locate)
   ("C-c g s" . counsel-grep-or-swiper)
   ("C-M-y" . counsel-yank-pop)
   ("C-c C-r" . ivy-resume)
   ("C-c i m" . counsel-imenu)
   ("C-c i M" . ivy-imenu-anywhere)
   ("C-c d s" . describe-symbol)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line-and-call))

  :config
  (defun reloading (cmd)
    (lambda (x)
      (funcall cmd x)
      (ivy--reset-state ivy-last)))
  (defun given-file (cmd prompt) ; needs lexical-binding
    (lambda (source)
      (let ((target
         (let ((enable-recursive-minibuffers t))
           (read-file-name
        (format "%s %s to:" prompt source)))))
    (funcall cmd source target 1))))
  (defun confirm-delete-file (x)
    (dired-delete-file x 'confirm-each-subdirectory))

  (ivy-add-actions
   'counsel-find-file
   `(("c" ,(given-file #'copy-file "Copy") "copy")
     ("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")))
  (ivy-add-actions
   'counsel-projectile-find-file
   `(("c" ,(given-file #'copy-file "Copy") "copy")
     ("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")
     ("b" counsel-find-file-cd-bookmark-action "cd bookmark")))

  ;; to make counsel-ag search the root projectile directory.
  (defun counsel-ag-projectile ()
    (interactive)
    (counsel-ag nil (projectile-project-root)))

  (setq counsel-find-file-at-point t)
  ;; ignore . files or temporary files
  (setq counsel-find-file-ignore-regexp
    (concat
     ;; File names beginning with # or .
     "\\(?:\\`[#.]\\)"
     ;; File names ending with # or ~
     "\\|\\(?:\\`.+?[#~]\\'\\)")))

(use-package ivy-prescient :ensure t
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package all-the-icons-ivy-rich :ensure t
  :init (all-the-icons-ivy-rich-mode +1)
  :config
  (setq all-the-icons-ivy-rich-icon-size 0.8))

(use-package ivy-rich :ensure t
  :after all-the-icons-ivy-rich
  :init
  (ivy-rich-mode 1))

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

;; flyspell
(use-package flyspell
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'text-mode-hook 'flyspell-mode)
    )
  :config
  ;; Sets flyspell correction to use two-finger mouse click
  (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
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
  ;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
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
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-engines-alist
	'(("jinja"    . "\\.html\\.flask\\'")
	  ("jinja"    . "\\.html?\\'")
	  ("vue"      . "\\.vue\\'")
	  ("js"       . "\\.js\\'")
	  ("php"      . "\\.phtml\\'"))
	)
  (setq web-mode-enable-css-colorization nil) ;; to remove css error for the time being
  (setq web-mode-enable-auto-indentation nil) ;; disable autoindent, it fucks up too much
  :interpreter "web-mode")

;; package auto-update
(use-package auto-package-update
   :ensure t
   :config
   (setq auto-package-update-interval 4
         auto-package-update-prompt-before-update t))
   ;; (auto-package-update-maybe))

;; undo-tree
(use-package undo-tree
  ;;:load-path "~/.emacs.d/undo-tree/"
  :config
  (global-undo-tree-mode 1)
  ;; Prevent undo tree files from polluting your git repo
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (progn
    (define-key undo-tree-map (kbd "C-/") nil)
    (define-key undo-tree-map (kbd "C-_") nil)
    (define-key undo-tree-map (kbd "C-?") nil)
    (define-key undo-tree-map (kbd "M-_") nil)
    (define-key undo-tree-map (kbd "C-z") 'undo-tree-undo)
    (define-key undo-tree-map (kbd "M-z") 'undo-tree-redo)))

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
  :bind
  (("C-<up>"   . move-text-up)
   ("M-<up>"   . move-text-up)
   ("C-<down>" . move-text-down)
   ("M-<down>" . move-text-down)))

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
;; Currently bugged with warnings, enable when fixed
;; (use-package smartparens
;;   :ensure smartparens  ;; install the package
;;   :config
;;   (smartparens-global-mode t)

;;   (sp-pair "'" nil :actions :rem)
;;   (sp-pair "`" nil :actions :rem)
;;   (setq sp-highlight-pair-overlay nil))

;; docker-compose
(use-package docker-compose-mode)

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

;; Chatgpt setup
;; (use-package chatgpt-shell
;;   :ensure t
;;   :config
;;   (setq chatgpt-shell-openai-key
;;         (auth-source-pick-first-password :host "api.openai.com")
;;         )
;;   )

;; Pacakge for showing keybindings
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
