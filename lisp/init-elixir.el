;;; init-elixir.el --- Support for the Elixir language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'elixir)
  (require 'elixir-start))

(require 'eglot)
(add-to-list 'eglot-server-programs '(elixir-mode "/Users/phil/Dev/tools/elixir-ls/release/language_server.sh"))

(require 'elixir-mode)
(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-format-hook (lambda ()
                                (if (projectile-project-p)
                                    (setq elixir-format-arguments
                                          (list "--dot-formatter"
                                                (concat (locate-dominating-file buffer-file-name ".formatter.exs")
                                                        ".formatter.exs")))
                                  (setq elixir-format-arguments nil))))

;(require 'ligature)

(provide 'init-elixir)
;;; init-elixir.el ends here
