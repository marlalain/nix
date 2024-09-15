;;; shared/doom/ui/modeline.el -*- lexical-binding: t; -*-

(defun my/org-agenda-current-task ()
  "formats a string with the current task from org-agenda"
  (when (and (derived-mode-p 'org-agenda-mode)
             (org-agenda-get-selected-entry))
    (let ((task (org-get-heading t t t t)))
      (format "%s" task))))

(defun setup-custom-doom-modeline ()
  "Set up the Doom modeline to include the current Org Agenda task."
  (if (derived-mode-p 'org-agenda-mode)
      (my/org-agenda-current-task)
    "")
  (doom-modeline-def-modeline 'my-org-agenda-modeline
    '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info persp-name lsp my-org-agenda-task buffer-encoding major-mode vcs process))
  (doom-modeline-set-modeline 'my-org-agenda-modeline 'default))

(add-hook 'doom-modeline-mode-hook #'setup-custom-doom-modeline)
