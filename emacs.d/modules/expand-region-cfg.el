(require 'package-util)
(ensure-package-installed 'expand-region)
(require 'expand-region)
(eval-after-load "evil" '(setq expand-region-contract-fast-key "z"))
(evil-leader/set-key "er" 'er/expand-region)

(provide 'expand-region-cfg)
