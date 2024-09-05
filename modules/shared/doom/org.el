;;; $DOOMDIR/org.el -*- lexical-binding: t; -*-

(add-hook! 'org-roam-mode-hook
	   '(setq org-roam-dailies-directory "~/notes/org/roam/dailies/"
		  org-roam-directory "~/notes/org/roam/"))

(add-hook! 'org-agenda-mode-hook '(setq org-agenda-files (list "~/notes/org")))

(remove-hook! 'org-mode-hook 'org-superstar-mode)
(add-hook! 'org-mode-hook
	   :append
	   'visual-line-mode
	   'variable-pitch-mode
	   'org-indent-mode
	   'org-modern-mode
	   'org-modern-agenda
	   '+org-pretty-mode
	   '(setq
	     org-log-into-drawer t
	     org-log-done-with-time t
	     org-log-done 'time
	     org-log-refile 'time
	     org-log-repeat 'time
	     org-log-redeadline 'time
	     org-log-reschedule 'time
	     org-log-setup 'time
	     org-insert-heading-respect-content nil
	     org-startup-align-all-tables t
	     org-auto-align-tags nil
	     org-tags-column 0
	     org-fold-catch-invisible-edits 'show-and-error
	     org-hide-emphasis-markers t
	     org-pretty-entities t
	     org-startup-folded 'fold
	     org-tag-alist '(;; places
			     ("@home" . ?h)
			     ("@out" . ?o)

			     ;; devices
			     ("@computer" . ?c)
			     ("@iphone" . ?i)
			     ("@android" . ?a)
			     ("@tower" . ?t)
			     ("@keyboard" . ?k)

			     ;; activities/hobbies
			     ("#cleaning" . ?C) ;; probably recurrent?
			     ("#work" . ?w)
			     ("#programming" . ?p)
			     ("#music" . ?m)
			     ("#photography" . ?g))))

(add-hook! org-agenda-mode-hook :append
	   '(setq org-agenda-custom-commands
		  '(("d" "daily" ((agenda "" ((org-agenda-span 'day)
					      (org-deadline-warning-days 2)))))
		    ("u" "untagged tasks" tags-todo "-{.*=}" ((org-agenda-overriding-header "Untagged")))
		    ("k" "before leaving @home" tags-todo "+@out" ((org-agenda-overriding-header "checks for before leaving the house"))))))

;; ledger mode + (org-mode + org-bable)
(after! ledger :append
  (map! :map ledger-mode-map
	:localleader
	"o" #'org-babel-tangle-jump-to-org
	#'org-babel-detangle))

;; pretty org-mode overrides
(add-hook! 'org-agenda-mode-hook :append
	   '(setq org-agenda-tags-column 0 org-agenda-block-separator ?-))

;; org-modern-mode overrides
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
