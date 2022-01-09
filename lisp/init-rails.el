;;; init-rails.el --- Ruby on Rails support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'projectile-rails)
  (add-hook 'projectile-mode-hook
            (lambda () (projectile-rails-global-mode projectile-mode)
              (define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map))))

(provide 'init-rails)
;;; init-rails.el ends here
