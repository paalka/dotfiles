;; Prevent org-mode from folding sections on start-up
(setq org-startup-folded nil)

(provide 'org-cfg)
(add-hook 'org-mode-hook 'auto-fill-mode)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/documents/org/todos/todos.org" "Tasks")
	 "* TODO %?\n  %i\n")))

(defun my/org-file-by-date ()
  "Create an Org file with current time as name."
  (find-file (format-time-string "~/documents/org/journal/%Y-%m-%d.org")))

(add-to-list 'org-capture-templates
	     '("j" "Journal" plain
	       (function my/org-file-by-date)
	       ""))


(setq org-agenda-files (list "~/documents/org/todos/todos.org"))
