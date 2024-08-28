;;; shared/doom/org.el -*- lexical-binding: t; -*-

;; org-log
(setq org-log-into-drawer t
      org-log-done-with-time t
      org-log-done 'time
      org-log-refile 'time
      org-log-repeat 'time
      org-log-redeadline 'time
      org-log-reschedule 'time)

(add-hook 'org-mode-hook 'org-indent-mode)

;; org-mode + ledger-mode
(after! ledger-mode
  (map! :map ledger-mode-map
	:localleader "o"
	#'org-babel-tangle-jump-to-org)
  (map! :map ledger-mode-map
	:localleader "u"
	#'org-babel-detangle))

;; capture everywhere
(defun abs--quick-capture ()
  ;; redefine the function that splits the frame upon org-capture
  (defun abs--org-capture-place-template-dont-delete-windows (oldfun args)
    (cl-letf (((symbol-function 'org-switch-to-buffer-other-window) 'switch-to-buffer))
      (apply oldfun args)))

  ;; run-once hook to close window after capture
  (defun abs--delete-frame-after-capture ()
    (delete-frame)
    (remove-hook 'org-capture-after-finalize-hook 'abs--delete-frame-after-capture)
    )

  ;; set frame title
  (set-frame-name "emacs org capture")
  (add-hook 'org-capture-after-finalize-hook 'abs--delete-frame-after-capture)
  (abs--org-capture-place-template-dont-delete-windows 'org-capture nil))
