(require 'package-util)

(ensure-package-installed
 'helm
 'projectile
 'helm-projectile
)

(require 'helm-config)
(helm-mode 1)
(helm-projectile-on)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(setq helm-M-x-fuzzy-match t)

(setq helm-candidate-number-limit 500)

(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

(provide 'helm-cfg)
