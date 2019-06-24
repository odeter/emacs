;;; flyspell-correct-popup-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "flyspell-correct-popup" "flyspell-correct-popup.el"
;;;;;;  (23639 28495 636233 423000))
;;; Generated autoloads from flyspell-correct-popup.el

(autoload 'flyspell-correct-popup "flyspell-correct-popup" "\
Run `popup-menu*' for the given CANDIDATES.

List of CANDIDATES is given by flyspell for the WORD.

Return a selected word to use as a replacement or a tuple
of (command, word) to be used by `flyspell-do-correct'.

\(fn CANDIDATES WORD)" nil nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; flyspell-correct-popup-autoloads.el ends here
