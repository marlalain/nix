;;; shared/doom/keybinds.el -*- lexical-binding: t; -*-

(map! :n "\/" #'+default/search-buffer)

(add-hook!
 'dired-mode-hook
 (lambda ()
   (map! "RET" #'dired-goto-file)))

(map! :n "C-M-s-t" #'org-agenda)

(map! :n "s-g" #'avy-goto-char-timer)
