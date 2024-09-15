;;; shared/doom/irl.el -*- lexical-binding: t; -*-

(after! erc
  (setq erc-server "localhost"
        erc-port 6667
        erc-nick "emacsu"
        erc-user-full-name "emacsu"

        ;; erc-server-connect-function 'erc-open-ssl-stream
        ;; erc-server-use-tls t
        ;; erc-tls-port 6697
        ;; erc-tls-program "gnutls-cli --insecure -p %p %h"

        erc-log-channels-directory "/home/marla/.config/emacs/.local/etc/erc/logs/"
        erc-save-buffer-on-part t
        erc-hide-timestamps nil
        erc-fill-column 75

        erc-autojoin-mode nil ;; for now
        erc-track-shorten-start 8
        erc-kill-buffer-on-part t
        )

  (erc-services-mode 1)
  (erc-match-mode 1)
  (erc-ring-mode 1)
  (erc-track-mode 1)
  (erc-fill-mode 1)
  (erc-autojoin-mode 0)
  (erc-log-mode 1)
  (erc-notifications-mode 1)
  )
