;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; sane line highlights
(custom-set-faces
 '(hl-line ((t (:underline nil :bold t))))
 '(line-number ((t (:background "unspecified" :underline nil))))
 '(line-number-current-line ((t (:background "unspecified" :underline nil :bold t)))))

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default avy-all-windows t)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they accept.
;; TODO: Add Inconsolata
(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 18)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18)
      doom-localleader-key "," ;; instead of `SPC m`
      doom-theme 'doom-meltbus ;; or doom-opera wombat
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

(add-to-list 'initial-frame-alist '(width . 150))
(add-to-list 'initial-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 150))
(add-to-list 'default-frame-alist '(height . 50))

;; async + idle + parallel package loading
(use-package! async
  :config (async-bytecomp-package-mode 1))

(add-hook! 'elcord-mode-hook '(setq elcord-editor-icon "doom_cute_icon"))
(map! :leader
      :desc "Elcord (DRP)"
      :n "t e" #'elcord-mode)

;;; after everything else, load a few heavy modes
(add-hook! 'doom-after-init-hook :append
  (async-start '(elcord-mode))
  (async-start '(org-mode))
  (async-start '(org-agenda-mode))
  (async-start '(org-capture-mode)))
