;;; init-themes.el --- Defaults for themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (require-package 'color-theme-sanityinc-solarized)
;; (require-package 'color-theme-sanityinc-tomorrow)

;; (load-theme 'wombat)
;; (use-package modus-themes
;;   :init (load-theme 'modus-vivendi t))
;; (use-package vs-dark-theme
;; :init (load-theme 'vs-dark t))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-dark+ t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

;; Don't prompt to confirm theme safety. This avoids problems with
;; first-time startup on Emacs > 26.3.
(setq custom-safe-themes t)

;; If you don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(doom-dark+))

;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)



;; Toggle between light and dark

(defun light ()
  "Activate a light color theme."
  (interactive)
  (setq custom-enabled-themes '(doom-tomorrow-day))
  (reapply-themes))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (setq custom-enabled-themes '(doom-dark+))
  (reapply-themes))


(when (maybe-require-package 'dimmer)
  (setq-default dimmer-fraction 0.15)
  (add-hook 'after-init-hook 'dimmer-mode)
  (with-eval-after-load 'dimmer
    ;; TODO: file upstream as a PR
    (advice-add 'frame-set-background-mode :after (lambda (&rest args) (dimmer-process-all))))
  (with-eval-after-load 'dimmer
    ;; Don't dim in terminal windows. Even with 256 colours it can
    ;; lead to poor contrast.  Better would be to vary dimmer-fraction
    ;; according to frame type.
    (defun sanityinc/display-non-graphic-p ()
      (not (display-graphic-p)))
    (add-to-list 'dimmer-exclusion-predicates 'sanityinc/display-non-graphic-p)))


(provide 'init-themes)
;;; init-themes.el ends here
