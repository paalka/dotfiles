(require 'package-util)

(ensure-package-installed
 'evil
 'evil-escape
 'evil-leader
)

(global-evil-leader-mode)
(evil-leader/set-key
  "a" #'helm-M-x
  "p" #'helm-projectile-find-file
  "s" #'helm-projectile-switch-to-buffer
  "b" #'helm-buffers-list
  "f" #'helm-ag
  "k" 'kill-buffer
  "-" 'split-window-below
  "j" 'other-window)

(evil-leader/set-leader "<SPC>")
(evil-mode 1)

;; Make it possible to esacpe windows using jk
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)

(evil-select-search-module 'evil-search-module 'evil-search)

(provide 'evil-cfg)
