;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(menu-bar-mode 1)

(setq doom-modeline-time-live-icon t)
(setq doom-modeline-time-analogue-clock t)

(load! "secrets")

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "how you do anything is how you do everything")))

(defun my-weebery-is-always-greater ()
  (let* ((banner '(
                   "                                     +-------+                                  "
                   "                                     |'STUFF'|                                  "
                   "                                     +---+---+                                  "
                   "                                         |                                      "
                   "                                     +---v---+                                  "
                   "                                     | INBOX |                                  "
                   "                                     +---+---+                                  "
                   "                                         |              Eliminate  +-----------+"
                   "                                         |            +----------->|  Trash    |"
                   "                                  +------v------+     |            +-----------+"
                   "                                  | What is it? |     |                         "
                   "                                  +------+------+     |            +-----------+"
                   "                                         |            | Incubate   |  Someday/ |"
                   "                                         |            +----------->|   Maybe   |"
                   "+----------+  YES (multi-step)   +------v------+  NO |            +-----------+ "
                   "| Projects |<--------------------|    Is it    |-----+                          "
                   "+------^---+                     | Actionable? |     | File       +-----------+ "
                   "   |    |   +----------------+    +------+------+     +----------->| Reference |"
                   "   |    |        Review for  |           |                         +-----------+"
                   "+-v----+---+     Actions    |           |                                       "
                   "| Planning |                +---------->| YES                                   "
                   "+----------+                            |                                       "
                   "                                  +------v------+     Less than                 "
                   "                        Delegate  | What's the  |     2 minutes    +-----------+"
                   "                      +-----------+    NEXT     +----------------->|   DO IT   |"
                   "                      |           |   Action?   |                  +-----------+"
                   "                      |           +------+------+                               "
                   "                      |                  |                                      "
                   "                      |                  | FOR ME:                              "
                   "                      |                  |         Specific Date or Time        "
                   "                      |                  +-------------------------------+      "
                   "                      |              ASAP|                               |      "
                   "                +-----v-----+      +-----v-----+                   +-----v-----+"
                   "                |           |      |           |                   |           |"
                   "                |           |      |           |                   |           |"
                   "                |           |      |           |                   |           |"
                   "                |           |      |           |                   |           |"
                   "                |           |      |           |                   |           |"
                   "                +-----------+      +-----------+                   +-----------+"
                   "                 Waiting For        Next Actions                      Calendar  "
                   ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

;; sane line highlights
(custom-set-faces
 '(hl-line ((t (:underline nil :bold t))))
 '(line-number ((t (:background "unspecified" :underline nil))))
 '(line-number-current-line ((t (:background "unspecified" :underline nil :bold t))))
 )

(setq-default tab-width 2
              indent-tabs-mode nil
              avy-all-windows t)

;; TODO: Add Inconsolata
(setq doom-font (font-spec :family "Departure Mono" :size 18 :weight 'semi-light)
      doom-symbol (font-spec :family "Departure Mono" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Departure Mono" :size 16 :weight 'semi-light)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18)
      doom-localleader-key "," ;; instead of `SPC m`
      doom-theme 'doom-meltbus ;; or doom-opera wombat
      doom-themes-enable-italic nil
      doom-themes-enable-italic nil ;; it's code not prose
      doom-modeline-hud t
      doom-user-dir  "~/.config/nix/modules/shared/doom/"
      org-directory "~/notes/org/"
      indent-line-function 'insert-tab
      user-full-name "Marla Albuquerque"
      user-mail-address "marla@albuque.com")

(after! doom-modeline
  (setq doom-modeline-icon nil)) ;; disables modeline icons

;; removes dashbord fluff
(remove-hook '+doom-dashboard-functions 'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions 'doom-dashboard-widget-footer)

;; childframe
(after! posframe
  (setq vertico-posframe-border-width 0
	vertico-posframe-parameters '((left-fringe . 0)
				      (right-fringe . 0)
				      (internal-border-width . 0)
				      (alpha . 95)))
  (set-frame-parameter nil 'alpha-background 95))

;; async + idle + parallel package loading
(use-package! async
  :config (async-bytecomp-package-mode 1))

(add-hook! 'elcord-mode-hook '(setq elcord-editor-icon "doom_cute_icon"))
(map! :leader
      :desc "Elcord (DRP)"
      :n "t e" #'elcord-mode)

;; ui stuff (move to ./ui.el maybe?)
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(custom-set-faces
 '(show-paren-match ((t (:background "cyan" :foreground "black" :weight bold))))
 '(show-paren-mismatch ((t (:background "red" :foreground "white" :weight bold))))
 )

;; wakatime
;;(use-package! wakatime-mode
;;  :config
;;  (setq wakatime-api-key (my/read-secret "wakatime"))
;;  (global-wakatime-mode))

(load! "org-agenda")
(load! "keybinds")

(use-package! org
  :config
  (load! "org"))

(use-package! org-gtd
  :after org
  :demand t
  :custom
  (org-gtd-directory "~/notes/org/gtd")
  (org-edna-use-inheritance t)
  :config
  (setq org-gtd-areas-of-focus '("work" "homelab" "coding" "music" "photography" "relations" "health" "paperwork"))
  (org-edna-mode))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(use-package! nov
  :config
  '(visual-line-mode)
  )
