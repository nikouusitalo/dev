;;; init.el --- Init -*- lexical-binding: t; -*-
(global-completion-preview-mode -1)
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; Finnish dates and 24-hour time, independent of the desktop language.
(setq system-time-locale "fi_FI.utf8")
(setenv "LC_TIME" "fi_FI.utf8")

(require 'calendar)
(calendar-set-date-style 'european)
(setq calendar-week-start-day 1
      calendar-day-name-array
      ["sunnuntai" "maanantai" "tiistai" "keskiviikko"
       "torstai" "perjantai" "lauantai"]
      calendar-day-abbrev-array ["su" "ma" "ti" "ke" "to" "pe" "la"]
      calendar-day-header-array ["su" "ma" "ti" "ke" "to" "pe" "la"]
      calendar-month-name-array
      ["tammikuu" "helmikuu" "maaliskuu" "huhtikuu" "toukokuu" "kesäkuu"
       "heinäkuu" "elokuu" "syyskuu" "lokakuu" "marraskuu" "joulukuu"]
      calendar-month-abbrev-array
      ["tammi" "helmi" "maalis" "huhti" "touko" "kesä"
       "heinä" "elo" "syys" "loka" "marras" "joulu"]
      calendar-date-display-form
      '((if dayname (concat dayname " ")) day "." month "." year)
      calendar-time-display-form
      '(24-hours ":" minutes))

(setq display-time-24hr-format t
      display-time-format "%a %-d.%-m.%Y %H:%M")
(display-time-mode 1)

(with-eval-after-load 'org
  ;; Keep ISO timestamps on disk; localize only their visible representation.
  ;; This option is buffer-local, so set its default for every Org buffer.
  (setq-default org-display-custom-times t)
  (setq org-timestamp-custom-formats
        '("%a %-d.%-m.%Y" . "%a %-d.%-m.%Y %H:%M")))

(with-eval-after-load 'org-agenda
  (setq org-agenda-start-on-weekday 1
        org-agenda-format-date "%A %-d.%-m.%Y"
        org-agenda-timegrid-use-ampm nil
        org-agenda-time-leading-zero t))

(load-theme 'modus-vivendi)
(let ((directory (locate-user-emacs-file ".cache/backups/")))
  (make-directory directory t)
  (setq backup-directory-alist `(("." . ,directory))))
(setq auto-save-default nil)
(setq make-backup-files nil
      backup-by-copying t
      backup-inhibited nil
      version-control t
      kept-new-versions 6
      kept-old-versions 2
      delete-old-versions t
      create-lockfiles t)
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
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  ;; Let evil-org own agenda bindings and its initial Evil state.
  (evil-collection-init (remove 'org-agenda evil-collection-mode-list)))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :ensure t
  :after evil
  :hook ((org-mode . evil-org-mode)
         (evil-org-mode . evil-normalize-keymaps))
  :init
  (setq evil-org-key-theme '(navigation insert textobjects additional calendar todo)
        evil-org-use-additional-insert t)
  :config
  (setq org-cycle-emulate-tab nil)
  (evil-org-set-key-theme)
  ;; Terminal TAB is C-i; bind both it and graphical TAB in Org buffers.
  (evil-define-key '(normal visual) evil-org-mode-map
    (kbd "TAB") #'org-cycle
    (kbd "<tab>") #'org-cycle))

(use-package evil-org-agenda
  :ensure nil
  :after (evil org-agenda)
  :demand t
  :config
  (evil-org-agenda-set-keys))

(defcustom my/books-directory (expand-file-name "~/Asiakirjat/books/")
  "Directory containing books and documentation."
  :type 'directory
  :group 'files)

(defvar my/books-history nil)

(defun my/find-book ()
  "Find a book or document recursively using the built-in completion UI."
  (interactive)
  (let* ((directory (file-name-as-directory (expand-file-name my/books-directory)))
         (default-directory directory)
         (case-fold-search t)
         (completion-styles '(flex basic)))
    (unless (file-directory-p directory)
      (user-error "Book directory does not exist: %s" directory))
    (let* ((files
            (directory-files-recursively
             directory
             "\\.\\(?:pdf\\|epub\\|djvu\\|mobi\\|azw3?\\|org\\|md\\|txt\\|rst\\|html?\\|docx?\\|odt\\|pptx?\\|tex\\)\\'"
             nil
             (lambda (subdirectory)
               (let ((name (file-name-nondirectory (directory-file-name subdirectory))))
                 (and (file-readable-p subdirectory)
                      (not (string-prefix-p "." name))
                      (not (member name '("venv" "env" "node_modules" "__pycache__"))))))))
           (candidates (mapcar (lambda (file) (file-relative-name file directory)) files)))
      (unless candidates
        (user-error "No books or documents found in %s" directory))
      (find-file
       (expand-file-name
        (completing-read "Book or document: " candidates nil t nil 'my/books-history)
        directory)))))

(defcustom my/notes-directory (expand-file-name "~/Asiakirjat/org/opinnot/")
  "Directory containing notes."
  :type 'directory
  :group 'files)

(with-eval-after-load 'org
  (add-to-list 'org-agenda-files my/notes-directory t))

(defvar my/notes-history nil)

(defun my/find-note ()
  "Find a note recursively using the built-in completion UI."
  (interactive)
  (let* ((directory (file-name-as-directory (expand-file-name my/notes-directory)))
         (default-directory directory)
         (completion-styles '(flex basic)))
    (unless (file-directory-p directory)
      (user-error "Notes directory does not exist: %s" directory))
    (let* ((files (directory-files-recursively
                   directory "^[^.].*"
                   nil
                   (lambda (subdirectory)
                     (not (string-prefix-p
                           "." (file-name-nondirectory
                                 (directory-file-name subdirectory)))))))
           (candidates (mapcar (lambda (file) (file-relative-name file directory)) files)))
      (unless candidates
        (user-error "No notes found in %s" directory))
      (find-file
       (expand-file-name
        (completing-read "Note: " candidates nil t nil 'my/notes-history)
        directory)))))

(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC")

  (my/leader
    "SPC" #'switch-to-buffer
    "a" #'org-agenda
    "s b" #'my/find-book
    "s n" #'my/find-note
    "s c" #'cheat-sh
    "s d" #'devdocs-lookup
    "f f" #'find-file
    "f d" #'dired-jump
    "b b" #'switch-to-buffer
    "b d" #'kill-current-buffer
    "e n" #'flymake-goto-next-error
    "e p" #'flymake-goto-prev-error
    "e e" #'flymake-show-buffer-diagnostics
    "z z" #'ispell-word
    "z b" #'flyspell-buffer
    "z l" #'ispell-change-dictionary
    "h k" #'describe-key
    "t" #'ghostel
    "d d" #'devdocs-lookup
    "d i" #'devdocs-install)
  (with-eval-after-load 'org
    (my/leader
      :keymaps 'org-mode-map
      "m s" #'org-schedule
      "m d" #'org-deadline))
  (general-define-key
   :states 'normal
   :keymaps 'override
   "C-p" #'project-find-file
   "gcc" #'comment-line)
  (general-define-key
   :states 'visual
   :keymaps 'override
   "gc" #'comment-or-uncomment-region))
   
;; LSP leader keybindings
(my/leader
  "c a" #'lsp-execute-code-action
  "r n" #'lsp-rename
  "l f" #'lsp-format-buffer)

;; LSP navigation
(general-define-key
 :states 'normal
 :keymaps 'lsp-mode-map
 "K" #'lsp-describe-thing-at-point
 "gr" #'lsp-find-references
 "gI" #'lsp-find-implementation)
(global-set-key (kbd "C-SPC") #'completion-at-point)
(global-set-key (kbd "C-S-p") #'execute-extended-command)

;; Built-in spelling checks: prose everywhere, comments/strings in code.
(use-package ispell
  :ensure nil
  :custom
  ;; Enchant supports Finnish via Voikko and English/Swedish via Hunspell.
  (ispell-program-name "enchant-2")
  (ispell-dictionary "en_US"))

(use-package flyspell
  :ensure nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))

(use-package ghostel
  :ensure t
  :commands ghostel
  :init
  (setq ghostel-module-directory (locate-user-emacs-file ".cache/ghostel/")
        ghostel-module-auto-install 'download)
  (evil-set-initial-state 'ghostel-mode 'emacs)
  ;; Global Evil can activate after the major-mode hook has already run.
  (add-hook 'evil-local-mode-hook #'my/ghostel-plain-terminal)
  :hook
  (ghostel-mode . my/ghostel-plain-terminal)
  :preface
  (defun my/ghostel-plain-terminal ()
    "Send terminal keys directly, without Evil or line numbers."
    (when (derived-mode-p 'ghostel-mode)
      (when evil-local-mode (evil-local-mode -1))
      (display-line-numbers-mode -1)))
  :config
  (when (eq system-type 'windows-nt)
    (setq ghostel-shell (or (executable-find "pwsh")
                            (executable-find "powershell")
                            (getenv "COMSPEC") "cmd.exe"))))

(use-package devdocs
  :ensure t
  :commands (devdocs-install devdocs-lookup)
  :bind ("C-h D" . devdocs-lookup))

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

;;; cheat.sh: use the locally installed client.
(defun my-cheat-sh-local (topic)
  "Look up TOPIC using the local cht.sh client."
  (with-temp-buffer
    (let* ((query (concat topic (if (string-match-p "?" topic) "&T" "?T")))
           (status (call-process (expand-file-name "~/bin/cht.sh")
                                 nil t nil query)))
      (unless (equal status 0)
        (error "Local cheat.sh lookup failed: %s" (buffer-string)))
      (buffer-string))))

(use-package cheat-sh
  :ensure t
  :commands (cheat-sh cheat-sh-list cheat-sh-search-topic)
  :config
  (advice-add 'cheat-sh-get :override #'my-cheat-sh-local)
  (setq cheat-sh-sheet-list nil
        cheat-sh-sheet-list-acquired nil))
;; Emacsin oma koodintäydennys
(setq tab-always-indent 'complete)

;; LSP
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((c-mode c++-mode python-mode sh-mode vhdl-mode vhdl-ts-mode) . lsp-deferred)
  :init
  (setq lsp-vhdl-server 'vhdl-ls)
  (let ((server (expand-file-name
                 ".cache/lsp/vhdl-ls/vhdl_ls-x86_64-unknown-linux-gnu/bin/vhdl_ls"
                 user-emacs-directory)))
    (when (and (eq system-type 'gnu/linux) (file-executable-p server))
      (setq lsp-vhdl-server-path server)))
  :custom
  (lsp-completion-provider :capf)
  (lsp-diagnostics-provider :flymake)
  (lsp-enable-snippet nil))
;;; Function keys - Debugging
;;; Function keys - Build and Run

(defun my/run ()
  "Run a command without debugging."
  (interactive)
  (let ((compile-command
         (read-shell-command "Run: " compile-command)))
    (compile compile-command)))

(global-set-key (kbd "<f1>") #'recompile)
(global-set-key (kbd "<f2>") #'my/run)
(global-set-key (kbd "<f7>") #'compile)
(global-set-key (kbd "<f8>") #'next-error)
(global-set-key (kbd "S-<f8>") #'previous-error)
(global-set-key (kbd "<f12>") #'eval-buffer)

(use-package dap-mode
  :ensure t
  :commands (dap-debug
             dap-debug-restart
             dap-disconnect
             dap-continue
             dap-stop-thread
             dap-breakpoint-toggle
             dap-next
             dap-step-in
             dap-step-out)
  :bind
  (("<f3>" . dap-debug-restart)
   ("<f4>" . dap-disconnect)
   ("<f5>" . my/debug-start-or-continue)
   ("<f6>" . dap-stop-thread)
   ("<f9>" . dap-breakpoint-toggle)
   ("<f10>" . dap-next)
   ("<f11>" . dap-step-in)
   ("S-<f11>" . dap-step-out))
  :config
  ;; GDB 14+ includes a native DAP adapter; this machine has GDB 17.
  (require 'dap-gdb)
  (dap-register-debug-provider "gdb" #'my/dap-gdb-launch-configuration)
  (dap-register-debug-template
   "C/C++ (GDB)"
   '(:type "gdb" :request "launch" :name "C/C++ (GDB)"
     :stopAtBeginningOfMainSubprogram t)))

(defun my/dap-gdb-launch-configuration (configuration)
  "Prepare a native GDB launch, asking for the compiled program if needed."
  (unless (executable-find "gdb")
    (user-error "Install GDB 14 or newer to debug C/C++ programs"))
  (let* ((program (or (plist-get configuration :program)
                      (read-file-name "Compiled program to debug: "
                                      default-directory nil t)))
         (program (expand-file-name program)))
    (unless (and (file-regular-p program) (file-executable-p program))
      (user-error "Choose a compiled executable, not a source file: %s" program))
    (dap-gdb--populate-gdb
     (plist-put (copy-sequence configuration) :program program))))

(defun my/debug-start-or-continue ()
  "Start debugging or continue the active session."
  (interactive)
  (require 'dap-mode)
  (if (and (dap--cur-session)
           (dap--session-running (dap--cur-session)))
      (call-interactively #'dap-continue)
    (call-interactively #'dap-debug)))
(use-package yasnippet
  :ensure t
  :custom
  (yas-snippet-dirs
   (list (locate-user-emacs-file "snippets")))
  :config
  (yas-global-mode 1))

(use-package cape
  :ensure t
  :demand t)

(use-package corfu
  :ensure t
  :demand t
  :custom
  (corfu-auto nil)
  (corfu-preview-current nil)
  (corfu-preselect 'first)
  (corfu-on-exact-match 'show)
  :config
  (keymap-set corfu-map "RET" #'corfu-insert)
  (keymap-set corfu-map "<escape>" #'corfu-quit)
  (keymap-set corfu-map "<down>" #'corfu-next)
  (keymap-set corfu-map "<up>" #'corfu-previous)
  (global-corfu-mode 1)
  (require 'corfu-popupinfo)
  (setq corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-popupinfo-mode 1))

(use-package yasnippet-capf
  :ensure t
  :after yasnippet
  :demand t
  :preface
  (defun my/code-completion ()
    "Merge snippet and LSP candidates, preserving their documentation."
    (if (bound-and-true-p lsp-completion-mode)
        (cape-wrap-super #'yasnippet-capf #'lsp-completion-at-point)
      (yasnippet-capf)))
  (defun my/snippet-completion ()
    "Offer snippets and LSP together without accumulating duplicate hooks."
    (when (bound-and-true-p yas-minor-mode)
      (setq-local completion-at-point-functions
                  (cons #'my/code-completion
                        (remove #'my/code-completion
                                (remove #'yasnippet-capf
                                        completion-at-point-functions))))))
  :hook
  (yas-minor-mode . my/snippet-completion)
  (lsp-completion-mode . my/snippet-completion))
