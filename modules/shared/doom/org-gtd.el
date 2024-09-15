;;; shared/doom/org-gtd.el -*- lexical-binding: t; -*-

(defun my/append-path (path directory)
  "Append PATH to DIRECTORY"
  (expand-file-name path (expand-file-name directory)))

(defun my/org-relative-path (path)
  "Return absolute path based on PATH and ORG-DIRECTORY"
  (my/append-path path org-directory)
  )

(setq org-gtd-work-inbox-path (my/org-relative-path "gtd/work.org"))

(setq
 org-gtd-canceled "NOPE"
 org-reverse-note-order t


 org-gtd-capture-templates
 '(
   ("i" "Inbox" entry (file org-gtd-inbox-path) "* %?\n%U\n\n %i" :kill-buffer t)
   ("w" "Work Inbox" entry (file org-gtd-work-inbox-path) "* %?\n%U\n\n %i" :kill-buffer t)
   ))

(add-hook! org-gtd-organize-hooks
           :append (org-set-effort))
