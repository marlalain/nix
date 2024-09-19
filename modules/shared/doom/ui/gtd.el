;;; shared/doom/ui/gtd.el -*- lexical-binding: t; -*-

;; NOTE add keybindings to transient or hydra, if possible

(transient-define-suffix my/transient/engage ()
  "binds for engaging (org-agenda)"
  :key "e"
  :description "engage"
  (interactive)
  (org-gtd-engage))

;; TODO
;; (transient-define-prefix my/transient/capture ()
;;   "binds for capturing"
;;   ["org-gtd capture"
;;    ("i" "inbox"
;;     with-org-gtd-capture
;;     entry (file org-gtd-inbox-path) "* %?\n%U\n\n %i" :kill-buffer t)])

(transient-define-prefix my/transient-org-gtd ()
  "bindings for the org-gtd workflow"
  ["org-gtd"
   (my/transient/engage)
   ("E" "engage by context" org-gtd-engage)
   ;; ("c" "capture" my/transient/capture :transient t)
   ("q" "quit" transient-quit-one)])
