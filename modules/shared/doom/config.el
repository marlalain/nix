;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-user-dir "~/.config/nix/modules/shared/doom/"
      org-directory "~/notes/org/")

(setq display-line-numbers "relative"
      doom-modeline-hud t)

(setq user-full-name "Marla Albuquerque"
      user-mail-address "marla@albuque.com")

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
      doom-localleader-key ","
      doom-theme 'doom-sourcerer)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! doom-modeline
  (setq doom-modeline-icon nil)) ;; disables modeline icons

;; removes dashbord fluff
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

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

(setq-default indent-tabs-mode t
	      tab-width 2)
(setq indent-line-function 'insert-tab)

;; async + idle + parallel package loading
(use-package! async
  :config (async-bytecomp-package-mode 1))

(add-hook! 'emacs-startup-hook
  (lambda ()
    (run-with-idle-timer 1 nil #'elcord-mode)
    (run-with-idle-timer 2 nil #'org-mode)))

(after! elcord-mode
  (setq elcord-editor-icon "doom_cute_icon")
  (map! :leader
	:desc "Elcord (DRP)"
	:n "t e" #'elcord-mode))
