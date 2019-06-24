(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(beacon-blink-delay 2.3)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes
   (quote
    ("274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(inhibit-startup-screen t)
 '(jdee-ant-buildfile
   "/home/christopher/Documents/Universitet/advanced computer systems/exam/acertainsupermarket/acertainsupermarket/build.xml")
 '(jdee-build-function (quote jdee-ant-build))
 '(jdee-built-class-path
   (quote
    ("/home/christopher/Documents/Universitet/advanced computer systems/Assignment 1/acertainbookstore-assignment1/bin/" "/home/christopher/Documents/Universitet/advanced computer systems/Assignment 1/acertainbookstore-assignment1/lib/*")))
 '(jdee-compile-option-classpath
   (quote
    ("/home/christopher/Documents/Universitet/advanced computer systems/Assignment 1/acertainbookstore-assignment1/lib/*")))
 '(jdee-global-classpath nil)
 '(jdee-junit-working-directory
   "/home/christopher/Documents/Universitet/advanced computer systems/Assignment 1/acertainbookstore-assignment1/bin/com/acertainbookstore/client/tests/")
 '(jdee-server-dir "~/myJars")
 '(minimap-minimum-width 20)
 '(minimap-mode t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("Elpa" . "http://tromey.com/elpa/"))))
 '(package-selected-packages
   (quote
    (validate flycheck-package cider minions moody neotree dracula-theme all-the-icons fsharp-mode whitespace-cleanup-mode use-package sml-mode smex pyenv-mode mode-icons minimap jedi jdee jdecomp iasm-mode haskell-mode fountain-mode flyspell-correct-popup flx-ido elpy eclim ecb drag-stuff company-jedi))))
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "light steel blue"))))
 '(py-variable-name-face ((t (:inherit default)))))


;; -- setup custom config -- ;;

(global-unset-key (kbd "C-x C-c"))

;; initialize custom theme
(package-initialize)
(load-theme 'dracula)

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

;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))


(eval-when-compile
  (require 'use-package))
  (require 'diminish)
  (require 'bind-key)
  (require 'iso-transl)

;; C-mode when editing hermes files
(use-package c-mode
  :mode (("\\.hms\\'" . c-mode)))

;; Web-mode
(use-package web-mode
  :load-path "~/.emacs.d/web-mode/"
  :mode (("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.html?\\'" . web-mode))
  :interpreter "web-mode")

;; Beacon mode
(use-package beacon
  :load-path "~/.emacs.d/beacon/"
  :config (beacon-mode 1))

;; whitespace mode
(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  (add-hook 'prog-mode-hook 'whitespace-mode)
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

;; smex M-x autocomplete
(use-package smex
  :config
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (global-set-key (kbd "M-x") 'smex))

;; mode-icon
(use-package mode-icons
  :load-path "~/.emacs.d/icon-mode/"
  :config (mode-icons-mode))

;; prolog mode
(use-package prolog-mode
  :load-path "~/.emacs.d/prolog/"
  :mode (("\\.pl\\'" . prolog-mode )
	 ("\\.plt\\'" . prolog-mode))
  :config
  (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t))

;; flx-ido
(use-package flx-ido
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

;; nyan-cat
(use-package nyan-mode
  :load-path "~/.emacs.d/nyan-mode-master/"
  :config
  (nyan-mode)
  (nyan-start-animation))

(use-package linum
  :config
  (column-number-mode t)
  (global-linum-mode t)
  (setq global-mode-string
	'(:eval (format "%d chars" (- (line-end-position) (line-beginning-position))))))

;; setup neotree to use icons
(use-package neotree
  :config
  (global-set-key (kbd "C-<") 'neotree-toggle)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; mode-line setup
(use-package minions
  :ensure t
  :init (minions-mode)
  :config
  (setq
   minions-mode-line-lighter "#"
   minions-direct '(flycheck-mode
		    cider-mode)))

(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))
