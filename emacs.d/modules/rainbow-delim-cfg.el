(require 'package-util)

(ensure-package-installed 'rainbow-delimiters)

;; Enable rainbow delimiters when in prog-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(provide 'rainbow-delim-cfg)
