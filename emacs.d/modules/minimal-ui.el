(setq-default mode-line-format
 '(;; Position, including warning for 80 columns
   (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%3c" 'face
		      (if (>= (current-column) 80)
			  'mode-line-80col-face
			'mode-line-position-face)))
   mode-line-client
   "  "
   ;; read-only or modified status
   (:eval
    (cond (buffer-read-only
	   (propertize " RO " 'face 'mode-line-read-only-face))
	  ((buffer-modified-p)
	   (propertize " ** " 'face 'mode-line-modified-face))
	  (t "      ")))
   "    "
   ;; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 30))
		face mode-line-folder-face)
   (:propertize "%b"
		face mode-line-filename-face)
   " %n "
   ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
		face mode-line-mode-face)
   "%] "
   "\t"
   (:eval (propertize (format-mode-line minor-mode-alist)
		      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
		face mode-line-process-face)
   (global-mode-string global-mode-string)
   ))


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