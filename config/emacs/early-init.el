;;; early-init.el --- Early Init -*- lexical-binding: t; -*-
(setq default-frame-alist
      '((background-color . "#000000")
        (foreground-color . "#ffffff")))
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq display-line-numbers-type 'relative)

(global-display-line-numbers-mode +1)
(let ((mono-spaced-font "Monospace")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 100)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize 'force
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box t ; only for mouse events, which I seldom use
      use-file-dialog nil
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name ; read the docstring
      inhibit-startup-buffer-menu t)
(setq package-enable-at-startup t)

(add-hook 'after-init-hook (lambda () (set-frame-name "home")))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

