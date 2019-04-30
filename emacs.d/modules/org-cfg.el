;; Prevent org-mode from folding sections on start-up
(setq org-startup-folded nil)

(provide 'org-cfg)
(add-hook 'org-mode-hook 'auto-fill-mode)

(setq org-capture-templates
      '(
	("t" "Todo" entry (file+headline "~/documents/org/todos/todos.org" "Tasks")
	 "* TODO %?\n  %i\n")
	("l" "Long reads" entry (file "~/documents/org/long-reads/long-reads.org")
	 "")
	)
)

(defun my/org-file-by-date ()
  "Create an Org file with current time as name."
  (find-file (format-time-string "~/documents/org/journal/%Y-%m-%d.org")))

(add-to-list 'org-capture-templates
	     '("j" "Journal" plain
	       (function my/org-file-by-date)
	       ""))

(defvar my-org-capture-before-config nil
  "Window configuration before `org-capture'.")

(defadvice org-capture (before save-config activate)
  "Save the window configuration before `org-capture'."
  (setq my-org-capture-before-config (current-window-configuration)))

(add-hook 'org-capture-mode-hook 'delete-other-windows)

(setq org-agenda-files (list "~/documents/org/todos/todos.org"))
