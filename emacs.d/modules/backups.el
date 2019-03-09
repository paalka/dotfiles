(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.backups")) ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(recentf-mode 1)
(setq recentf-max-menu-items 100)

(provide 'backups)
