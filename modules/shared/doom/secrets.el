;;; shared/doom/secrets.el -*- lexical-binding: t; -*-

(defvar my/secrets-dir "~/src/marlalain/nix-secrets/"
  "where my secrets from `marlalain/nix` are stored")

(defun my/read-secret (filename)
  "read a secret by its filename"
  (let ((file (expand-file-name filename my/secrets-dir)))
    (if (file-exists-p file)
        (with-temp-buffer (insert-file-contents file)
                          (string-trim (buffer-string)))
      (error "secret file %s does not exist" file))))
