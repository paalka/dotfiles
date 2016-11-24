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

(setq tramp-default-method "ssh")

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
 'projectile
 'rainbow-delimiters
 'flycheck
)

;;;; Package settings
(global-evil-leader-mode)
(evil-leader/set-key
  "a" #'helm-M-x
  "f" #'helm-find-files
  "p" #'helm-projectile
  "s" 'switch-to-buffer
  "k" 'kill-buffer)

(evil-leader/set-leader "<SPC>")
(evil-mode 1)

(require 'helm-config)
(helm-mode 1)
(helm-projectile-on)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; Auto-complete one there is only a single match
(setq helm-ff-auto-update-initial-value t)


;; Enable company-mode globally
(add-hook 'after-init-hook 'global-company-mode)

;; Enable rainbow delimiters when in prog-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Prevent org-mode from folding sections on start-up
(setq org-startup-folded nil)

;; Make it possible to esacpe windows using jk
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jk")

(global-flycheck-mode)
