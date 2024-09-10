;;; shared/doom/org-agenda.el -*- lexical-binding: t; -*-

(use-package! org-agenda
  :config
  (setq org-agenda-use-tag-inheritance t
        org-agenda-show-future-repeats 'next
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-timestamp-if-done t
        org-agenda-start-with-log-mode t
        org-agenda-block-separator " "
        org-agenda-compact-blocks t
        ))

(use-package! org-super-agenda
  :after org-agenda
  :config
  (setq org-agenda-custom-commands
        '(
          ("t" "today"
           ((agenda ""
                    ((org-agenda-overriding-header "today")
                     (org-agenda-span 'day)
                     (setq org-super-agenda-groups
                           '((:name "today"
                              :time-grid t
                              :date today
                              :scheduled today
                              :deadline today
                              :order 1)))))))
          ("u" "untagged"
           ((tags-todo "ALLTAGS=\"\""
                       ((setq org-super-agenda-groups
                              '((:name "untagged TODO items")))))))
          ))
  (org-super-agenda-mode))
