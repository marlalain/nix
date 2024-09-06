;;; $DOOMDIR/org.el -*- lexical-binding: t; -*-

(setq org-log-into-drawer t
      org-log-done-with-time t
      org-log-done 'time
      org-log-refile 'time
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time
      org-log-setup 'time
      org-insert-heading-respect-content t
      org-startup-align-all-tables t
      org-auto-align-tags t
      org-tags-column -140
      org-fold-catch-invisible-edits 'show-and-error
      org-hide-emphasis-markers t
      org-pretty-entities nil
      org-startup-folded 'fold
      org-fontify-whole-heading-line nil
      org-hide-leading-stars t
      org-level-color-stars-only nil
      org-id-link-to-org-use-id t
      org-ellipsis "..."

      org-priority-faces '((65 . "firebrick")
                           (66 . "gold")
                           (67 . "green yellow"))

      org-todo-keywords '((sequence "IDEA(i)" "TODO(t)" "PAUSED(p)" )
                          (sequence "|" "CANCELLED(c)" "DONE(d)" "SKIPPED(s)")
                          (type "WORK(w)"))
      org-todo-keyword-faces '(
                               ("IDEA" . "gold")
                               ("TODO" . "dark orange")
                               ("PAUSED" . "royal blue")
                               ("DONE" . "green yellow")
                               ("SKIPPED" . "firebrick")
                               ("CANCELLED" . "firebrick")
                               )

      ;; FIXME not loading during start phase
      org-tag-alist '(;; places
                      ("@body" . ?b) ;; mostly assumed: @home
		      ("@home" . ?h) ("@out" . ?o) ;; OR

		      ;; devices
		      ("@computer" . ?c) ;; assumed: @home
		      ("@tower" . ?t) ;; assumed: @computer @home
		      ("@keyboard" . ?k)
		      ("@iphone" . ?i)
		      ("@android" . ?a)
                      ))


(custom-set-faces
 '(org-level-1 ((t (:weight bold :height 1.0))))
 '(org-level-2 ((t (:weight bold :height 1.0))))
 '(org-level-3 ((t (:weight bold :height 1.0))))
 '(org-level-4 ((t (:weight bold :height 1.0))))
 '(org-level-5 ((t (:weight bold :height 1.0))))
 '(org-level-6 ((t (:weight bold :height 1.0))))
 '(org-level-7 ((t (:weight bold :height 1.0))))
 '(org-level-8 ((t (:weight bold :height 1.0))))

 '(org-todo ((t (
                 ;; :background "black" :box '(:color "black" :line-width '(-3 . -3))
                 :foreground "dark orange"
                 :width condensed
                 :inverse-video nil ;; t
                 :box nil
                 ))))
 )

(add-hook! 'org-roam-mode-hook :append
	   '(setq org-roam-dailies-directory "~/notes/org/roam/dailies/"
		  org-roam-directory "~/notes/org/roam/"))

(add-hook! 'org-agenda-mode-hook :append
           '(setq org-agenda-files (list "~/notes/org")))

;; pretty org-mode overrides
(add-hook! 'org-agenda-mode-hook :append
	   '(org-agenda-block-separator ?-)
	   '(setq org-agenda-custom-commands ;; FIXME not loading with emacs
		  '(("d" "daily"
                     ((agenda "" ((org-agenda-span 'day)
                                  (org-agenda-day-view)
                                  (org-agenda-start-day "today")
				  (org-deadline-warning-days 2)))))
		    ("u" "untagged tasks" tags-todo "-{.*=}"
                     ((org-agenda-overriding-header "Untagged")))
		    ("k" "before leaving @home" tags-todo "+@out"
                     ((org-agenda-overriding-header "checks for before leaving the house")))
                    ("w" "work related"
                     ((tags-todo "+#work"
                                 ((org-agenda-overriding-header "today")
                                  (org-agenda-skip-function
                                   '(or
                                     (org-agenda-skip-entry-if 'scheduled 'not-today)
                                     (org-entry-blocked-p))))))
                     )))
           )

(after! ledger :append
  (map! :map ledger-mode-map
	:localleader
	"o" #'org-babel-tangle-jump-to-org
	#'org-babel-detangle))


;; org-modern-mode overrides
(after! org-modern-mode
  (setq org-modern-checkbox nil
	org-modern-hide-stars nil
	org-modern-list nil
	org-modern-star nil
	org-modern-fold-stars nil
        org-modern-checkbox nil
        org-modern-priority nil
	org-modern-replace-stars nil)
  (custom-set-faces
   '(org-modern-label ((t (
                           :foreground "white"
                           :inherit default
			   :weight bold
			   :box (:line-width (0 . 0))))))
   '(org-todo ((t (
                   :foreground "yellow"
                   )))))
  )

(visual-line-mode)
;; '+org-pretty-mode

;;; ---> FORMAT
(defun +org-align-tags-onsave ()
  "Align tags on save"
  (when (eq major-mode 'org-mode)
    (org-align-tags t)))
(add-hook 'before-save-hook #'+org-align-tags-onsave)
