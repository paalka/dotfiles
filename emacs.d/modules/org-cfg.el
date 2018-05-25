;; Prevent org-mode from folding sections on start-up
(setq org-startup-folded nil)

(provide 'org-cfg)
(add-hook 'org-mode-hook 'auto-fill-mode)
