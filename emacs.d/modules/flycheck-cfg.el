(require 'package-util)

(ensure-package-installed
 'flycheck-gometalinter
 'flycheck
)

(global-flycheck-mode)

(eval-after-load 'flycheck
                   '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))

(setq flycheck-gometalinter-vendor t)
(setq flycheck-gometalinter-fast t)

(setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))

(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'flycheck-cfg)
