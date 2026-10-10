;;; init.el --- Init -*- lexical-binding: t; -*-

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)
(load-theme 'modus-vivendi)
(setq make-backup-files nil)
(setq backup-inhibited nil) ; Not sure if needed, given `make-backup-files'
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq backup-inhibited nil) ; Not sure if needed, given `make-backup-files'
(setq create-lockfiles nil)
(fido-vertical-mode 1)
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))


(require 'use-package)
(setq use-package-always-ensure t)
;;; Evil Mode - Vim keybindings

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC")

  (my/leader
    "x"   #'execute-extended-command
    "f f" #'find-file
    "b b" #'switch-to-buffer
    "r"   (lambda ()
            (interactive)
            (load user-init-file))))

(global-set-key (kbd "C-SPC") #'completion-at-point)
(use-package project
  :ensure nil
  :config
  (my/leader
    "p f" #'project-find-file
    "p s" #'project-switch-project
    "p b" #'project-switch-to-buffer
    "p g" #'project-find-regexp
    "p c" #'project-compile
    "p k" #'project-kill-buffers
    "p d" #'project-dired))
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install))
(use-package vc
  :ensure nil
  :config
  (my/leader
    "g s" #'vc-dir
    "g d" #'vc-diff
    "g l" #'vc-print-log
    "g a" #'vc-annotate
    "g c" #'vc-next-action))
(use-package eww
  :ensure nil
  :config
  (my/leader
    "w w" #'eww))
(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :config
  (setq python-indent-offset 4))
(use-package empv
  :ensure t
  :config
  (setq empv-audio-dir "~/Videot"
        empv-video-dir "~/Videot"
        empv-invidious-instance "https://invidious.f5.si/api/v1")
  (setq empv-mpv-args (remove "--no-video" empv-mpv-args)))
