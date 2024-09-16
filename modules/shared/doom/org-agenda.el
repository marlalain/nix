;;; shared/doom/org-agenda.el -*- lexical-binding: t; -*-

(use-package! org-agenda
  :config
  (setq org-agenda-use-tag-inheritance t
        org-agenda-show-future-repeats 'next
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-skip-timestamp-if-done t
        org-agenda-start-with-log-mode t
        org-agenda-include-diary t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-dim-blocked-tasks 'invisible ;; no need to see what I can't work on
        )
  ;; so there's no bright green line in the agenda
  (custom-set-faces '(org-agenda-done ((t (:inherit nil))))))

(use-package! org-super-agenda
  :after org-agenda
  :config
  (setq org-agenda-custom-commands
        '(("M" "medication logs"
           ((agenda ""
                    ((org-super-agenda-groups '(
                                                (:name "taken" :todo ( "TAKE" "NEXT" "TAKEN" "DONE")))))
                    ((setq org-agenda-span 'day
                           org-agenda-include-inactive-timestamps t
                           org-agenda-log-mode-add-notes t)))))))


  ;; (setq org-agenda-custom-commands
  ;;       '(("M" "Medications Agenda with Logs"
  ;;          ((agenda "" ((org-super-agenda-groups
  ;;                        '((:name "Medications to Take"
  ;;                           :todo ("TAKE" "NEXT")
  ;;                           :order 1)
  ;;                          (:name "Medications Taken"
  ;;                           :todo ("TAKEN")
  ;;                           :order 2)))))
  ;;           (alltodo "" ((org-super-agenda-groups
  ;;                         '((:auto-category t))))))
  ;;          ((org-agenda-include-inactive-timestamps t)
  ;;           (org-agenda-log-mode-items '(state note))
  ;;           (org-agenda-log-mode-add-notes t)))))

  (org-super-agenda-mode)

  )
