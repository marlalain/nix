;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(evil-mode 1)
(menu-bar-mode 0) ;; FIXME doesn't let yabai tile emacs still
(display-time-mode 1)

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "how you do anything is how you do everything")))

;; TODO extract
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

(setq doom-theme 'doom-one)

;; TODO extract
;; sane line highlights
(custom-set-faces
 '(hl-line ((t (:underline nil :bold t))))
 '(line-number ((t (:background "unspecified" :underline nil))))
 '(line-number-current-line ((t (:background "unspecified" :underline nil :bold t))))
 )

(setq-default tab-width 2
              indent-tabs-mode nil
              avy-all-windows t)

(setq doom-font (font-spec :family "Inconsolata" :size 22)
      doom-variable-pitch-font (font-spec :family "Inconsolata" :size 22 :weight 'semi-light)
      doom-big-font (font-spec :family "Inconsolata" :size 26)
      doom-localleader-key "," ;; instead of `SPC m`
      doom-theme 'doom-meltbus ;; or doom-opera wombat
      doom-themes-enable-bold t
      doom-themes-enable-italic nil ;; it's code not prose
      doom-modeline-hud nil
      doom-modeline-time-analogue-clock nil
      doom-modeline-workspace-name nil
      doom-modeline-current-window t
      doom-modeline-position-line-format nil
      doom-modeline-position-column-format nil
      doom-modeline-position-column-line-format nil
      doom-modeline-total-line-number nil
      doom-modeline-buffer-encoding nil
      doom-user-dir  "/home/marla/.config/doom/"
      org-directory "~/notes/org/"
      user-full-name "Marla Albuquerque"
      user-mail-address "marla@albuque.com"
      tab-width 2
      indent-tabs-mode nil
      indent-line-function 'insert-tab
      )

(add-hook! 'doom-init-ui-hook
  (setq doom-symbol (font-spec :family "Inconsolata" :size 22))) ;; so it doesn't get overwritten

(after! doom-modeline
  (setq doom-modeline-icon nil)) ;; disables modeline icons

;; TODO extract
;; removes dashbord fluff
(remove-hook '+doom-dashboard-functions 'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions 'doom-dashboard-widget-footer)

;; TODO extract
;; childframe
(after! posframe
  (setq vertico-posframe-border-width 0
	vertico-posframe-parameters '((left-fringe . 0)
				      (right-fringe . 0)
				      (internal-border-width . 0)
				      (alpha . 95)))
  (set-frame-parameter nil 'alpha-background 95))

;; TODO extract
;; async + idle + parallel package loading
(use-package! async
  :config (async-bytecomp-package-mode 1))

;; TODO extract
(add-hook! 'elcord-mode-hook '(setq elcord-editor-icon "doom_cute_icon"))
(map! :leader
      :desc "Elcord (DRP)"
      :n "t e" #'elcord-mode)

;; TODO extract
;; ui stuff (move to ./ui.el maybe?)
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(custom-set-faces
 '(show-paren-match ((t (:background "cyan" :foreground "black" :weight bold))))
 '(show-paren-mismatch ((t (:background "red" :foreground "white" :weight bold))))
 )

;; FIXME ?
;; wakatime
;;(use-package! wakatime-mode
;;  :config
;;  (setq wakatime-api-key (my/read-secret "wakatime"))
;;  (global-wakatime-mode))

(load! "secrets")
(load! "org-agenda")
(load! "keybinds")

;; TODO extract
(use-package! org
  :config
  (load! "org"))

;; TODO extract
(use-package! org-gtd
  :after org
  :demand t
  :custom
  (org-gtd-directory "~/notes/org/gtd")
  (org-edna-use-inheritance t)
  :config
  (load! "org-gtd")
  (setq org-gtd-areas-of-focus '("work" "homelab" "coding" "music" "photography" "relations" "health" "paperwork"))
  (org-edna-mode))

;; TODO extract
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(use-package! nov
  :config
  '(visual-line-mode)
  )

;; server stuff
(use-package! server
  :config

  (setq server-name "tower")
  (setq server-socket-dir "/home/marla/.config/emacs/server/")

  (unless (server-running-p) (server-start))
  )

(doom/reload-theme)

(use-package! tramp
  :defer t
  :config
  (setq tramp-default-method "ssh"
        tramp-persistency-file-name (expand-file-name "/home/marla/.config/emacs")
        tramp-inline-compress-start-size 1000
        tramp-auto-save-directory (expand-file-name "/home/marla/.config/emacs/tramp-autosave")
        ))


(use-package! org-depend
  :after org
  :config
  (setq org-enforce-todo-dependencies t))

(after! hl-todo
  (setq hl-todo-keyword-faces '(
                                '("BUG" error bold)
                                '("FIXME" error bold)
                                ;; ADD THE REST
                                )))

(load! "irc")
(use-package! org-journal
  :after org
  :config
  (setq org-journal-enable-agenda-integration t))

;; (setq exec-path (append exec-path '("/nix/store/dddrswg50rk1l75s2c93g82zh580zzzs-leiningen-2.10.0/bin")))
