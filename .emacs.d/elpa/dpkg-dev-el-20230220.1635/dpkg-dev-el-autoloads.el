;;; dpkg-dev-el-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "debian-autoloads" "debian-autoloads.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from debian-autoloads.el

(require 'dpkg-dev-el)

;;;***

;;;### (autoloads nil "debian-bts-control" "debian-bts-control.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from debian-bts-control.el

(autoload 'debian-bts-control "debian-bts-control" "\
Contruct a message with initial ACTION command for control@bugs.debian.org.
Contructs a new control command line if called from within the message
being constructed.

If prefix arg is provided, use the current buffer instead instead of
creating a new outgoing email message buffer.
The current buffer is also used if the current major mode matches one listed
in `debian-bts-control-modes-to-reuse'.

\(fn ACTION &optional ARG)" t nil)

(autoload 'emacs-bts-control "debian-bts-control" "\
Contruct a message with ACTION command for control@debbugs.gnu.org.
Contructs a new control command line if called from within the message
being constructed.

If prefix arg is provided, use the current buffer instead instead of
creating a new outgoing email message buffer.
The current buffer is also used if the current major mode matches one listed
in `debian-bts-control-modes-to-reuse'.

\(fn ACTION &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "debian-bts-control" '("debian-bts-")))

;;;***

;;;### (autoloads nil "debian-changelog-mode" "debian-changelog-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from debian-changelog-mode.el

(autoload 'debian-changelog-add-entry "debian-changelog-mode" "\
Add a new change entry to a debian-style changelog.
If called from buffer other than a debian/changelog, this will search
for the debian/changelog file to add the entry to." t nil)

(autoload 'debian-changelog-mode "debian-changelog-mode" "\
Major mode for editing Debian-style change logs.
Runs `debian-changelog-mode-hook' if it exists.

Key bindings:

\\{debian-changelog-mode-map}

If you want to use your debian.org email address for debian/changelog
entries without using it for the rest of your email, use the `customize`
interface to set it, or simply set the variable
`debian-changelog-mailing-address' in your ~/.emacs file, e.g.

 (setq debian-changelog-mailing-address \"myname@debian.org\"))" t nil)
(add-to-list 'auto-mode-alist '("/debian/*NEWS" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("NEWS.Debian" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("/debian/\\([[:lower:][:digit:]][[:lower:][:digit:].+-]+\\.\\)?changelog\\'" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("changelog.Debian" . debian-changelog-mode))
(add-to-list 'auto-mode-alist '("changelog.dch" . debian-changelog-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "debian-changelog-mode" '("debian-changelog-" "imenu--create-debian-changelog-index")))

;;;***

;;;### (autoloads nil "debian-control-mode" "debian-control-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from debian-control-mode.el

(autoload 'debian-control-mode "debian-control-mode" "\
A major mode for editing Debian control files (i.e. debian/control).

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("/debian/control\\'" . debian-control-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "debian-control-mode" '("debian-control-")))

;;;***

;;;### (autoloads nil "debian-copyright" "debian-copyright.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from debian-copyright.el

(autoload 'debian-copyright-mode "debian-copyright" "\
Mode to edit and read debian/copyright.
\\{debian-copyright-mode-map}" t nil)

(add-to-list 'auto-mode-alist '("debian/.*copyright\\'" . debian-copyright-mode))

(add-to-list 'auto-mode-alist '("\\`/usr/share/doc/.*/copyright" . debian-copyright-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "debian-copyright" '("debian-copyright-")))

;;;***

;;;### (autoloads nil "readme-debian" "readme-debian.el" (0 0 0 0))
;;; Generated autoloads from readme-debian.el

(autoload 'readme-debian-mode "readme-debian" "\
Mode for reading and editing README.Debian files.
Upon saving the visited README.Debian file, the timestamp at the bottom
will be updated.

\\{readme-debian-mode-map}" t nil)
(add-to-list 'auto-mode-alist '("debian/.*README.*Debian$" . readme-debian-mode))
(add-to-list 'auto-mode-alist '("^/usr/share/doc/.*/README.*Debian.*$" . readme-debian-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "readme-debian" '("readme-debian-")))

;;;***

;;;### (autoloads nil nil ("dpkg-dev-el-pkg.el" "dpkg-dev-el.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dpkg-dev-el-autoloads.el ends here
