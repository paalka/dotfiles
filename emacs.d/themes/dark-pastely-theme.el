(deftheme dark-pastely
  "Dark pastely color theme for Emacs 24")

;; Please, install rainbow-mode.
;; Colors with +x are lighter. Colors with -x are darker.
(let ((dark-pastely-fg        "#dfdfdf")
      (dark-pastely-white     "#dfdfdf")
      (dark-pastely-black     "#000000")
      (dark-pastely-bg        "#151413")
      (dark-pastely-bg+1      "#212121")
      (dark-pastely-bg+2      "#303030")
      (dark-pastely-grey      "#918c8c")
      (dark-pastely-pink      "#d4abf9")
      (dark-pastely-pink+1    "#ffc9fb")
      (dark-pastely-red       "#ff638f")
      (dark-pastely-orange    "#f9ba7c")
      (dark-pastely-green     "#91e2de")
      (dark-pastely-blue      "#b6b6fa")
      (dark-pastely-deep-blue "#5b4c8f")
      )

  (custom-theme-set-variables
   'dark-pastely
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'dark-pastely

   ;; AUCTeX
   `(font-latex-bold-face ((t (:foreground ,dark-pastely-blue :bold t))))
   `(font-latex-italic-face ((t (:foreground ,dark-pastely-blue :italic t))))
   `(font-latex-math-face ((t (:foreground ,dark-pastely-pink+1))))
   `(font-latex-sectioning-5-face ((t ,(list :foreground dark-pastely-blue
                                             :bold t))))
   `(font-latex-slide-title-face ((t (:foreground ,dark-pastely-blue))))
   `(font-latex-string-face ((t (:foreground ,dark-pastely-pink+1))))
   `(font-latex-warning-face ((t (:foreground ,dark-pastely-red))))

   ;; Basic Coloring (or Uncategorized)
   `(border ((t ,(list :background dark-pastely-bg
                       :foreground dark-pastely-bg))))
   `(cursor ((t (:background ,dark-pastely-fg))))
   `(default ((t ,(list :foreground dark-pastely-fg
                        :background dark-pastely-bg))))
   `(fringe ((t ,(list :background dark-pastely-bg
                       :foreground dark-pastely-bg))))
   `(link ((t (:foreground ,dark-pastely-blue :underline t))))
   `(link-visited ((t (:foreground ,dark-pastely-deep-blue :underline t))))
   `(match ((t (:background ,dark-pastely-bg))))
   `(minibuffer-prompt ((t (:foreground ,dark-pastely-blue))))
   `(region ((t (:background ,dark-pastely-bg+2 :foreground nil))))
   `(secondary-selection ((t ,(list :background dark-pastely-bg
                                    :foreground nil))))
   `(trailing-whitespace ((t ,(list :foreground dark-pastely-black
                                    :background dark-pastely-red))))
   `(tooltip ((t ,(list :background dark-pastely-bg
                        :foreground dark-pastely-white))))

   ;; Calendar
   `(holiday-face ((t (:foreground ,dark-pastely-red))))

   ;; Compilation
   `(compilation-info ((t ,(list :foreground dark-pastely-pink+1
                                 :inherit 'unspecified))))
   `(compilation-warning ((t ,(list :foreground dark-pastely-orange
                                    :bold t
                                    :inherit 'unspecified))))
   `(compilation-error ((t (:foreground ,dark-pastely-red))))
   `(compilation-mode-line-fail ((t ,(list :foreground dark-pastely-red
                                           :weight 'bold
                                           :inherit 'unspecified))))
   `(compilation-mode-line-exit ((t ,(list :foreground dark-pastely-pink+1
                                           :weight 'bold
                                           :inherit 'unspecified))))

   ;; Custom
   `(custom-state ((t (:foreground ,dark-pastely-pink+1))))

   ;; Diff
   `(diff-removed ((t ,(list :foreground dark-pastely-red
                             :background nil))))
   `(diff-added ((t ,(list :foreground dark-pastely-pink+1
                           :background nil))))

   ;; Dired
   `(dired-directory ((t (:foreground ,dark-pastely-blue :weight bold))))
   `(dired-ignored ((t ,(list :foreground dark-pastely-blue
                              :inherit 'unspecified))))

   ;; EShell
   `(eshell-ls-backup ((t (:foreground ,dark-pastely-blue))))
   `(eshell-ls-directory ((t (:foreground ,dark-pastely-blue))))
   `(eshell-ls-executable ((t (:foreground ,dark-pastely-pink+1))))
   `(eshell-ls-symlink ((t (:foreground ,dark-pastely-pink+1))))

   ;; smerge
   `(smerge-base ((t (:foreground ,dark-pastely-pink+1))))
   `(smerge-markers ((t (:foreground ,dark-pastely-pink+1))))
   `(smerge-mine ((t (:foreground ,dark-pastely-blue))))
   `(smerge-other ((t (:foreground ,dark-pastely-deep-blue))))
   `(smerge-refined-added ((t (:foreground ,dark-pastely-green))))
   `(smerge-refined-changed ((t (:foreground ,dark-pastely-orange))))
   `(smerge-refined-removed ((t (:foreground ,dark-pastely-red))))

   ;; Font Lock
   `(font-lock-builtin-face ((t (:foreground ,dark-pastely-blue))))
   `(font-lock-comment-face ((t (:foreground ,dark-pastely-grey))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,dark-pastely-grey))))
   `(font-lock-constant-face ((t (:foreground ,dark-pastely-blue))))
   `(font-lock-doc-face ((t (:foreground ,dark-pastely-pink+1))))
   `(font-lock-doc-string-face ((t (:foreground ,dark-pastely-pink+1))))
   `(font-lock-function-name-face ((t (:foreground ,dark-pastely-blue))))
   `(font-lock-keyword-face ((t (:foreground ,dark-pastely-pink+1))))
   `(font-lock-preprocessor-face ((t (:foreground ,dark-pastely-blue))))
   `(font-lock-reference-face ((t (:foreground ,dark-pastely-blue))))
   `(font-lock-string-face ((t (:foreground ,dark-pastely-pink+1))))
   `(font-lock-type-face ((t (:foreground ,dark-pastely-pink))))
   `(font-lock-variable-name-face ((t (:foreground ,dark-pastely-fg))))
   `(font-lock-warning-face ((t (:foreground ,dark-pastely-red))))

   `(eldoc-highlight-function-argument ((t (:foreground ,dark-pastely-blue))))
   `(linum ((t (:foreground ,dark-pastely-bg+2))))

   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-red)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,dark-pastely-red :weight bold :underline t))))

   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-orange)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,dark-pastely-orange :weight bold :underline t))))

   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-fg)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground nil :weight bold :underline t))))

   ;; Flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-red)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,dark-pastely-red :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-pink+1)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,dark-pastely-pink+1 :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-pink+1)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,dark-pastely-pink+1 :weight bold :underline t))))

   ;; Flyspell
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-red) :inherit unspecified))
      (t (:foreground ,dark-pastely-red :weight bold :underline t))))
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,dark-pastely-pink+1) :inherit unspecified))
      (t (:foreground ,dark-pastely-pink+1 :weight bold :underline t))))

   ;; Helm
   `(helm-candidate-number ((t ,(list :background dark-pastely-bg
                                      :foreground dark-pastely-pink+1
                                      :bold t))))
   `(helm-ff-directory ((t ,(list :foreground dark-pastely-blue
                                  :background dark-pastely-bg
                                  :bold t))))
   `(helm-ff-executable ((t (:foreground ,dark-pastely-pink+1))))
   `(helm-ff-file ((t (:foreground ,dark-pastely-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t ,(list :foreground dark-pastely-bg
                                        :background dark-pastely-red))))
   `(helm-ff-symlink ((t (:foreground ,dark-pastely-pink+1 :bold t))))
   `(helm-selection-line ((t (:background ,dark-pastely-bg+1))))
   `(helm-selection ((t (:background ,dark-pastely-bg+1 :underline nil))))
   `(helm-match ((t (:foreground ,dark-pastely-pink+1 :underline nil))))
   `(helm-buffer--details ((t (:foreground ,dark-pastely-pink+1 :underline nil))))
   `(helm-source-header ((t ,(list :foreground dark-pastely-pink+1
                                   :background dark-pastely-bg
                                   :box (list :line-width -1
                                              :style 'released-button)))))

   ;; Ido
   `(ido-first-match ((t (:foreground ,dark-pastely-pink+1 :bold nil))))
   `(ido-only-match ((t (:foreground ,dark-pastely-grey :weight bold))))
   `(ido-subdir ((t (:foreground ,dark-pastely-blue :weight bold))))

   ;; Info
   `(info-xref ((t (:foreground ,dark-pastely-blue))))
   `(info-visited ((t (:foreground ,dark-pastely-deep-blue))))

   ;; Line Highlighting
   `(highlight ((t (:background ,dark-pastely-bg+1 :foreground nil))))
   `(highlight-current-line-face ((t ,(list :background dark-pastely-bg+1
                                            :foreground nil))))
   ;; Message
   `(message-header-name ((t (:foreground ,dark-pastely-pink+1))))

   ;; Mode Line
   `(mode-line ((t ,(list :background dark-pastely-bg
                          :foreground dark-pastely-white))))
   `(mode-line-buffer-id ((t ,(list :background dark-pastely-bg
                                    :foreground dark-pastely-white))))
   `(mode-line-inactive ((t ,(list :background dark-pastely-bg
                                   :foreground dark-pastely-blue))))

   ;; Org Mode
   `(org-agenda-structure ((t (:foreground ,dark-pastely-blue))))
   `(org-done ((t (:foreground ,dark-pastely-pink+1))))
   `(org-todo ((t (:foreground ,dark-pastely-red))))
   `(org-upcoming-deadline ((t (:foreground ,dark-pastely-pink+1))))

   ;; Search
   `(isearch ((t ,(list :foreground dark-pastely-black
                        :background dark-pastely-fg))))
   `(isearch-fail ((t ,(list :foreground dark-pastely-black
                             :background dark-pastely-red))))
   `(isearch-lazy-highlight-face ((t ,(list
                                       :foreground dark-pastely-bg+1
                                       :background dark-pastely-grey))))

   ;; Sh
   `(sh-quoted-exec ((t (:foreground ,dark-pastely-red))))

   ;; Show Paren
   `(show-paren-match ((t ,(list :background dark-pastely-grey
                                        :weight 'bold))))
   `(show-paren-match-face ((t ,(list :foreground dark-pastely-fg
                                        :weight 'bold))))
   `(show-paren-mismatch-face ((t (:background ,dark-pastely-red))))

   ;; Slime
   `(slime-repl-inputed-output-face ((t (:foreground ,dark-pastely-red))))

   ;; Speedbar
   `(speedbar-directory-face ((t ,(list :foreground dark-pastely-blue
                                        :weight 'bold))))
   `(speedbar-file-face ((t (:foreground ,dark-pastely-fg))))
   `(speedbar-highlight-face ((t (:background ,dark-pastely-bg))))
   `(speedbar-selected-face ((t (:foreground ,dark-pastely-red))))
   `(speedbar-tag-face ((t (:foreground ,dark-pastely-pink+1))))

   ;; Which Function
   `(which-func ((t (:foreground ,dark-pastely-deep-blue))))

   ;; Whitespace
   `(whitespace-space ((t ,(list :background dark-pastely-bg
                                 :foreground dark-pastely-bg))))
   `(whitespace-tab ((t ,(list :background dark-pastely-bg
                               :foreground dark-pastely-bg))))
   `(whitespace-hspace ((t ,(list :background dark-pastely-bg
                                  :foreground dark-pastely-bg))))
   `(whitespace-line ((t ,(list :background dark-pastely-bg
                                :foreground dark-pastely-red))))
   `(whitespace-newline ((t ,(list :background dark-pastely-bg
                                   :foreground dark-pastely-bg))))
   `(whitespace-trailing ((t ,(list :background dark-pastely-red
                                    :foreground dark-pastely-red))))
   `(whitespace-empty ((t ,(list :background dark-pastely-pink+1
                                 :foreground dark-pastely-pink+1))))
   `(whitespace-indentation ((t ,(list :background dark-pastely-pink+1
                                       :foreground dark-pastely-red))))
   `(whitespace-space-after-tab ((t ,(list :background dark-pastely-pink+1
                                           :foreground dark-pastely-pink+1))))
   `(whitespace-space-before-tab ((t ,(list :background dark-pastely-grey
                                            :foreground dark-pastely-grey))))

   ;;;;; company-mode
   `(company-tooltip ((t (:foreground ,dark-pastely-fg :background ,dark-pastely-bg))))
   `(company-tooltip-annotation ((t (:foreground ,dark-pastely-grey :background ,dark-pastely-bg))))
   `(company-tooltip-annotation-selection ((t (:foreground ,dark-pastely-grey :background ,dark-pastely-bg))))
   `(company-tooltip-selection ((t (:foreground ,dark-pastely-fg :background ,dark-pastely-bg+2))))
   `(company-tooltip-mouse ((t (:background ,dark-pastely-bg))))
   `(company-tooltip-common ((t (:foreground ,dark-pastely-pink+1))))
   `(company-tooltip-common-selection ((t (:foreground ,dark-pastely-pink+1))))
   `(company-scrollbar-fg ((t (:background ,dark-pastely-bg))))
   `(company-scrollbar-bg ((t (:background ,dark-pastely-bg))))
   `(company-preview ((t (:background ,dark-pastely-pink+1))))
   `(company-preview-common ((t (:foreground ,dark-pastely-pink+1 :background ,dark-pastely-bg))))

   `(js2-function-param ((t (:foreground nil :background nil))))

   `(lsp-face-highlight-read ((t (:foreground ,dark-pastely-bg))))
   `(lsp-face-highlight-write ((t (:foreground ,dark-pastely-blue))))
   `(lsp-face-highlight-textual ((t (:foreground ,dark-pastely-pink :underline t))))
))

(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
		    :foreground "gray60" :background "gray10"
		    :inverse-video nil
		    :box '(:line-width 6 :color "gray20" :style nil))

(set-face-attribute 'mode-line-inactive nil
		    :foreground "gray80" :background "gray20"
		    :inverse-video nil
		    :box '(:line-width 6 :color "gray40" :style nil))

(set-face-attribute 'mode-line-read-only-face nil
		    :inherit 'mode-line-face
		    :foreground "#4271ae"
		    :box '(:line-width 2 :color "#4271ae"))

(set-face-attribute 'mode-line-modified-face nil
		    :inherit 'mode-line-face
		    :foreground "gray90"
		    :box '(:line-width 2 :color "#c82829"))

(set-face-attribute 'mode-line-folder-face nil
		    :inherit 'mode-line-face
		    :foreground "gray60")

(set-face-attribute 'mode-line-filename-face nil
		    :inherit 'mode-line-face
		    :foreground "gray90"
		    :weight 'bold)

(set-face-attribute 'mode-line-mode-face nil
		    :inherit 'mode-line-face
		    :foreground "gray90")

(set-face-attribute 'mode-line-minor-mode-face nil
		    :inherit 'mode-line-mode-face
		    :foreground "gray40")

(set-face-attribute 'mode-line-process-face nil
		    :inherit 'mode-line-face
		    :foreground "gray60")

(set-face-attribute 'mode-line-80col-face nil
		    :inherit 'mode-line-position-face
		    :foreground "black")

(provide-theme 'dark-pastely)
