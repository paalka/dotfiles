(use-package deft
  :ensure t
  :config
    (setq deft-extensions '("txt" "tex" "org"))
    (setq deft-directory "~/documents/school")
    (setq deft-recursive t)
    (setq deft-default-extension "org")
    (setq deft-text-mode 'org-mode)
    (setq deft-use-filename-as-title t)
)
(provide 'deft-cfg)
