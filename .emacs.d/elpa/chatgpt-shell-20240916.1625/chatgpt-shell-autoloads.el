;;; chatgpt-shell-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from chatgpt-shell.el

(autoload 'chatgpt-shell "chatgpt-shell" "\
Start a ChatGPT shell interactive command.

With NEW-SESSION, start a new session.

(fn &optional NEW-SESSION)" t)
(autoload 'chatgpt-shell-refactor-code "chatgpt-shell" "\
Refactor code from region using ChatGPT." t)
(autoload 'chatgpt-shell-write-git-commit "chatgpt-shell" "\
Write commit from region using ChatGPT." t)
(autoload 'chatgpt-shell-generate-unit-test "chatgpt-shell" "\
Generate unit-test for the code from region using ChatGPT." t)
(autoload 'chatgpt-shell-proofread-region "chatgpt-shell" "\
Proofread English from region using ChatGPT." t)
(autoload 'chatgpt-shell-eshell-whats-wrong-with-last-command "chatgpt-shell" "\
Ask ChatGPT what's wrong with the last eshell command." t)
(autoload 'chatgpt-shell-eshell-summarize-last-command-output "chatgpt-shell" "\
Ask ChatGPT to summarize the last command output." t)
(autoload 'chatgpt-shell-send-region "chatgpt-shell" "\
Send region to ChatGPT.
With prefix REVIEW prompt before sending to ChatGPT.

(fn REVIEW)" t)
(autoload 'chatgpt-shell-send-and-review-region "chatgpt-shell" "\
Send region to ChatGPT, review before submitting." t)
(register-definition-prefixes "chatgpt-shell" '("chatgpt-shell-"))

;;; End of scraped data

(provide 'chatgpt-shell-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; chatgpt-shell-autoloads.el ends here