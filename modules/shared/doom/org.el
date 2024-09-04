;;; $DOOMDIR/org.el -*- lexical-binding: t; -*-

(after! org-roam-mode
  (setq org-roam-dailies-directory "~/notes/org/roam/dailies/"
	org-roam-directory "~/notes/org/roam"))

(after! org
  (setq org-log-into-drawer t
	org-log-done-with-time t
	org-log-done 'time
	org-log-refile 'time
	org-log-repeat 'time
	org-log-redeadline 'time
	org-log-reschedule 'time
	org-insert-heading-respect-content nil
	org-agenda-files (list "~/notes/org")
	org-startup-align-all-tables t
	org-auto-align-tags nil
	org-tags-column 0
	org-fold-catch-invisible-edits 'show-and-error
	org-hide-emphasis-markers t
	org-pretty-entities t
	org-startup-folded "fold"
	org-tag-alist
	'(;; places
	  ("@home" . ?h)
	  ("@out" . ?o)

	  ;; devices
	  ("@computer" . ?c)
	  ("@iphone" . ?i)
	  ("@android" . ?a)
	  ("@tower" . ?t)
	  ("@keyboard" . ?k)

	  ;; activities/hobbies
	  ("#programming" . ?p)
	  ("#music" . ?m)
	  ("#photography" . ?g)

	  ;; alters
	  ("!switch" . ?S)
	  ("!nova" . ?N)
	  ("!persona" . ?P))))

(add-hook! org-mode
	   :remove #'org-superstar-mode
	   :append
	   'visual-line-mode
	   'variable-pitch-mode
	   'org-indent-mode
	   'org-modern-mode
	   'org-modern-agenda
	   '+org-pretty-mode)

(add-hook! org-agenda-mode-hook
  (setq org-agenda-custom-commands
	'(("d" "daily" ((agenda "" ((org-agenda-span 'day)
				    (org-deadline-warning-days 2)))))
	  ("u" "untagged tasks" tags-todo "-{.*=}" ((org-agenda-overriding-header "Untagged")))
	  ("k" "before leaving @home" tags-todo "+@out" ((org-agenda-overriding-header "checks for before leaving the house"))))))

;; ledger mode + (org-mode + org-bable)
(after! ledger-mode
  (map! :map ledger-mode-map
	:localleader
	"o" #'org-babel-tangle-jump-to-org
	#'org-babel-detangle))

;; pretty org-mode
(add-hook! 'doom-after-init-hook
	   :after org-agenda-mode-hook
	   (setq org-agenda-tags-column 0 org-agenda-block-separator ?-))
(add-hook! 'doom-after-modules-init-hook
	   :after org-mode-hook
	   #'global-org-modern-mode)
(after! org-modern-mode
  (setq org-modern-checkbox nil
	org-modern-hide-stars nil
	org-modern-list nil
	org-modern-star nil
	org-modern-fold-stars nil
	org-modern-replace-stars nil)
  (custom-set-faces
   '(org-modern-label ((t (
			   :height 1
			   :weight bold
			   :box (:line-width (0 . 0))))))))
