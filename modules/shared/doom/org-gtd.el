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

(defun my/org-update-todo-on-deadline-day ()
  "Set TODO items to NEXT on the day of their deadline."
  (interactive)
  (let ((today (time-to-days (current-time))))
    (dolist (file (org-agenda-files))
      (with-current-buffer (find-file-noselect file)
        (org-with-wide-buffer
         (org-map-entries
          (lambda ()
            (let* ((deadline (org-entry-get nil "DEADLINE"))
                   (scheduled (org-entry-get nil "SCHEDULED"))
                   (state (org-get-todo-state))
                   (deadline-days (when deadline (time-to-days (org-time-string-to-time deadline))))
                   (scheduled-days (when scheduled (time-to-days (org-time-string-to-time scheduled)))))
              (when (and (not (member state '("NEXT")))
                         (or (and deadline-days (<= deadline-days today))
                             (and scheduled-days (<= scheduled-days today))))
                (org-todo "NEXT"))))
          nil 'file))))))


(run-at-time "12:00am" (* 24 60 60) 'my/org-update-todo-on-deadline-day)
(my/org-update-todo-on-deadline-day)
