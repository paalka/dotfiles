(require 'package-util)

(ensure-package-installed 
 'company
 'go-mode
 'company-go
 'company-jedi
)

;; Enable company-mode globally
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)

(eval-after-load 'company
                   '(add-to-list 'company-backends 'company-go))

(defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)


(advice-add 'company-complete-common :before (lambda () (setq my-company-point (point))))
(advice-add 'company-complete-common :after (lambda ()
					      (when (equal my-company-point (point))
						(yas-expand))))

(provide 'company-cfg)
