(setq gc-cons-threshold 100000000)

;;;; Visual settings
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-splash-screen t)

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

(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
	(output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
        output))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'gruber-darker t)

(global-linum-mode t)
(setq linum-format "%d ")

;; Highlight the currenly selected line
(global-hl-line-mode 1)

(set-default-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 80)

;;;; Misc
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.backups")) ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq-default fill-column 78)

(setq initial-scratch-message "")

(setq tramp-default-method "ssh")

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;;; Handle packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed
 'helm
 'helm-projectile
 'evil
 'evil-escape
 'evil-leader
 'company
 'company-go
 'projectile
 'rainbow-delimiters
 'flycheck-gometalinter
 'flycheck
 'go-mode
 'lua-mode
 'simpleclip
 'editorconfig
)

;; Prevent org-mode from folding sections on start-up
(setq org-startup-folded nil)

;;;; Package settings
(global-evil-leader-mode)
(evil-leader/set-key
  "a" #'helm-M-x
  "p" #'helm-projectile
  "s" #'helm-mini
  "k" 'kill-buffer
  "-" 'split-window-below
  "j" 'other-window)

(evil-leader/set-leader "<SPC>")
(evil-mode 1)

;; Make it possible to esacpe windows using jk
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)

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

;; Enable company-mode globally
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)

(eval-after-load 'company
                   '(add-to-list 'company-backends 'company-go))

;; Enable rainbow delimiters when in prog-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Auto close brackets. New in emacs 24
(electric-pair-mode 1)

(global-flycheck-mode)

(eval-after-load 'flycheck
                   '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))

(setq flycheck-gometalinter-vendor t)
(setq flycheck-gometalinter-errors-only t)
(setq flycheck-gometalinter-fast t)

(simpleclip-mode 1)

(editorconfig-mode 1)
