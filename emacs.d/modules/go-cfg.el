(use-package rust-mode
  :ensure t
)

(use-package lsp-go
 :ensure t
 :config
 (add-hook 'go-mode-hook #'lsp-go-enable)
)

(provide 'go-cfg)
