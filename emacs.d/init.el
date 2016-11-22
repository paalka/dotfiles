;;;; Visual settings
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-splash-screen t)

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
 'key-chord
 'company
 'projectile
 'rainbow-delimiters
)

;;;; Package settings
(evil-mode 1)

(require 'helm-config)
(helm-mode 1)
(helm-projectile-on)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; Auto-complete one there is only a single match
(setq helm-ff-auto-update-initial-value t)

(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jj" 'evil-normal-state)

;; Enable company-mode globally
(add-hook 'after-init-hook 'global-company-mode)

;; Enable rainbow delimiters when in prog-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Prevent org-mode from folding sections on start-up
(setq org-startup-folded nil)
