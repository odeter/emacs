;;; chatgpt-arcana-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "chatgpt-arcana" "chatgpt-arcana.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from chatgpt-arcana.el

(autoload 'chatgpt-arcana-replace-region "chatgpt-arcana" "\
Send PROMPT and selected region to ChatGPT and replace region with output.

\(fn PROMPT)" t nil)

(autoload 'chatgpt-arcana-insert "chatgpt-arcana" "\
Insert text at, before, or after the selected region or point.
Send the selected region / custom PROMPT to the OpenAI API with PROMPT
and insert the output before/after the region or at point.
With BEFORE, insert the output before the region.
With IGNORE-REGION, don't pay attention to the selected region.

\(fn PROMPT &optional BEFORE IGNORE-REGION)" nil nil)

(autoload 'chatgpt-arcana-insert-at-point-with-context "chatgpt-arcana" "\
Send PROMPT and context around point to ChatGPT and insert output at point.
NUM-LINES configues how many lines of context to send.

\(fn PROMPT &optional NUM-LINES)" t nil)

(autoload 'chatgpt-arcana-insert-after-region "chatgpt-arcana" "\
Send PROMPT and selected region to ChatGPT and insert output after region.

\(fn PROMPT)" t nil)

(autoload 'chatgpt-arcana-insert-before-region "chatgpt-arcana" "\
Send PROMPT and selected region to ChatGPT and insert output before region.

\(fn PROMPT)" t nil)

(autoload 'chatgpt-arcana-insert-at-point "chatgpt-arcana" "\
Send PROMPT to ChatGPT and insert output at point.

\(fn PROMPT)" t nil)

(autoload 'chatgpt-arcana-start-chat-with-system-prompt "chatgpt-arcana" "\
Start a chat with SYSTEM-PROMPT and PROMPT.
SYSTEM-PROMPT can be seen as a meta-instruction to ChatGPT and has
a lot of steering impact on its behaviour.
PROMPT is a standard instruction or message from the user.

\(fn SYSTEM-PROMPT PROMPT)" t nil)

(autoload 'chatgpt-arcana-start-chat "chatgpt-arcana" "\
Start a chat with PROMPT.
If the universal argument is set, use current buffer mode to set system prompt.
Otherwise, use the chat prompt saved in `chatgpt-arcana-system-prompts-alist'.
Use `chatgpt-arcana-start-chat-with-system-prompt' if you want to set the system
prompt manually.

\(fn PROMPT)" t nil)

(autoload 'chatgpt-arcana-resume-chat "chatgpt-arcana" "\
Resume a previous chat in the `chatgpt-arcana-chat-autosave-directory'.
The directory is expected to contain `.chatgpt-arcana.md' files.
Prompt the users to select a file to resume the chat, using the built-in picker.
If the user cancels the picker, the function will do nothing.
If no matching files are found, the function will display an error message." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "chatgpt-arcana" '("chatgpt-arcana-")))

;;;***

(provide 'chatgpt-arcana-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; chatgpt-arcana-autoloads.el ends here
