(setq gc-cons-threshold 100000000)

(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
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
(require 'electric-pair-cfg)
(require 'popwin-cfg)
(require 'expand-region-cfg)
(require 'custom-funcs)

(ensure-package-installed
 'simpleclip
 'shell-pop
)
(simpleclip-mode 1)

(custom-set-variables
 '(safe-local-variable-values
   (quote
    ((eval when
	   (fboundp
	    (quote rainbow-mode))
	   (rainbow-mode 1)))))
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-window-size 35)
 '(shell-pop-full-span t)
 '(shell-pop-window-position "bottom")
)

;; ensure that whitespace and line numbers are not shown in the terminal.
(add-hook 'term-mode-hook 'my-inhibit-global-linum-mode)
(add-hook 'term-mode-hook 'my-inhibit-global-whitespace)

(defun my-inhibit-global-linum-mode ()
  "Counter-act `global-linum-mode'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local))


(defun my-inhibit-global-whitespace ()
  "Counter-act `global-whitespace'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (setq-default show-trailing-whitespace nil))
            :append :local))
