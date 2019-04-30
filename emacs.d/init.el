(setq gc-cons-threshold 100000000)

(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package)
(require 'package-util)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(ensure-package-installed
 'use-package
)

(require 'shorten-dir)
(require 'minimal-ui)
(require 'backups)
(require 'term-title-update)

(require 'company-cfg)
(require 'custom-funcs)
(require 'deft-cfg)
(require 'editorconfig-cfg)
(require 'electric-pair-cfg)
(require 'evil-cfg)
(require 'exec-path-cfg)
(require 'expand-region-cfg)
(require 'flycheck-cfg)
(require 'go-cfg)
(require 'helm-cfg)
(require 'haskell-cfg)
(require 'js-cfg)
(require 'lsp-cfg)
(require 'org-cfg)
(require 'popwin-cfg)
(require 'auctex-cfg)
(require 'rjsx-cfg)
(require 'yas-cfg)

(ensure-package-installed
 'simpleclip
 'shell-pop
)
(simpleclip-mode 1)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
