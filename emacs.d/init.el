(setq gc-cons-threshold 100000000)

(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'shorten-dir)
(require 'minimal-ui)
(require 'backups)
(require 'term-title-update)

(require 'evil-cfg)
(require 'helm-cfg)
(require 'company-cfg)
(require 'flycheck-cfg)
(require 'org-cfg)
(require 'rjsx-cfg)
(require 'exec-path-cfg)
(require 'editorconfig-cfg)
(require 'rainbow-delim-cfg)
(require 'electric-pair-cfg)
(require 'popwin-cfg)
(require 'expand-region-cfg)
(require 'custom-funcs)

(ensure-package-installed
 'simpleclip
)

(setq-default show-trailing-whitespace t)
