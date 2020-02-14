(setq doom-theme 'doom-outrun-electric)

(setq doom-font (font-spec :family "Gintronic" :size 12 :weight 'bold))

(setq user-full-name "anonymous"
      user-mail-address "")

(setq display-line-numbers-type `visual)

(setq org-image-actual-width nil)

(setq org-directory "~/sync/org")

(setq org-ellipsis " ▼ ")

(add-hook 'org-mode-hook #'auto-fill-mode)

(add-hook 'org-mode-hook
  (lambda ()
    (use-package org-drill)))

(setq org-bullets-bullet-list '("✿"))

(setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 9)))

(setq org-outline-path-complete-in-steps nil)

(setq org-refile-use-outline-path t)

(setq org-agenda-skip-deadline-prewarning-if-scheduled t)

(setq company-dabbrev-downcase nil)

(setq company-idle-delay 0.2)

(remove-hook 'company-mode-hook #'company-prescient-mode)

(unless window-system
  (xterm-mouse-mode)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

(add-hook 'web-mode-hook
  (lambda ()
    (setq web-mode-script-padding 0
          web-mode-style-padding 0
          web-mode-block-padding 2
          web-mode-markup-indent-offset 2
          web-mode-css-indent-offset 2
          web-mode-code-indent-offset 2
          web-mode-enable-auto-closing t
          web-mode-enable-auto-pairing t
          web-mode-auto-close-style 2)))

;; (setq user-full-name "anonymous"
;;       user-mail-address "")
;;
;; (setq doom-font (font-spec :family "Gintronic" :size 14 :weight 'bold))
;;
;; (setq display-line-numbers-type `visual)
;;
;; (unless window-system
;;   (xterm-mouse-mode)
;;   (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
;;   (global-set-key (kbd "<mouse-5>") 'scroll-up-line))
;;
;; (add-hook 'org-mode-hook #'auto-fill-mode)
;;
;; (add-hook 'org-mode-hook
;;   (lambda ()
;;     (use-package org-drill)
;;     (custom-set-faces
;;       '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
;;       '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
;;       '(org-level-3 ((t (:inherit outline-2 :height 1.1))))
;;       '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
;;       '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))))
;;
;; (setq org-agenda-skip-deadline-prewarning-if-scheduled nil
;;       org-bullet-bullets-list '("✿")
;;       org-refile-targets '((nil :maxlevel . 9)
;;         (org-agenda-files :maxlevel . 9))
;;       org-outline-path-complete-in-steps nil
;;       org-refile-use-outline-path t
;;       org-image-actual-width nil
;;       org-directory "~/sync/org"
;;       org-ellipsis " ▼ ")
;;
;;
;; (add-hook 'company-mode-hook
;;   (lambda ()
;;     (setq company-dabbrev-downcase nil
;;           company-idle-delay 0.2)))
;;
;; (remove-hook 'company-mode-hook #'company-prescient-mode)
;;
;; (add-hook 'web-mode-hook
;;   (lambda ()
;;     (setq web-mode-script-padding 0
;;           web-mode-style-padding 0
;;           web-mode-block-padding 2
;;           web-mode-markup-indent-offset 2
;;           web-mode-css-indent-offset 2
;;           web-mode-code-indent-offset 2
;;           web-mode-enable-auto-closing t
;;           web-mode-enable-auto-pairing t
;;           web-mode-auto-close-style 2)))
