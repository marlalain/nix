;;; shared/doom/keybinds.el -*- lexical-binding: t; -*-

;; TODO add objed and creat switches for evil <-> objed

(map! :i "RET" #'+default/newline)
(map! :n "\/" #'+default/search-buffer)

;; dired
(map! :map dired-mode-map "RET" #'dired-goto-file)

;; org-gtd
(map! :leader (:prefix ("d" . "org-gtd")
               :desc "capture" "c" #'org-gtd-capture
               :desc "engage" "e" #'org-gtd-engage
               :desc "engage" "E" #'org-gtd-engage-grouped-by-context
               :desc "process inbox" "p" #'org-gtd-process-inbox
               :desc "show all next" "n" #'org-gtd-show-all-next
               :desc "stuck projects" "s" #'org-gtd-review-area-of-focus
               :desc "area of focus" "a" #'org-gtd-area-of-focus-set-on-item-at-point
               :desc "organize item" "o" #'(lambda () (interactive) '(org-gtd-organize)) ;; why does it need this tho
               :desc "clarify item" "f" #'org-gtd-clarify-item
               ))
                                        ; clarify mappings
(map! :map org-mode-map :localleader "d" nil) ;; overrides initial state
(map! :map org-gtd-clarify-map :localleader "d" nil) ;; overrides initial state
(map! :map org-mode-map
      :localleader (:prefix ("d" . "org-gtd")
                    :desc "area of focus" "a" #'org-gtd-area-of-focus-set-on-item-at-point
                    :desc "clarify item" "f" #'org-gtd-clarify-item
                    :desc "organize item" "o" #'org-gtd-organize
                    ))
                                        ; org-agenda mappings
(map! :map org-agenda-mode-map :localleader "d" nil) ;; overrides initial state
(map! :map 'org-agenda-mode-map
      :localleader (:prefix ("d" . "org-gtd")
                    :desc "delegate" "d" #'org-gtd-delegate-agenda-item
                    :desc "area of focus" "a" #'org-gtd-area-of-focus-set-on-agenda-item
                    :desc "clarify item" "f" #'org-gtd-clarify-agenda-item
                    :desc "cancel parent project" "C" #'org-gtd-project-cancel-from-agenda
                    ))

;; avy
(map! :n "s-g" #'avy-goto-char-timer) ;; too hard to press with current delay configs, should be something else

(map! :map nov-mode-map
      :desc "next page" :n "RET" #'nov-scroll-up
      :desc "previous page" :n "TAB" #'nov-scroll-down)
