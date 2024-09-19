;;; shared/doom/lispy.el -*- lexical-binding: t; -*-

(lispyville-enter-special-when-marking)

(transient-define-prefix my/lispy ()
  "quick actions for lispy/lispyville"
  [["motion"
    ("l" "left" lispyville-right :transient t)
    ("h" "right" lispyville-left :transient t)
    ("k" "up" lispy-up :transient t)
    ("j" "down" lispy-down :transient t)]
   ["move/drag"
    ("L" "left" lispy-move-up :transient t)
    ("H" "right" lispy-move-up :transient t)
    ("K" "up" lispy-move-up :transient t)
    ("J" "down" lispy-move-down :transient t)]
   ["transpose"
    ("t" "forward" transpose-sexps :transient t)
    ("T" "backward" my/transpose-sexp-backward :transient t)]
   ["special"
    ("u" "undo" evil-undo :transient t)
    ("O" "objed" my/keybind-switch)
    ("q" "quit" transient-quit-all)]
   ["raise"
    ("r" "sexp" lispy-raise-sexp :transient t)
    ("R" "list" lispyville-raise-list :transient t)]]
  [["wrap"
    ("wr" "round" lispy-wrap-round :transient t)
    ("wb" "brackets" lispy-wrap-brackets :transient t)
    ("wB" "braces" lispy-wrap-braces :transient t)]
   ["insert"
    ("b" "beginning" lispyville-insert-at-beginning-of-list)
    ("e" "end" lispyville-insert-at-end-of-list)
    ""
    "open"
    ("ok" "above" lispyville-open-above-list)
    ("ob" "below" lispyville-open-below-list)]
   ["inner"
    ("ia" "atom" lispyville-inner-atom :transient t)
    ("il" "list" lispyville-inner-list :transient t)
    ("ie" "sexp" lispyville-inner-sexp :transient t)
    ("if" "function" lispyville-inner-function :transient t)
    ("ic" "comment" lispyville-inner-comment :transient t)
    ("is" "string" lispyville-inner-string :transient t)]
   ["barf"
    ("<" "backward" lispy-backward-barf-sexp :transient t)
    ("," "forward" lispy-forward-barf-sexp :transient t)
    ""
    "slurp"
    (">" "forward" lispy-forward-slurp-sexp :transient t)
    ("." "backward" lispy-backward-slurp-sexp :transient t)]
   ["additional"
    ("c" "clone" lispy-clone :transient t)
    ("C" "convolute" lispy-convolute-sexp :transient t)
    ("n" "join" lispy-join :transient t)
    ("s" "splice" lispy-splice :transient t)
    ("S" "split" lispy-split :transient t)]])


(map! :map lispy-mode-map
      :n "f" 'my/lispy
      :n "m" #'lispy-mark)
