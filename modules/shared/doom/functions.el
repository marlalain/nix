;;; shared/doom/functions.el -*- lexical-binding: t; -*-

(defun my/keybind-switch
    () (interactive)
    (defun my/objed-switch () (interactive)
           (evil-mode -1)
           (objed-mode 1)
           (objed-activate))
    (defun my/evil-switch () (interactive)
           (evil-mode 1)
           (objed-mode -1))
    (cond
     (objed-mode (my/evil-switch))
     (evil-mode (my/objed-switch))
     (t (message "impossible state"))))
