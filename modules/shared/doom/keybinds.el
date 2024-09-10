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

;; org-gtd
(map!
 :leader (:prefix ("d" . "org-gtd")
          :desc "capture" "c" #'org-gtd-capture
          :desc "engage" "e" #'org-gtd-engage
          :desc "process inbox" "p" #'org-gtd-processdesc "show all next" "n" #'org-gtd-show-all-next
          :desc "stuck projects" "s" #'org-gtd-review-area-of-focus
          :desc "area of focus" "a" #'org-gtd-area-of-focus-set-on-item-at-point
          :desc "organize item" "o" #'(lambda () (interactive) '(org-gtd-organize)) ;; why does it need this tho
          :desc "clarify item" "f" #'org-gtd-clarify-item
          ))

(map!
 :map org-gtd-clarify-map
 :localleader (:prefix ("d" . "org-gtd")
               :desc "area of focus" "a" #'org-gtd-area-of-focus-set-on-item-at-point :desc "clarify item" "f" #'org-gtd-clarify-item
               ))

;; avy
(map! :n "s-g" #'avy-goto-char-timer) ;; too hard to press with current delay configs, should be something else

(after! objed
  (global-set-key (kbd "<escape>") #'objed-activate)
  (evil-mode -1)
  )

(map! :map nov-mode-map
      :desc "next page" :n "RET" #'nov-scroll-up
      :desc "previous page" :n "TAB" #'nov-scroll-down)
