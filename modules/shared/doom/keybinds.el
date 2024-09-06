;;; shared/doom/keybinds.el -*- lexical-binding: t; -*-

(map! :i "RET" #'+default/newline)
(map! :n "\/" #'+default/search-buffer)

;; dired
(map! :map dired-mode-map "RET" #'dired-goto-file)

;; org
(map! :n "C-M-s-t" #'org-agenda) ;; not that useful
(map! :map org-mode-map
      :desc "Align tags"
      :localleader "Q"
      #'(lambda () (interactive) (org-align-tags t)))

;; avy
(map! :n "s-g" #'avy-goto-char-timer)

