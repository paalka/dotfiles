(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-splash-screen t)

(global-linum-mode t)
(setq linum-format "%d ")

(load-theme 'gruber-darker t)

;; Highlight the currenly selected line
(global-hl-line-mode 1)

(set-default-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 80)

(setq-default fill-column 78)
(setq initial-scratch-message "")

(show-paren-mode 1)

(provide 'minimal-ui)
