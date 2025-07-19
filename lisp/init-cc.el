;;; init-cc.el --- Support for C and C++ -*- lexical-binding: t -*-

(add-hook 'c-mode-hook #'(setq c-default-style 'k&r))
(add-hook 'c++-mode-hook #'(setq c-default-style 'stroustrup))

(add-hook 'c-common-mode-hook '(c-electric-pound-behavior '(alignleft)))
