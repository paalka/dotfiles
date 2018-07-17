(require 'package-util)

(ensure-package-installed
 'rjsx-mode
 'js2-mode
 'js2-mode
 'lsp-ui
 'lsp-mode
 'lsp-javascript-flow
)
(require 'lsp-javascript-flow)
(add-hook 'js-mode-hook #'lsp-javascript-flow-enable)
(add-hook 'js2-mode-hook #'lsp-javascript-flow-enable) ;; for js2-mode support
(add-hook 'rjsx-mode #'lsp-javascript-flow-enable) ;; for rjsx-mode support

(provide 'js-cfg)
