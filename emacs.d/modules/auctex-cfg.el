(require 'package-util)

(ensure-package-installed
 'auctex
 'company-auctex
)

(require 'tex-site)
(add-hook 'plain-TeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			  (cons "$" "$"))))
(add-hook 'LaTeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			  (cons "\\(" "\\)"))))

(setq tex-fontify-script nil)
(setq font-latex-fontify-script nil)

(require 'company-auctex)
(company-auctex-init)

(defun my/auctex-mode-hook ()
    (add-to-list 'company-backends 'company-auctex))

(add-hook 'TeX-mode-hook 'my/auctex-mode-hook)

(provide 'auctex-cfg)
