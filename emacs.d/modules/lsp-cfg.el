(require 'package-util)

(ensure-package-installed
 'lsp-mode
 'lsp-ui
)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(provide 'lsp-cfg)
