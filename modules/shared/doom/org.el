;;; $DOOMDIR/org.el -*- lexical-binding: t; -*-


(setq org-log-into-drawer t
      org-log-done-with-time t
      org-log-done 'time
      org-log-refile 'time
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time
      org-insert-heading-respect-content t
      org-use-property-inheritance t
      org-startup-align-all-tables t
      org-auto-align-tags t
      org-tags-column -150
      org-fold-catch-invisible-edits 'show-and-error
      org-hide-emphasis-markers t
      org-pretty-entities nil
      org-startup-folded 'content
      org-fontify-whole-heading-line nil
      org-hide-leading-stars t
      org-level-color-stars-only nil
      org-id-link-to-org-use-id t
      org-ellipsis " > "
      org-return-follows-link t
      org-id-link-to-org-use-id t
      org-id-locations-file "~/.config/emacs/.local/state/.org-id-locations"
      org-fast-tag-selection-single-key t

      org-priority-faces '((65 . "firebrick")
                           (66 . "gold")
                           (67 . "green yellow"))

      ;; org-todo-keywords '((sequence "TODO(t!)" "PAUSED(p!)" "|" )
      ;;                     (sequence "|" "DONE(d!)"  "NOPE(n!)" "SKIPPED(s!)")
      ;;                     (sequence "[ ](c!)" "[/](/!)" "[X](f!)")
      ;;                     (type "IDEA(I)" "GOAL(G)" "PROJECT(P)" "MILESTONE(M)"))
      ;; org-todo-keyword-faces '(
      ;;                          ("IDEA" . "gold")
      ;;                          ("GOAL" . "gold")
      ;;                          ("PROJECT" . "gold")
      ;;                          ("MILESTONE" . "gold")
      ;;                          ("TODO" . "dark orange")
      ;;                          ("PAUSED" . "royal blue")
      ;;                          ("DONE" . "green yellow")
      ;;                          ("SKIPPED" . "firebrick")
      ;;                          ("NOPE" . "firebrick")
      ;;)V

      org-tag-alist '(;; places
                      ("@body" . ?b) ;; mostly assumed: @home
		      ("@home" . ?h) ("@out" . ?o) ;; OR

		      ;; devices
		      ("@computer" . ?c) ;; assumed: @home
		      ("@tower" . ?t) ;; assumed: @computer @home
		      ("@keyboard" . ?k)
		      ("@iphone" . ?i)
		      ("@android" . ?a)

                      ;; categories/hobbies
                      ("@homelab" . ?l) ;; what relates to my config
                      ("@work" . ?w)
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

 '(org-tag ((t (
                :width condensed
                :weight bold
                :foreground "white"
                ))))
 '(org-todo ((t (:foreground "dark orange"))))
 '(org-done ((t (:foreground "green yellow"))))
 )

(add-hook! 'org-roam-mode-hook :append
           '(setq org-roam-dailies-directory "~/notes/org/roam/dailies/"
                  org-roam-directory "~/notes/org/roam/"))


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
(setq org-superstar-mode nil)

;;; ---> FORMAT
(defun +org-align-tags-onsave ()
  "Align tags on save"
  (when (eq major-mode 'org-mode)
    (org-align-tags t)))
(add-hook! 'before-save-hook #'+org-align-tags-onsave)
