(require 'package-util)

(ensure-package-installed
 'evil
 'evil-escape
 'evil-leader
 'evil-surround
 'avy
 'iedit
)

(global-evil-leader-mode)
(evil-leader/set-key
  "a" #'helm-M-x
  "p" #'helm-projectile-find-file
  "s" #'helm-projectile-switch-to-buffer
  "b" #'helm-buffers-list
  "w" #'helm-projectile-switch-project
  "g" #'helm-ag
  "f" 'avy-goto-char-2
  "k" 'kill-buffer
  "-" 'split-window-below
  "v" 'simpleclip-paste
  "t" 'shell-pop
  "i" 'iedit-mode
  "j" 'other-window)

(evil-leader/set-leader "<SPC>")
(evil-mode 1)

;; Make it possible to esacpe windows using jk
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)

(evil-select-search-module 'evil-search-module 'evil-search)
(global-evil-surround-mode 1)

(provide 'evil-cfg)
