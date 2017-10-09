(require 'shorten-dir)
(defun xterm-title-update ()
  (interactive)
  (send-string-to-terminal (concat "\033]1;" (buffer-name) "\007"))
  (if buffer-file-name
      (send-string-to-terminal (concat "\033]2;" "[emacs] " (shorten-directory (buffer-file-name) 50)  "\007"))
    (send-string-to-terminal (concat  "\033]2;" (buffer-name) "\007"))))


(if (not window-system)
    (add-hook 'post-command-hook 'xterm-title-update))

(provide 'term-title-update)
