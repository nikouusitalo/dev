;;; init.el --- Emacs-Kick --- A feature rich Emacs config for (neo)vi(m)mers -*- lexical-binding: t; -*-
;; Author: Rahul Martim Juliato

;; Version: 0.3.4
;; Package-Requires: ((emacs "30.1"))
;; License: GPL-2.0-or-later

;;; Commentary:
;; =====================================================================
;; ==================== READ THIS BEFORE CONTINUING ====================
;; =====================================================================
;;
;;                      ⣠⣶⣿⣿⣶⡄         ⠀⣀⣤⣄⡀
;;                      ⣿⣿⣿⣿λ⣿         ⣾)⣿⣿⣿⡆
;;                      ⠹⢿⣿⣿⡿⠃        ⠀⣿⣿⣿⣿⣿⡏⢀⣀⡀
;;                      ⣠⣤⣦⡄           ⠈⠛⠿⣟⣋⣼⣽⣾⣽⣦⡀⠀
;;                      ⣼⣿⣷⣾⡽⡄       ⣴⣶⣶⣿⣿⣿⡿⢿⣟⣽⣾⣿⣿⣦
;;                     ⣸⣿⣿⣾⣿⣿⣮⣤⣤⣤⣤⡀  ⠻⣿⡯⠽⠿⠛⠛⠉⠉⢿⣿⣿⣿⣿⣷
;;                     ⣿⣿⢻⣿⣿⣿⣛⡿⠿⠟⠛⠁⣀⣠⣤⣤⣶⣶⣶⣶⣷⣶ ⠀⠻⣿⣿⣿⣿⣇
;;                     ⢻⣿⡆⢿⣿⣿⣿⣿⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟ ⣠⣶⣿⣿⣿⣿
;;                     ⠈⠛⠃⠈⢿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠋⠉     ⣠⣾⣿⣿⣿⠟⠋
;;                          ⠙⢿⣿⣿⡏         ⠀⣴⣿⣿⣿⠟
;;                           ⢸E⣿⡇         ⣼⣿⣿⣿
;;                           ⢸M⣿⣿        ⢸⣿⣿⣿
;;                           ⢸A⣿⣿        ⠸⣿⣿
;;                           ⢸C⣿⣿
;;                           ⣼S⣿⡇
;;                          ⠀⠻⣿⡿
;; =====================================================================
;; =====================================================================

;; What is Emacs-Kick?
;;
;; Emacs-Kick is `not' a distribution.
;;
;; Emacs-Kick is a starting point for your own configuration.  The goal
;; is that you can read every line of code, top-to-bottom, understand
;; what your configuration is doing, and modify it to suit your needs.
;;
;; Once you've done that, you can start exploring, configuring, and
;; tinkering to make Emacs your own! That might mean leaving Emacs
;; Kick just the way it is for a while or immediately breaking it into
;; modular pieces.  It's up to you!
;;
;; If you don't know anything about Emacs Lisp, I recommend taking
;; some time to read through a guide.
;; One possible example which will only take 10-15 minutes:
;; - https://learnxinyminutes.com/docs/elisp/
;;
;; After understanding a bit more about Emacs Lisp, you can use `M-x
;; info RET` (info) for a reference on how Emacs integrates it.
;;
;;
;; Emacs-Kick Guide:
;;
;; Well, this config ASSUMES you already knows (neo)vi(m) bindings,
;; and the bases of how it works.  This is the `Emacs config for
;; vimmers'.  So, if you're not familiar with it, go for
;; `kickstart.nvim', get used to it, and than come back.
;;
;; On Emacs, help can be found multiple ways.
;; With this config, the leader key is SPC.
;; - <leader> h i opens the info (Also `M-x info RET')
;; - <leader> h v explores available variables
;; - <leader> h f explores avaliable functions
;; - <leader> h k explores avaliable keybindings
;;
;; If, at any time you need to find some functionality, Emacs `M-x'
;; (Meta is alt on most cases, option or command), works like a
;; command pallete, you can for example type `M-x quit' and be
;; presented with various options to quit Emacs.
;;
;; Once you've completed that, you can continue working through
;; `AND READING' the rest of the kickstart configuration.
;;
;; I have left several comments throughout the configuration.  These
;; are hints about where to find more information about the relevant
;; settings, packages, or Emacs features used in Emacs-Kick.
;;
;; Feel free to delete them once you know what you're doing, but they
;; should serve as a guide for when you are first encountering a few
;; different constructs in your Emacs config.
;;
;; If you encounter any errors while installing Emacs-Kick,
;; check the *Messages* buffer for more information. You can switch
;; buffers using `<leader> SPC`, and all option menus can be navigated
;; with `C-p` and `C-n`.
;;
;; I hope you enjoy your Emacs journey,
;; - Rahul
;;
;; P.S.  You can delete this when you're done too.  It's your config
;; now! :)


;;; Code:

;; Performance Hacks
;; Emacs is an Elisp interpreter, and when running programs or packages,
;; it can occasionally experience pauses due to garbage collection.
;; By increasing the garbage collection threshold, we reduce these pauses
;; during heavy operations, leading to smoother performance.
(setq gc-cons-threshold #x40000000)

;; Set the maximum output size for reading process output, allowing for larger data transfers.
(setq read-process-output-max (* 1024 1024 4))

;; Disable JIT native compilation during normal usage.
;; All native compilation is handled upfront during installation
;; (e.g., via `ek-reinstall.sh' or `ek/first-install').
;; This prevents Emacs from compiling packages in the background
;; while you're working, which can cause occasional stutters.
(setq native-comp-jit-compilation nil)
;; If you find Emacs slow for your usage, JIT native compilation increases
;; performance dramatically.  Its default behavior, however, can be confusing
;; for newcomers since it compiles things in the background unpredictably.
;; To enable it, change the value above to `t'.  After that, every time you
;; first use a feature, JIT will compile it in the background, so expect
;; things to be sluggish for a bit.  Once everything is compiled, it's
;; speed all the way.

;; Do I really need a speedy startup?
;; Well, this config launches Emacs in about ~0.3 seconds,
;; which, in modern terms, is a miracle considering how fast it starts
;; with external packages.
;; It wasn’t until the recent introduction of tools for lazy loading
;; that a startup time of less than 20 seconds was even possible.
;; Other fast startup methods were introduced over time.
;; You may have heard of people running Emacs as a server,
;; where you start it once and open multiple clients instantly connected to that server.
;; Some even run Emacs as a systemd or sysV service, starting when the machine boots.
;; While this is a great way of using Emacs, we WON’T be doing that here.
;; I think 0.3 seconds is fast enough to avoid issues that could arise from
;; running Emacs as a server, such as 'What version of Node is my LSP using?'.
;; Again, this setup configures Emacs much like how a Vimmer would configure Neovim.


;; Emacs comes with a built-in package manager (`package.el'), and we'll use it
;; when it makes sense. However, `straight.el' is a bit more user-friendly and
;; reproducible, especially for newcomers and shareable configs like emacs-kick.
;; So we bootstrap it here.
(setq package-enable-at-startup nil) ;; Disables the default package manager.

;; Bootstraps `straight.el'
(setq straight-check-for-modifications nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package '(project :type built-in))
(straight-use-package 'use-package)


;; In Emacs, a package is a collection of Elisp code that extends the editor's functionality,
;; much like plugins do in Neovim. We need to import this package to add package archives.
(require 'package)

;; Add MELPA (Milkypostman's Emacs Lisp Package Archive) to the list of package archives.
;; This allows you to install packages from this widely-used repository, similar to how
;; pip works for Python or npm for Node.js. While Emacs comes with ELPA (Emacs Lisp
;; Package Archive) configured by default, which contains packages that meet specific
;; licensing criteria, MELPA offers a broader range of packages and is considered the
;; standard for Emacs users. You can also add more package archives later as needed.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Define a global customizable variable `ek-use-nerd-fonts' to control the use of
;; Nerd Fonts symbols throughout the configuration. This boolean variable allows
;; users to easily enable or disable the use of symbols from Nerd Fonts, providing
;; flexibility in appearance settings. By setting it to `t', we enable Nerd Fonts
;; symbols; setting it to `nil' would disable them.
(defcustom ek-use-nerd-fonts t
  "Configuration for using Nerd Fonts Symbols."
  :type 'boolean
  :group 'appearance)


;; From now on, you'll see configurations using the `use-package` macro, which
;; allows us to organize our Emacs setup in a modular way. These configurations
;; look like this:
;;
;; (use-package some-package
;;   :ensure t     ;; Ensure the package is installed (used with package.el).
;;   :straight t   ;; Use straight.el to install and manage this package.
;;   :config       ;; Configuration settings for the package.
;;   ;; Additional settings can go here.
;; )
;;
;; This approach simplifies package management, enabling us to easily control
;; both built-in (first-party) and external (third-party) packages. While Emacs
;; is a vast and powerful editor, using `use-package`—especially in combination
;; with `straight.el`—helps streamline our configuration for better organization,
;; reproducibility, and customization. As we proceed, you'll see smaller
;; `use-package` declarations for specific packages, which will help us enable
;; the desired features and improve our workflow.


;;; EMACS
;;  This is biggest one. Keep going, plugins (oops, I mean packages) will be shorter :)
(use-package emacs
  :ensure nil
  :custom                                         ;; Set custom variables to configure Emacs behavior.
  (auto-save-default nil)                         ;; Disable automatic saving of buffers.
  (column-number-mode t)                          ;; Display the column number in the mode line.
  (create-lockfiles nil)                          ;; Prevent the creation of lock files when editing.
  (delete-by-moving-to-trash t)                   ;; Move deleted files to the trash instead of permanently deleting them.
  (delete-selection-mode 1)                       ;; Enable replacing selected text with typed text.
  (display-line-numbers-type 'relative)           ;; Use relative line numbering in programming modes.
  (global-auto-revert-non-file-buffers t)         ;; Automatically refresh non-file buffers.
  (history-length 25)                             ;; Set the length of the command history.
  (large-file-warning-threshold nil)              ;; Open large files without a confirmation prompt.
  (indent-tabs-mode nil)                          ;; Disable the use of tabs for indentation (use spaces instead).
  (inhibit-startup-message t)                     ;; Disable the startup message when Emacs launches.
  (initial-scratch-message "")                    ;; Clear the initial message in the *scratch* buffer.
  (ispell-dictionary "en_US")                     ;; Set the default dictionary for spell checking.
  (make-backup-files nil)                         ;; Disable creation of backup files.
  (pixel-scroll-precision-mode t)                 ;; Enable precise pixel scrolling.
  (pixel-scroll-precision-use-momentum nil)       ;; Disable momentum scrolling for pixel precision.
  (ring-bell-function 'ignore)                    ;; Disable the audible bell.
  (split-width-threshold 300)                     ;; Prevent automatic window splitting if the window width exceeds 300 pixels.
  (switch-to-buffer-obey-display-actions t)       ;; Make buffer switching respect display actions.
  (tab-always-indent 'complete)                   ;; Make the TAB key complete text instead of just indenting.
  (tab-width 4)                                   ;; Set the tab width to 4 spaces.
  (treesit-font-lock-level 4)                     ;; Use advanced font locking for Treesit mode.
  (truncate-lines t)                              ;; Enable line truncation to avoid wrapping long lines.
  (use-dialog-box nil)                            ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t)                           ;; Use short answers in prompts for quicker responses (y instead of yes)
  (warning-minimum-level :emergency)              ;; Set the minimum level of warnings to display.

  :hook                                           ;; Add hooks to enable specific features in certain modes.
  (prog-mode . display-line-numbers-mode)         ;; Enable line numbers in programming modes.

  :config
  ;; By default emacs gives you access to a lot of *special* buffers, while navigating with [b and ]b,
  ;; this might be confusing for newcomers. This settings make sure ]b and [b will always load a
  ;; file buffer. To see all buffers use <leader> SPC, <leader> b l, or <leader> b i.
  (defun skip-these-buffers (_window buffer _bury-or-kill)
    "Function for `switch-to-prev-buffer-skip'."
    (string-match "\\*[^*]+\\*" (buffer-name buffer)))
  (setq switch-to-prev-buffer-skip 'skip-these-buffers)


  ;; Configure font settings based on the operating system.
  ;; Ok, this kickstart is meant to be used on the terminal, not on GUI.
  ;; But without this, I fear you could start Graphical Emacs and be sad :(
  (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font"  :height 100)
  (when (eq system-type 'darwin)       ;; Check if the system is macOS.
    (setq mac-command-modifier 'meta)  ;; Set the Command key to act as the Meta key.
    (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 130))

  ;; Save manual customizations to a separate file instead of cluttering `init.el'.
  ;; You can M-x customize, M-x customize-group, or M-x customize-themes, etc.
  ;; The saves you do manually using the Emacs interface would overwrite this file.
  ;; The following makes sure those customizations are in a separate file.
  (setq custom-file (locate-user-emacs-file "custom-vars.el")) ;; Specify the custom file path.
  (load custom-file 'noerror 'nomessage)                       ;; Load the custom file quietly, ignoring errors.

  ;; Makes Emacs vertical divisor the symbol │ instead of |.
  (set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?│))

  :init                        ;; Initialization settings that apply before the package is loaded.
  (tool-bar-mode -1)           ;; Disable the tool bar for a cleaner interface.
  (menu-bar-mode -1)           ;; Disable the menu bar for a more streamlined look.

  (when scroll-bar-mode
    (scroll-bar-mode -1))      ;; Disable the scroll bar if it is active.

  (global-hl-line-mode -1)     ;; Disable highlight of the current line
  (global-auto-revert-mode 1)  ;; Enable global auto-revert mode to keep buffers up to date with their corresponding files.
  (recentf-mode 1)             ;; Enable tracking of recently opened files.
  (savehist-mode 1)            ;; Enable saving of command history.
  (save-place-mode 1)          ;; Enable saving the place in files for easier return.
  (winner-mode 1)              ;; Enable winner mode to easily undo window configuration changes.
  (xterm-mouse-mode 1)         ;; Enable mouse support in terminal mode.
  (file-name-shadow-mode 1)    ;; Enable shadowing of filenames for clarity.

  ;; Set the default coding system for files to UTF-8.
  (modify-coding-system-alist 'file "" 'utf-8)

  ;; Add a hook to run code after Emacs has fully initialized.
  (add-hook 'after-init-hook
            (lambda ()
              (message "Emacs has fully loaded. This code runs after startup.")

              ;; Insert a welcome message in the *scratch* buffer displaying loading time and activated packages.
              (with-current-buffer (get-buffer-create "*scratch*")
                (insert (format
                         ";;    Welcome to Emacs!
;;
;;    Loading time : %s
;;    Packages     : %s
"
                         (emacs-init-time)
                         (length (hash-table-keys straight--recipe-cache))))))))


;;; WINDOW
;; This section configures window management in Emacs, enhancing the way buffers
;; are displayed for a more efficient workflow. The `window' use-package helps
;; streamline how various buffers are shown, especially those related to help,
;; diagnostics, and completion.
;;
;; Note: I have left some commented-out code below that may facilitate your
;; Emacs journey later on. These configurations can be useful for displaying
;; other types of buffers in side windows, allowing for a more organized workspace.
(use-package window
  :ensure nil       ;; This is built-in, no need to fetch it.
  :custom
  (display-buffer-alist
   '(
     ;; ("\\*.*e?shell\\*"
     ;;  (display-buffer-in-side-window)
     ;;  (window-height . 0.25)
     ;;  (side . bottom)
     ;;  (slot . -1))

     ("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|[Hh]elp\\|Messages\\|Bookmark List\\|Ibuffer\\|Occur\\|eldoc.*\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0))

     ;; Example configuration for the LSP help buffer,
     ;; keeps it always on bottom using 25% of the available space:
     ("\\*\\(lsp-help\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0))

     ;; Configuration for displaying various diagnostic buffers on
     ;; bottom 25%:
     ("\\*\\(Flymake diagnostics\\|xref\\|ivy\\|Swiper\\|Completions\\)"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 1))
     )))


;;; DIRED
;; In Emacs, the `dired' package provides a powerful and built-in file manager
;; that allows you to navigate and manipulate files and directories directly
;; within the editor. If you're familiar with `oil.nvim', you'll find that
;; `dired' offers similar functionality natively in Emacs, making file
;; management seamless without needing external plugins.

;; This configuration customizes `dired' to enhance its usability. The settings
;; below specify how file listings are displayed, the target for file operations,
;; and associations for opening various file types with their respective applications.
;; For example, image files will open with `feh', while audio and video files
;; will utilize `mpv'.
(use-package dired
  :ensure nil                                                ;; This is built-in, no need to fetch it.
  :custom
  (dired-listing-switches "-lah --group-directories-first")  ;; Display files in a human-readable format and group directories first.
  (dired-dwim-target t)                                      ;; Enable "do what I mean" for target directories.
  (dired-guess-shell-alist-user
   '(("\\.\\(png\\|jpe?g\\|tiff\\)" "feh" "xdg-open" "open") ;; Open image files with `feh' or the default viewer.
     ("\\.\\(mp[34]\\|m4a\\|ogg\\|flac\\|webm\\|mkv\\)" "mpv" "xdg-open" "open") ;; Open audio and video files with `mpv'.
     (".*" "open" "xdg-open")))                              ;; Default opening command for other files.
  (dired-kill-when-opening-new-dired-buffer t)               ;; Close the previous buffer when opening a new `dired' instance.
  :config
  (when (eq system-type 'darwin)
    (let ((gls (executable-find "gls")))                     ;; Use GNU ls on macOS if available.
      (when gls
        (setq insert-directory-program gls)))))


;;; PDF READING
;; PDF Tools needs epdfinfo; this Fedora installation has a local build.
;; On other machines, install epdfinfo and make it available on PATH.
(use-package pdf-tools
  :ensure nil
  :straight t
  :demand t
  :init
  (let ((server (locate-user-emacs-file ".local/pdf-tools/epdfinfo")))
    (when (and (eq system-type 'gnu/linux) (file-executable-p server))
      (setq pdf-info-epdfinfo-program server)))
  :custom
  (pdf-view-display-size 'fit-width)
  :config
  (pdf-tools-install-noverify)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
  (defun ek/pdf-view-keys ()
    "Keep the familiar PDF navigation keys after Evil Collection setup."
    (evil-define-key 'normal pdf-view-mode-map
      (kbd "n") #'pdf-view-next-page-command
      (kbd "p") #'pdf-view-previous-page-command
      (kbd "+") #'pdf-view-enlarge
      (kbd "-") #'pdf-view-shrink
      (kbd "W") #'pdf-view-fit-width-to-window
      (kbd "q") #'quit-window))
  (with-eval-after-load 'evil
    (ek/pdf-view-keys))
  (with-eval-after-load 'evil-collection
    (add-hook 'evil-collection-setup-hook
              (lambda (mode &rest _)
                (when (eq mode 'pdf) (ek/pdf-view-keys))))))


;;; LATEX
(use-package tex
  :ensure nil
  :straight auctex
  :defer t
  :init
  ;; Use this machine's local TeX Live, or the system installation elsewhere.
  (let ((bin (expand-file-name
              (locate-user-emacs-file ".local/texlive/bin/x86_64-linux"))))
    (when (and (eq system-type 'gnu/linux) (file-directory-p bin))
      (add-to-list 'exec-path bin)
      (setenv "PATH" (concat bin path-separator (getenv "PATH")))))
  (load "auctex" nil t)
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-PDF-mode t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  :config
  (add-to-list 'TeX-view-program-selection '(output-pdf "PDF Tools"))
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))


;;; EPUB READING
(use-package nov
  :ensure nil
  :straight t
  :mode ("\\.epub\\'" . nov-mode)
  :custom
  (nov-text-width 80)
  :hook
  (nov-mode . (lambda () (display-line-numbers-mode -1))))


;;; TABS
;; Each tab keeps its own window layout, including project/terminal splits.
(use-package tab-bar
  :ensure nil
  :demand t
  :custom
  (tab-bar-show 1)
  (tab-bar-new-tab-choice "*scratch*")
  :config
  (tab-bar-mode 1))


;;; MUSIC
(use-package emms
  :ensure nil
  :straight t
  :commands (emms-playlist-mode-go emms-play-file emms-play-directory-tree)
  :preface
  (defun ek/music ()
    "Open the music playlist, creating an empty one if necessary."
    (interactive)
    (require 'emms)
    (unless (buffer-live-p emms-playlist-buffer)
      (setq emms-playlist-buffer (emms-playlist-new "*Music*")))
    (emms-playlist-mode-go))
  :init
  (setq emms-directory (locate-user-emacs-file ".local/emms/"))
  :config
  (require 'emms-setup)
  (emms-minimalistic)
  (require 'emms-playlist-mode)
  ;; Use the installed FFplay on Linux; prefer mpv/VLC when available.
  (define-emms-simple-player ffplay '(file url)
    (emms-player-simple-regexp "mp3" "flac" "ogg" "opus" "wav" "m4a" "aac" "wma")
    "ffplay" "-nodisp" "-autoexit" "-loglevel" "error")
  (setq emms-player-list
        (cond ((executable-find "mpv") '(emms-player-mpv))
              ((executable-find "vlc") '(emms-player-vlc))
              ((and (eq system-type 'gnu/linux) (executable-find "ffplay"))
               '(emms-player-ffplay))
              (t '(emms-player-mpv)))))


;;; CHEAT SHEETS
(use-package cheat-sh
  :ensure nil
  :straight t
  :commands (cheat-sh cheat-sh-search cheat-sh-search-topic)
  :config
  (setq cheat-sh-url "https://cheat.sh/%s?T")
  (with-eval-after-load 'evil
    (evil-set-initial-state 'cheat-sh-mode 'normal)))


;;; RSS / ATOM
(use-package elfeed
  :ensure nil
  :straight t
  :commands (elfeed elfeed-add-feed elfeed-update)
  :init
  (setq elfeed-db-directory (locate-user-emacs-file ".local/elfeed/")))


;;; EMAIL
;; Gnus and SMTP support ship with Emacs.  Account settings are kept separate.
(use-package gnus
  :ensure nil
  :commands gnus
  :init
  (setq gnus-directory (locate-user-emacs-file ".local/mail/")
        gnus-startup-file (locate-user-emacs-file ".local/mail/newsrc")
        gnus-init-file (locate-user-emacs-file "mail-accounts.el")
        ;; Do not contact a default news server before mail accounts are set up.
        gnus-select-method '(nnnil)
        gnus-secondary-select-methods nil))

(use-package smtpmail
  :ensure nil
  :defer t
  :init
  (setq message-send-mail-function #'smtpmail-send-it))


;;; ERC
;; In this section, we introduce ERC (Emacs Relay Chat), a built-in IRC client
;; that allows you to engage in real-time chat directly within Emacs. While
;; we're aiming to maintain functionality similar to Neovim, it's important to
;; recognize that Emacs is often viewed as more than just a text editor. Many
;; users leverage Emacs for a variety of tasks beyond editing text: from watching
;; videos and listening to music, to managing emails and even serving as a window
;; manager in Xorg, freeing themselves from traditional desktop environments.
;;
;; While this kickstarter focuses on essential configurations, I wanted to present
;; ERC as a glimpse into Emacs's versatility. With ERC, you can seamlessly connect
;; to IRC channels and interact with communities without leaving your editor.
(use-package erc
  :defer t ;; Load ERC when needed rather than at startup. (Load it with `M-x erc RET')
  :custom
  (erc-join-buffer 'window)                                        ;; Open a new window for joining channels.
  (erc-hide-list '("JOIN" "PART" "QUIT"))                          ;; Hide messages for joins, parts, and quits to reduce clutter.
  (erc-timestamp-format "[%H:%M]")                                 ;; Format for timestamps in messages.
  (erc-autojoin-channels-alist '((".*\\.libera\\.chat" "#emacs"))));; Automatically join the #emacs channel on Libera.Chat.


;;; ISEARCH
;; In this configuration, we're setting up isearch, Emacs's incremental search feature.
;; Since we're utilizing Vim bindings, keep in mind that classic Vim search commands
;; (like `/' and `?') are not bound in the same way. Instead, you'll need to use
;; the standard Emacs shortcuts:
;; - `C-s' to initiate a forward search
;; - `C-r' to initiate a backward search
;; The following settings enhance the isearch experience:
(use-package isearch
  :ensure nil                                  ;; This is built-in, no need to fetch it.
  :config
  (setq isearch-lazy-count t)                  ;; Enable lazy counting to show current match information.
  (setq lazy-count-prefix-format "(%s/%s) ")   ;; Format for displaying current match count.
  (setq lazy-count-suffix-format nil)          ;; Disable suffix formatting for match count.
  (setq search-whitespace-regexp ".*?")        ;; Allow searching across whitespace.
  :bind (("C-s" . isearch-forward)             ;; Bind C-s to forward isearch.
         ("C-r" . isearch-backward)))          ;; Bind C-r to backward isearch.


;;; VC
;; The VC (Version Control) package is included here for awareness and completeness.
;; While its support for Git is limited and generally considered subpar, it is good to know
;; that it exists and can be used for other version control systems like Mercurial,
;; Subversion, and Bazaar.
;; Magit, which is often regarded as the "father" of Neogit, will be configured later
;; for an enhanced Git experience.
;; The keybindings below serve as a reminder of some common VC commands.
;; But don't worry, you can always use `M-x command' :)
(use-package vc
  :ensure nil                        ;; This is built-in, no need to fetch it.
  :defer t
  :bind
  (("C-x v d" . vc-dir)              ;; Open VC directory for version control status.
   ("C-x v =" . vc-diff)             ;; Show differences for the current file.
   ("C-x v D" . vc-root-diff)        ;; Show differences for the entire repository.
   ("C-x v v" . vc-next-action))     ;; Perform the next version control action.
  :config
  ;; Better colors for <leader> v g b  (blame file)
  (setq vc-annotate-color-map
        '((20 . "#f5e0dc")
          (40 . "#f2cdcd")
          (60 . "#f5c2e7")
          (80 . "#cba6f7")
          (100 . "#f38ba8")
          (120 . "#eba0ac")
          (140 . "#fab387")
          (160 . "#f9e2af")
          (180 . "#a6e3a1")
          (200 . "#94e2d5")
          (220 . "#89dceb")
          (240 . "#74c7ec")
          (260 . "#89b4fa")
          (280 . "#b4befe"))))


;;; SMERGE
;; Smerge is included for resolving merge conflicts in files. It provides a simple interface
;; to help you keep changes from either the upper or lower version during a merge.
;; This package is built-in, so there's no need to fetch it separately.
;; The keybindings below did not needed to be setted, are here just to show
;; you how to work with it in case you are curious about it.
(use-package smerge-mode
  :ensure nil                                  ;; This is built-in, no need to fetch it.
  :defer t
  :bind (:map smerge-mode-map
              ("C-c ^ u" . smerge-keep-upper)  ;; Keep the changes from the upper version.
              ("C-c ^ l" . smerge-keep-lower)  ;; Keep the changes from the lower version.
              ("C-c ^ n" . smerge-next)        ;; Move to the next conflict.
              ("C-c ^ p" . smerge-previous)))  ;; Move to the previous conflict.


;;; ELDOC
;; Eldoc provides helpful inline documentation for functions and variables
;; in the minibuffer, enhancing the development experience. It can be particularly useful
;; in programming modes, as it helps you understand the context of functions as you type.
;; This package is built-in, so there's no need to fetch it separately.
;; The following line enables Eldoc globally for all buffers.
(use-package eldoc
  :ensure nil                                ;; This is built-in, no need to fetch it.
  :config
  (setq eldoc-idle-delay 0)                  ;; Automatically fetch doc help
  (setq eldoc-echo-area-use-multiline-p nil) ;; We use the "K" floating help instead
                                             ;; set to t if you want docs on the echo area
  (setq eldoc-echo-area-display-truncation-message nil)
  :init
  (global-eldoc-mode))


;;; FLYMAKE
;; Flymake is an on-the-fly syntax checking extension that provides real-time feedback
;; about errors and warnings in your code as you write. This can greatly enhance your
;; coding experience by catching issues early. The configuration below activates
;; Flymake mode in programming buffers.
(use-package flymake
  :ensure nil          ;; This is built-in, no need to fetch it.
  :defer t
  :hook (prog-mode . flymake-mode)
  :custom
  (flymake-margin-indicators-string
   '((error "!»" compilation-error) (warning "»" compilation-warning)
     (note "»" compilation-info))))

;;; ORG-MODE
;; Org-mode is a powerful system for organizing and managing your notes,
;; tasks, and documents in plain text. It offers features like task management,
;; outlining, scheduling, and much more, making it a versatile tool for
;; productivity. Keep Org's machine-readable timestamps, but display Finnish dates.
(use-package calendar
  :ensure nil
  :defer t
  :custom
  (calendar-week-start-day 1)
  (calendar-date-style 'european)
  (calendar-day-name-array
   ["sunnuntai" "maanantai" "tiistai" "keskiviikko" "torstai" "perjantai" "lauantai"])
  (calendar-day-abbrev-array ["su" "ma" "ti" "ke" "to" "pe" "la"])
  (calendar-day-header-array ["su" "ma" "ti" "ke" "to" "pe" "la"])
  (calendar-month-name-array
   ["tammikuu" "helmikuu" "maaliskuu" "huhtikuu" "toukokuu" "kesäkuu"
    "heinäkuu" "elokuu" "syyskuu" "lokakuu" "marraskuu" "joulukuu"])
  (calendar-month-abbrev-array
   ["tammi" "helmi" "maalis" "huhti" "touko" "kesä"
    "heinä" "elo" "syys" "loka" "marras" "joulu"])
  (calendar-date-display-form
   '((if dayname (concat dayname " ")) day "." month "." year)))

(use-package org
  :ensure nil
  :defer t
  :init
  (setq org-directory (expand-file-name "~/Asiakirjat/org/")
        org-agenda-files
        (mapcar (lambda (name) (expand-file-name name org-directory))
                '("inbox.org" "koulu.org" "oma.org"))
        org-default-notes-file (expand-file-name "inbox.org" org-directory)
        org-capture-templates
        '(("t" "Uusi tehtävä" entry
           (file+headline org-default-notes-file "Tehtävät")
           "* TODO %?\n")))
  :custom
  (org-display-custom-times t)
  (org-timestamp-custom-formats '("%-d.%-m.%Y" . "%-d.%-m.%Y %H.%M")))

(use-package org-agenda
  :ensure nil
  :defer t
  :preface
  (defun ek/org-agenda-date-finnish (date)
    "Format calendar DATE as a Finnish weekday and numeric date."
    (format "%s %d.%d.%d"
            (calendar-day-name date) (cadr date) (car date) (nth 2 date)))
  :custom
  (org-agenda-start-on-weekday 1)
  (org-agenda-format-date #'ek/org-agenda-date-finnish)
  (org-agenda-timegrid-use-ampm nil)
  (org-agenda-time-leading-zero t))


;;; LOCAL PROJECTS
(use-package project
  :ensure nil
  :demand t
  :preface
  (defun ek/project-under-code (directory)
    "Recognize direct children of ~/code as projects, including non-Git folders.
Preserve more specific version-controlled projects inside those folders."
    (unless (file-remote-p directory)
      (let* ((base (file-name-as-directory (expand-file-name "~/code/")))
             (relative (file-relative-name (expand-file-name directory) base))
             (first (car (split-string relative "/" t))))
        (when (and first
                   (not (member first '("." "..")))
                   (not (file-name-absolute-p relative)))
          (let* ((root (file-name-as-directory (expand-file-name first base)))
                 (vc-project (project-try-vc directory)))
            (when (file-directory-p root)
              (if (and vc-project
                       (or (file-equal-p (project-root vc-project) root)
                           (file-in-directory-p (project-root vc-project) root)))
                  vc-project
                (cons 'transient root))))))))

  (defun ek/refresh-code-projects ()
    "Add current direct subdirectories of ~/code to the project chooser."
    (interactive)
    (let ((base (expand-file-name "~/code/")))
      (when (file-directory-p base)
        (dolist (directory (directory-files base t "\\`[^.]"))
          (when (file-directory-p directory)
            (when-let ((project (ek/project-under-code directory)))
              (project-remember-project project)))))))
  :config
  (add-hook 'project-find-functions #'ek/project-under-code)
  (ek/refresh-code-projects))


;;; WHICH-KEY
;; `which-key' is an Emacs package that displays available keybindings in a
;; popup window whenever you partially type a key sequence. This is particularly
;; useful for discovering commands and shortcuts, making it easier to learn
;; Emacs and improve your workflow. It helps users remember key combinations
;; and reduces the cognitive load of memorizing every command.
(use-package which-key
  :ensure nil     ;; This is built-in, no need to fetch it.
  :defer t        ;; Defer loading Which-Key until after init.
  :hook
  (after-init . which-key-mode)) ;; Enable which-key mode after initialization.


;;; ==================== EXTERNAL PACKAGES ====================
;;
;; From this point onward, all configurations will be for third-party packages
;; that enhance Emacs' functionality and extend its capabilities.

;;; VERTICO
;; Vertico enhances the completion experience in Emacs by providing a
;; vertical selection interface for both buffer and minibuffer completions.
;; Unlike traditional minibuffer completion, which displays candidates
;; in a horizontal format, Vertico presents candidates in a vertical list,
;; making it easier to browse and select from multiple options.
;;
;; In buffer completion, `switch-to-buffer' allows you to select from open buffers.
;; Vertico streamlines this process by displaying the buffer list in a way that
;; improves visibility and accessibility. This is particularly useful when you
;; have many buffers open, allowing you to quickly find the one you need.
;;
;; In minibuffer completion, such as when entering commands or file paths,
;; Vertico helps by showing a dynamic list of potential completions, making
;; it easier to choose the correct one without typing out the entire string.
(use-package vertico
  :ensure t
  :straight t
  :hook
  (after-init . vertico-mode)           ;; Enable vertico after Emacs has initialized.
  :custom
  (vertico-count 10)                    ;; Number of candidates to display in the completion list.
  (vertico-resize nil)                  ;; Disable resizing of the vertico minibuffer.
  (vertico-cycle nil)                   ;; Do not cycle through candidates when reaching the end of the list.
  :config
  ;; Customize the display of the current candidate in the completion list.
  ;; This will prefix the current candidate with “» ” to make it stand out.
  ;; Reference: https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "» " 'face '(:foreground "#80adf0" :weight bold))
                   "  ")
                 cand))))


;;; ORDERLESS
;; Orderless enhances completion in Emacs by allowing flexible pattern matching.
;; It works seamlessly with Vertico, enabling you to use partial strings and
;; regular expressions to find files, buffers, and commands more efficiently.
;; This combination provides a powerful and customizable completion experience.
(use-package orderless
  :ensure t
  :straight t
  :defer t                                    ;; Load Orderless on demand.
  :after vertico                              ;; Ensure Vertico is loaded before Orderless.
  :init
  (setq completion-styles '(orderless basic)  ;; Set the completion styles.
        completion-category-defaults nil      ;; Clear default category settings.
        completion-category-overrides '((file (styles partial-completion))))) ;; Customize file completion styles.


;;; MARGINALIA
;; Marginalia enhances the completion experience in Emacs by adding
;; additional context to the completion candidates. This includes
;; helpful annotations such as documentation and other relevant
;; information, making it easier to choose the right option.
(use-package marginalia
  :ensure t
  :straight t
  :hook
  (after-init . marginalia-mode))


;;; CONSULT
;; Consult provides powerful completion and narrowing commands for Emacs.
;; It integrates well with other completion frameworks like Vertico, enabling
;; features like previews and enhanced register management. It's useful for
;; navigating buffers, files, and xrefs with ease.
(use-package consult
  :ensure t
  :straight t
  :defer t
  :preface
  (defun ek/find-files-no-ignore ()
    "Find files with fd, including files excluded by ignore rules."
    (interactive)
    (require 'consult)
    (let ((consult-fd-args
           (append (consult--build-args consult-fd-args) '("--no-ignore"))))
      (consult-fd)))

  (defun ek/search-environment ()
    "Choose an environment variable and display its value."
    (interactive)
    (let* ((names (mapcar (lambda (entry) (car (split-string entry "=")))
                          process-environment))
           (name (completing-read "Environment variable: " names nil t)))
      (with-help-window "*Environment variable*"
        (princ (format "%s=%s" name (getenv name))))))

  (defun ek/search-menu ()
    "Choose a search command by its purpose."
    (interactive)
    (let* ((commands '(("Files" . consult-fd)
                       ("Files including ignored" . ek/find-files-no-ignore)
                       ("Text in project" . consult-ripgrep)
                       ("Buffers" . consult-buffer)
                       ("Recent files" . consult-recent-file)
                       ("Current buffer lines" . consult-line)
                       ("Diagnostics" . consult-flymake)
                       ("References (LSP)" . lsp-find-references)
                       ("Type definition (LSP)" . lsp-find-type-definition)
                       ("Manuals" . consult-info)
                       ("Man pages" . consult-man)
                       ("Key bindings" . embark-bindings)
                       ("Environment" . ek/search-environment)
                       ("Git commits" . magit-log-all)))
           (choice (completing-read "Search: " commands nil t)))
      (call-interactively (cdr (assoc choice commands)))))

  (defun ek/search-word-at-point (&optional big-word)
    "Search project files literally for the word at point.
With BIG-WORD, use Evil's whitespace-delimited WORD instead."
    (interactive)
    (require 'evil)
    (require 'consult)
    (let* ((text (thing-at-point (if big-word 'evil-WORD 'evil-word) t))
           (project (project-current nil))
           (directory (if project (project-root project) default-directory))
           (consult-ripgrep-args
            (append (consult--build-args consult-ripgrep-args) '("--fixed-strings")))
           (consult-async-min-input 1)
           ;; Keep punctuation such as # literal instead of splitting the query.
           (consult-async-split-style 'none))
      (unless (and text (string-match-p "[^[:space:]]" text))
        (user-error "No word at point"))
      (consult-ripgrep directory text)))

  (defun ek/search-WORD-at-point ()
    "Search project files for the whitespace-delimited WORD at point."
    (interactive)
    (ek/search-word-at-point t))

  (defcustom ek/book-search-directory (expand-file-name "~/Asiakirjat/books/")
    "Directory searched by `ek/find-books'."
    :type 'directory :group 'files)

  (defun ek/find-books (&optional choose-directory)
    "List local books immediately and narrow their filenames as you type.
With a prefix argument, choose the directory to search.  Press M-. to preview."
    (interactive "P")
    (require 'consult)
    (let* ((fd (or (executable-find "fd") (executable-find "fdfind")
                   (user-error "Install fd to search for books")))
           (default-directory
            (file-name-as-directory
             (if choose-directory
                 (read-directory-name "Book directory: " ek/book-search-directory nil t)
               ek/book-search-directory)))
           ;; Avoid rendering large PDFs on every change of selection.
           (consult-preview-key "M-.")
           (books
            (with-temp-buffer
              (unless (zerop
                       (call-process fd nil t nil
                                     "--color=never" "--type" "f" "--no-ignore"
                                     "--extension" "pdf" "--extension" "epub"
                                     "--extension" "djvu" "--extension" "mobi"
                                     "--extension" "azw" "--extension" "azw3"
                                     "--print0" "." "."))
                (user-error "Book search failed: %s" (buffer-string)))
              (mapcar (lambda (file) (string-remove-prefix "./" file))
                      (split-string (buffer-string) "\0" t)))))
      (unless books (user-error "No books found in %s" default-directory))
      (find-file
       (consult--read books
                      :prompt "Book: "
                      :require-match t
                      :category 'file
                      :history 'file-name-history
                      :state (consult--file-state)))))
  :init
  ;; Enhance register preview with thin lines and no mode line.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult for xref locations with a preview feature.
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))


;;; EMBARK
;; Embark provides a powerful contextual action menu for Emacs, allowing
;; you to perform various operations on completion candidates and other items.
;; It extends the capabilities of completion frameworks by offering direct
;; actions on the candidates.
;; Just `<leader> .' over any text, explore it :)
(use-package embark
  :ensure t
  :straight t
  :defer t
  :preface
  (defun ek/open-externally ()
    "Open the current file or the Dired file at point in its default app."
    (interactive)
    (let ((file (if (derived-mode-p 'dired-mode)
                    (dired-get-filename nil t)
                  buffer-file-name)))
      (unless file
        (user-error "No file to open in this buffer"))
      (when (file-remote-p file)
        (user-error "External opening is supported only for local files"))
      (require 'embark)
      (embark-open-externally file))))


;;; EMBARK-CONSULT
;; Embark-Consult provides a bridge between Embark and Consult, ensuring
;; that Consult commands, like previews, are available when using Embark.
(use-package embark-consult
  :ensure t
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)) ;; Enable preview in Embark collect mode.


;;; TREESITTER-AUTO
;; Treesit-auto simplifies the use of Tree-sitter grammars in Emacs,
;; providing automatic installation and mode association for various
;; programming languages. This enhances syntax highlighting and
;; code parsing capabilities, making it easier to work with modern
;; programming languages.
(use-package treesit-auto
  :ensure t
  :straight t
  :after emacs
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode t))


;;; MARKDOWN-MODE
;; Markdown Mode provides support for editing Markdown files in Emacs,
;; enabling features like syntax highlighting, previews, and more.
;; It’s particularly useful for README files, as it can be set
;; to use GitHub Flavored Markdown for enhanced compatibility.
(use-package markdown-mode
  :defer t
  :straight t
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)            ;; Use gfm-mode for README.md files.
  :init (setq markdown-command "multimarkdown")) ;; Set the Markdown processing command.


;;; CORFU
;; Corfu Mode provides a text completion framework for Emacs.
;; It enhances the editing experience by offering context-aware
;; suggestions as you type.
;; Corfu Mode is highly customizable and can be integrated with
;; various modes and languages.
(use-package corfu
  :ensure t
  :straight t
  :defer t
  :custom
  (corfu-auto nil)                        ;; Complete manually with TAB or C-SPC in insert state.
  ;; (corfu-auto-delay 0)                ;; Delay before popup (enable if corfu-auto is t)
  (corfu-auto-prefix 1)                  ;; Trigger completion after typing 1 character
  (corfu-quit-no-match t)                ;; Quit popup if no match
  (corfu-scroll-margin 5)                ;; Margin when scrolling completions
  (corfu-max-width 50)                   ;; Maximum width of completion popup
  (corfu-min-width 50)                   ;; Minimum width of completion popup
  (corfu-popupinfo-delay 0.5)            ;; Delay before showing documentation popup
  :config
  (if ek-use-nerd-fonts
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode t))


;;; NERD-ICONS-CORFU
;; Provides Nerd Icons to be used with CORFU.
(use-package nerd-icons-corfu
  :if ek-use-nerd-fonts
  :ensure t
  :straight t
  :defer t
  :after (:all corfu))


;;; LSP
;; Emacs comes with an integrated LSP client called `eglot', which offers basic LSP functionality.
;; However, `eglot' has limitations, such as not supporting multiple language servers
;; simultaneously within the same buffer (e.g., handling both TypeScript, Tailwind and ESLint
;; LSPs together in a React project). For this reason, the more mature and capable
;; `lsp-mode' is included as a third-party package, providing advanced IDE-like features
;; and better support for multiple language servers and configurations.
;;
;; NOTE: To install or reinstall an LSP server, use `M-x install-server RET`.
;;       As with other editors, LSP configurations can become complex. You may need to
;;       install or reinstall the server for your project due to version management quirks
;;       (e.g., asdf or nvm) or other issues.
;;       Fortunately, `lsp-mode` has a great resource site:
;;       https://emacs-lsp.github.io/lsp-mode/
(use-package lsp-mode
  :ensure t
  :straight t
  :defer t
  :hook (;; Replace XXX-mode with concrete major mode (e.g. python-mode)
         (lsp-mode . lsp-enable-which-key-integration)  ;; Integrate with Which Key
         ((c-mode c++-mode c-ts-mode c++-ts-mode          ;; C/C++ via clangd; ESP-IDF overrides it locally.
           js-mode                                      ;; Enable LSP for JavaScript
           tsx-ts-mode                                  ;; Enable LSP for TSX
           typescript-ts-base-mode                      ;; Enable LSP for TypeScript
           css-mode                                     ;; Enable LSP for CSS
           go-ts-mode                                   ;; Enable LSP for Go
           js-ts-mode                                   ;; Enable LSP for JavaScript (TS mode)
           prisma-mode                                  ;; Enable LSP for Prisma
           python-base-mode                             ;; Enable LSP for Python
           ruby-base-mode                               ;; Enable LSP for Ruby
           rust-ts-mode                                 ;; Enable LSP for Rust
           web-mode) . lsp-deferred))                   ;; Enable LSP for Web (HTML)
  :commands lsp
  :init
  (setq lsp-clangd-version "23.1.0")
  :custom
  (lsp-keymap-prefix "C-c l")                           ;; Set the prefix for LSP commands.
  (lsp-inlay-hint-enable nil)                           ;; Usage of inlay hints.
  (lsp-completion-provider :none)                       ;; Disable the default completion provider.
  (lsp-session-file (locate-user-emacs-file ".lsp-session")) ;; Specify session file location.
  (lsp-log-io nil)                                      ;; Disable IO logging for speed.
  (lsp-idle-delay 0.5)                                  ;; Set the delay for LSP to 0 (debouncing).
  (lsp-keep-workspace-alive nil)                        ;; Disable keeping the workspace alive.
  ;; Core settings
  (lsp-enable-xref t)                                   ;; Enable cross-references.
  (lsp-auto-configure t)                                ;; Automatically configure LSP.
  (lsp-enable-links nil)                                ;; Disable links.
  (lsp-eldoc-enable-hover t)                            ;; Enable ElDoc hover.
  (lsp-enable-file-watchers nil)                        ;; Disable file watchers.
  (lsp-enable-folding nil)                              ;; Disable folding.
  (lsp-enable-imenu t)                                  ;; Enable Imenu support.
  (lsp-enable-indentation nil)                          ;; Disable indentation.
  (lsp-enable-on-type-formatting nil)                   ;; Disable on-type formatting.
  (lsp-enable-suggest-server-download t)                ;; Enable server download suggestion.
  (lsp-enable-symbol-highlighting t)                    ;; Enable symbol highlighting.
  (lsp-enable-text-document-color t)                    ;; Enable text document color.
  ;; Modeline settings
  (lsp-modeline-code-actions-enable nil)                ;; Keep modeline clean.
  (lsp-modeline-diagnostics-enable nil)                 ;; Use `flymake' instead.
  (lsp-modeline-workspace-status-enable t)              ;; Display "LSP" in the modeline when enabled.
  (lsp-signature-doc-lines 1)                           ;; Limit echo area to one line.
  (lsp-eldoc-render-all t)                              ;; Render all ElDoc messages.
  ;; Completion settings
  (lsp-completion-enable t)                             ;; Enable completion.
  (lsp-completion-enable-additional-text-edit t)        ;; Enable additional text edits for completions.
  (lsp-enable-snippet nil)                              ;; Disable snippets
  (lsp-completion-show-kind t)                          ;; Show kind in completions.
  ;; Lens settings
  (lsp-lens-enable t)                                   ;; Enable lens support.
  ;; Headerline settings
  (lsp-headerline-breadcrumb-enable-symbol-numbers t)   ;; Enable symbol numbers in the headerline.
  (lsp-headerline-arrow "▶")                            ;; Set arrow for headerline.
  (lsp-headerline-breadcrumb-enable-diagnostics nil)    ;; Disable diagnostics in headerline.
  (lsp-headerline-breadcrumb-icons-enable nil)          ;; Disable icons in breadcrumb.
  ;; Semantic settings
  (lsp-semantic-tokens-enable nil))                     ;; Disable semantic tokens.


;;; ESP-IDF
;; Use the existing Espressif tools only in ESP-IDF C/C++ projects.
(defgroup ek-esp-idf nil "ESP-IDF development." :group 'tools)

(defcustom ek/esp-idf-tools-directory (expand-file-name "~/.espressif/tools/")
  "Directory containing installed Espressif tool versions."
  :type 'directory :group 'ek-esp-idf)

(defcustom ek/esp-idf-activation-script
  (car (file-expand-wildcards
        (expand-file-name
         (if (eq system-type 'windows-nt)
             "activate_idf_*.ps1" "activate_idf_*.sh")
         ek/esp-idf-tools-directory)))
  "Activation script for the selected ESP-IDF installation.
Set this explicitly when using multiple SDK versions or a different location."
  :type '(choice (const nil) file) :group 'ek-esp-idf)

(defcustom ek/esp-idf-clangd nil
  "Espressif clangd executable, or nil to discover it in the tools directory."
  :type '(choice (const nil) file) :group 'ek-esp-idf)

(defun ek/esp-idf-project-root ()
  "Find the surrounding ESP-IDF project, without evaluating its files."
  (unless (file-remote-p default-directory)
    (locate-dominating-file
     default-directory
     (lambda (dir)
       (let ((cmake (expand-file-name "CMakeLists.txt" dir)))
         (and (file-readable-p cmake)
              (with-temp-buffer
                (insert-file-contents cmake)
                (goto-char (point-min))
                (search-forward "tools/cmake/project.cmake" nil t))))))))

(defun ek/esp-idf-find-clangd ()
  "Find an installed Espressif clangd executable."
  (or ek/esp-idf-clangd
      (let ((suffix (if (eq system-type 'windows-nt) ".exe" "")))
        (seq-find
         #'file-executable-p
         (append
          (file-expand-wildcards
           (expand-file-name (concat "esp-clangd/*/esp-clangd/bin/clangd" suffix)
                             ek/esp-idf-tools-directory))
          (file-expand-wildcards
           (expand-file-name (concat "esp-clang/*/esp-clang/bin/clangd" suffix)
                             ek/esp-idf-tools-directory)))))))

(defun ek/esp-idf-clangd-arguments (root binary)
  "Build clangd arguments for ROOT and the installed BINARY."
  (let* ((version (file-name-nondirectory
                   (directory-file-name
                    (expand-file-name "../.." (file-name-directory binary)))))
         (headers
          (car (append
                (file-expand-wildcards
                 (expand-file-name
                  (concat "esp-clang-libs/" version
                          "/esp-clang/lib/clang/*/include/stddef.h")
                  ek/esp-idf-tools-directory))
                (file-expand-wildcards
                 (expand-file-name "../lib/clang/*/include/stddef.h"
                                   (file-name-directory binary))))))
         (suffix (if (eq system-type 'windows-nt) ".exe" "")))
    (append
     (list "--background-index" "--header-insertion=never"
           (concat "--compile-commands-dir=" (expand-file-name "build" root))
           (concat "--query-driver="
                   (mapconcat
                    (lambda (name)
                      (expand-file-name (concat "**/bin/*-elf-" name suffix)
                                        ek/esp-idf-tools-directory))
                    '("gcc" "g++") ",")))
     (when headers
       (list (concat "--resource-dir="
                     (directory-file-name
                      (expand-file-name ".." (file-name-directory headers)))))))))

(defun ek/esp-idf-lsp-setup ()
  "Enable Espressif clangd for an ESP-IDF source buffer."
  (when-let* ((root (ek/esp-idf-project-root))
              (binary (ek/esp-idf-find-clangd)))
    (setq-local lsp-clients-clangd-executable binary
                lsp-clients-clangd-args (ek/esp-idf-clangd-arguments root binary)
                lsp-enabled-clients '(clangd))
    (unless (file-exists-p (expand-file-name "build/compile_commands.json" root))
      (message "ESP-IDF: run idf.py reconfigure in SPC o i before using code completion"))
    (lsp-deferred)))

(dolist (hook '(c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook))
  (add-hook hook #'ek/esp-idf-lsp-setup))

(defun ek/esp-idf-terminal ()
  "Open a Ghostel terminal with the selected ESP-IDF environment activated."
  (interactive)
  (let* ((default-directory
           (or (ek/esp-idf-project-root)
               (user-error "Open a file or directory in an ESP-IDF project first")))
         (script ek/esp-idf-activation-script))
    (unless (and script (file-readable-p script))
      (user-error "Set ek/esp-idf-activation-script to your ESP-IDF activation script"))
    (require 'ghostel)
    (let* ((windows (eq system-type 'windows-nt))
           (shell (if windows
                      (or (executable-find "pwsh") (executable-find "powershell"))
                    (executable-find "bash")))
           ;; Bash reads this script before its first prompt; PowerShell stays
           ;; in the same process so SDK functions and environment are retained.
           (ghostel-shell
            (if windows
                (list shell "-NoLogo" "-NoExit" "-Command"
                      (concat ". '" (replace-regexp-in-string "'" "''" script t t) "'"))
              (list shell "--rcfile" script "-i")))
           (ghostel-shell-integration nil))
      (unless shell (user-error "ESP-IDF terminal needs %s" (if windows "PowerShell" "Bash")))
      (ghostel-create "*ESP-IDF*" t))))


;;; LSP Additional Servers
;; You can extend `lsp-mode' by integrating additional language servers for specific
;; technologies. For example, `lsp-tailwindcss' provides support for Tailwind CSS
;; classes within your HTML files. By using various LSP packages, you can connect
;; multiple LSP servers simultaneously, enhancing your coding experience across
;; different languages and frameworks.
(use-package lsp-tailwindcss
  :ensure t
  :straight t
  :defer t
  :config
  (add-to-list 'lsp-language-id-configuration '(".*\\.erb$" . "html")) ;; Associate ERB files with HTML.
  :init
  (setq lsp-tailwindcss-add-on-mode t))


;;; ELDOC-BOX
;; eldoc-box enhances the default Eldoc experience by displaying documentation in a popup box,
;; usually in a child frame. This makes it easier to read longer docstrings without relying on
;; the minibuffer. It integrates seamlessly with Eldoc and activates when Eldoc is active.
;; Useful for graphical Emacs; terminal users may want to fall back to `eldoc-box-display-at-point-mode'.
(use-package eldoc-box
  :ensure t
  :straight t
  :defer t)


;;; DIFF-HL
;; The `diff-hl' package provides visual indicators for version control changes
;; directly in the margin of the buffer, showing lines added, deleted, or changed.
;; This is useful for tracking modifications while you edit files. When enabled,
;; it automatically activates in every buffer that has a corresponding version
;; control backend, offering a seamless experience.
;;
;; In comparison, Neovim users often rely on plugins like `gitsigns.nvim' or
;; `vim-signify', which provide similar functionalities by displaying Git
;; changes in the gutter and offer additional features like highlighting
;; changed lines and displaying blame information. `diff-hl' aims to provide
;; a comparable experience in Emacs with its own set of customizations.
(use-package diff-hl
  :defer t
  :straight t
  :ensure t
  :hook
  (find-file . (lambda ()
                 (global-diff-hl-mode)           ;; Enable Diff-HL mode for all files.
                 (diff-hl-flydiff-mode)          ;; Automatically refresh diffs.
                 (diff-hl-margin-mode)))         ;; Show diff indicators in the margin.
  :custom
  (diff-hl-side 'left)                           ;; Set the side for diff indicators.
  (diff-hl-margin-symbols-alist '((insert . "┃") ;; Customize symbols for each change type.
                                  (delete . "-")
                                  (change . "┃")
                                  (unknown . "┆")
                                  (ignored . "i"))))


;;; MAGIT
;; `magit' is a powerful Git interface for Emacs that provides a complete
;; set of features to manage Git repositories. With its intuitive interface,
;; you can easily stage, commit, branch, merge, and perform other Git
;; operations directly from Emacs. Magit’s powerful UI allows for a seamless
;; workflow, enabling you to visualize your repository's history and manage
;; changes efficiently.
;;
;; In the Neovim ecosystem, similar functionality is provided by plugins such as
;; `fugitive.vim', which offers a robust Git integration with commands that
;; allow you to perform Git operations directly within Neovim. Another popular
;; option is `neogit', which provides a more modern and user-friendly interface
;; for Git commands in Neovim, leveraging features like diff views and staging
;; changes in a visual format. Both of these plugins aim to replicate and
;; extend the powerful capabilities that Magit offers in Emacs.
(use-package magit
  :ensure t
  :straight t
  :config
  (if ek-use-nerd-fonts   ;; Check if nerd fonts are being used
	  (setopt magit-format-file-function #'magit-format-file-nerd-icons)) ;; Turns on magit nerd-icons
  :defer t)


;;; GHOSTEL
;; A full terminal for Linux and native Windows, including fullscreen apps.
(use-package ghostel
  :ensure nil
  :straight (:type git :host github :repo "dakra/ghostel"
             :files ("lisp/*.el" "etc" "src" "vendor"
                     "build.zig" "build.zig.zon" "symbols.map"))
  :commands (ghostel ghostel-project)
  :init
  (setq ghostel-module-directory (locate-user-emacs-file ".cache/ghostel/")
        ghostel-module-auto-install 'download)
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state 'ghostel-mode 'emacs))
  (when (eq system-type 'windows-nt)
    (setq ghostel-shell (or (executable-find "pwsh")
                            (executable-find "powershell")
                            (getenv "COMSPEC")
                            "cmd.exe"))))


;;; XCLIP
;; `xclip' is an Emacs package that integrates the X Window System clipboard
;; with Emacs. It allows seamless copying and pasting between Emacs and other
;; applications using the clipboard. When `xclip' is enabled, any text copied
;; in Emacs can be pasted in other applications, and vice versa, providing a
;; smooth workflow when working across multiple environments.
(use-package xclip
  ;; GUI Emacs (including Windows) uses its native clipboard integration.
  :if (and (eq system-type 'gnu/linux) (not (display-graphic-p)))
  :ensure t
  :straight t
  :defer t
  :hook
  (after-init . xclip-mode))     ;; Enable xclip mode after initialization.


;;; INDENT-GUIDE
;; The `indent-guide' package provides visual indicators for indentation levels
;; in programming modes, making it easier to see code structure at a glance.
;; It draws vertical lines (by default, a character of your choice) at each
;; level of indentation, helping to improve readability and navigation within
;; the code.
(use-package indent-guide
  :defer t
  :straight t
  :ensure t
  :hook
  (prog-mode . indent-guide-mode)  ;; Activate indent-guide in programming modes.
  :config
  (setq indent-guide-char "│"))    ;; Set the character used for the indent guide.


;;; ADD-NODE-MODULES-PATH
;; The `add-node-modules-path' package ensures that Emacs uses the local
;; `node_modules/.bin' for a project rather than globally installed binaries.
;; This is essential in JavaScript/TypeScript projects where different versions
;; of tools like `eslint' and `typescript-language-server' might be needed
;; per project.
;;
;; This setup helps prevent conflicts between global and local versions of
;; Node.js tools and ensures consistency across different environments.
;;
;; Example in the wild: This is an example of a real-world issue often faced
;; by developers using modern tech stacks. When working on multiple projects
;; with different dependencies, Emacs must use the correct local versions
;; instead of relying on globally installed packages. This configuration
;; ensures that the environment is accurate and project-specific tools are
;; properly utilized.
(use-package add-node-modules-path
  :ensure t
  :straight t
  :defer t
  :custom
  ;; Makes sure you are using the local bin for your
  ;; node project. Local eslint, typescript server...
  (eval-after-load 'typescript-ts-mode
    '(add-hook 'typescript-ts-mode-hook #'add-node-modules-path))
  (eval-after-load 'tsx-ts-mode
    '(add-hook 'tsx-ts-mode-hook #'add-node-modules-path))
  (eval-after-load 'typescriptreact-mode
    '(add-hook 'typescriptreact-mode-hook #'add-node-modules-path))
  (eval-after-load 'js-mode
    '(add-hook 'js-mode-hook #'add-node-modules-path)))


;; EVIL
;; The `evil' package provides Vim emulation within Emacs, allowing
;; users to edit text in a modal way, similar to how Vim
;; operates. This setup configures `evil-mode' to enhance the editing
;; experience.
(use-package evil
  :ensure t
  :straight t
  :defer t
  :hook
  (after-init . evil-mode)
  :init
  (setq evil-want-integration t)      ;; Integrate `evil' with other Emacs features (optional as it's true by default).
  (setq evil-want-keybinding nil)     ;; Disable default keybinding to set custom ones.
  (setq evil-want-C-u-scroll t)       ;; Makes C-u scroll
  (setq evil-want-C-u-delete t)       ;; Makes C-u delete on insert mode
  :config
  (evil-set-undo-system 'undo-tree)   ;; Uses the undo-tree package as the default undo system

  ;; Set the leader key to space for easier access to custom commands. (setq evil-want-leader t)
  (setq evil-leader/in-all-states t)  ;; Make the leader key available in all states.
  (setq evil-want-fine-undo t)        ;; Evil uses finer grain undoing steps

  ;; Define the leader key as Space
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))

  ;; Trigger completion in insert state, including terminals that send C-@.
  (evil-define-key 'insert 'global (kbd "C-SPC") #'completion-at-point)
  (evil-define-key 'insert 'global (kbd "C-@") #'completion-at-point)

  ;; Search layout: frequent searches directly under Space, others under s.
  (evil-define-key 'normal 'global
    (kbd "<leader> f") #'consult-fd
    (kbd "<leader> g") #'consult-ripgrep
    (kbd "<leader> G") #'magit-log-all
    (kbd "<leader> s g") #'ek/find-files-no-ignore
    (kbd "<leader> s b") #'consult-buffer
    (kbd "<leader> s i") #'ek/search-word-at-point
    (kbd "<leader> s I") #'ek/search-WORD-at-point
    (kbd "<leader> s o") #'consult-recent-file
    (kbd "<leader> s h") #'consult-info
    (kbd "<leader> s m") #'consult-man
    (kbd "<leader> s d") #'consult-flymake
    (kbd "<leader> s s") #'consult-line
    (kbd "<leader> s t") #'ek/search-menu
    (kbd "<leader> s k") #'embark-bindings
    (kbd "<leader> s e") #'ek/search-environment)
  (evil-define-key 'normal 'global (kbd "<leader> s c") #'cheat-sh)

  ;; Open EWW's prompt for a web search or URL.
  (evil-define-key 'normal 'global (kbd "<leader> w w") #'eww)

  ;; Flymake navigation
  (evil-define-key 'normal 'global (kbd "<leader> e n") #'flymake-goto-next-error)
  (evil-define-key 'normal 'global (kbd "<leader> e p") #'flymake-goto-prev-error)

  ;; Dired commands for file management
  (evil-define-key 'normal 'global (kbd "<leader> x d") 'dired)
  (evil-define-key 'normal 'global (kbd "<leader> x j") 'dired-jump)
  (evil-define-key 'normal 'global (kbd "<leader> x f") 'find-file)

  ;; Diff-HL navigation for version control
  (evil-define-key 'normal 'global (kbd "] c") 'diff-hl-next-hunk) ;; Next diff hunk
  (evil-define-key 'normal 'global (kbd "[ c") 'diff-hl-previous-hunk) ;; Previous diff hunk

  ;; NeoTree command for file exploration
  (evil-define-key 'normal 'global (kbd "<leader> e e") 'neotree-toggle)
  (evil-define-key 'normal 'global (kbd "<leader> e d") 'dired-jump)
  (evil-define-key 'normal 'global (kbd "<leader> e o") #'ek/open-externally)

  ;; Terminal in the current directory or project root.
  (evil-define-key 'normal 'global (kbd "<leader> o t") #'ghostel)
  (evil-define-key 'normal 'global (kbd "<leader> o p") #'ghostel-project)
  (evil-define-key 'normal 'global (kbd "<leader> o i") #'ek/esp-idf-terminal)
  (evil-define-key 'normal 'global (kbd "<leader> o m") #'gnus)
  (evil-define-key 'normal 'global (kbd "<leader> o a") #'org-agenda-list)
  (evil-define-key 'normal 'global (kbd "<leader> o c") #'org-capture)
  (evil-define-key 'normal 'global (kbd "<leader> o r") #'elfeed)
  (evil-define-key 'normal 'global (kbd "<leader> o s") #'ek/music)

  (evil-define-key 'normal 'global (kbd "<leader> o b") #'ek/find-books)

  ;; Tabs preserve separate window layouts.
  (evil-define-key 'normal 'global
    (kbd "<leader> t n") #'tab-new
    (kbd "<leader> t l") #'tab-next
    (kbd "<leader> t h") #'tab-previous
    (kbd "<leader> t c") #'tab-close
    (kbd "<leader> t r") #'tab-rename)

  ;; Git operations moved to v g because Space g now searches text.
  (evil-define-key 'normal 'global (kbd "<leader> v g g") 'magit-status)      ;; Open Magit status
  (evil-define-key 'normal 'global (kbd "<leader> v g l") 'magit-log-current) ;; Show current log
  (evil-define-key 'normal 'global (kbd "<leader> v g d") 'magit-diff-buffer-file) ;; Show diff for the current file
  (evil-define-key 'normal 'global (kbd "<leader> v g D") 'diff-hl-show-hunk) ;; Show diff for a hunk
  (evil-define-key 'normal 'global (kbd "<leader> v g b") 'vc-annotate)       ;; Annotate buffer with version control info

  ;; Buffer management keybindings
  (evil-define-key 'normal 'global (kbd "] b") 'switch-to-next-buffer) ;; Switch to next buffer
  (evil-define-key 'normal 'global (kbd "[ b") 'switch-to-prev-buffer) ;; Switch to previous buffer
  (evil-define-key 'normal 'global (kbd "<leader> b i") 'consult-buffer) ;; Open consult buffer list
  (evil-define-key 'normal 'global (kbd "<leader> b b") 'ibuffer) ;; Open Ibuffer
  (evil-define-key 'normal 'global (kbd "<leader> b d") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b k") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b x") 'kill-current-buffer) ;; Kill current buffer
  (evil-define-key 'normal 'global (kbd "<leader> b s") 'save-buffer) ;; Save buffer
  (evil-define-key 'normal 'global (kbd "<leader> b l") 'consult-buffer) ;; Consult buffer
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'consult-buffer) ;; Consult buffer

  ;; Project management keybindings
  (evil-define-key 'normal 'global (kbd "<leader> p b") 'consult-project-buffer) ;; Consult project buffer
  (evil-define-key 'normal 'global (kbd "<leader> p p") 'project-switch-project) ;; Switch project
  (evil-define-key 'normal 'global (kbd "C-p") #'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader> p g") 'project-find-regexp) ;; Find regexp in project
  (evil-define-key 'normal 'global (kbd "<leader> p k") 'project-kill-buffers) ;; Kill project buffers
  (evil-define-key 'normal 'global (kbd "<leader> p D") 'project-dired) ;; Dired for project

  ;; Yank from kill ring
  (evil-define-key 'normal 'global (kbd "P") 'consult-yank-from-kill-ring)
  (evil-define-key 'normal 'global (kbd "<leader> P") 'consult-yank-from-kill-ring)

  ;; Embark actions for contextual commands
  (evil-define-key 'normal 'global (kbd "<leader> .") 'embark-act)

  ;; Undo tree visualization
  (evil-define-key 'normal 'global (kbd "<leader> u") 'undo-tree-visualize)

  ;; Help keybindings
  (evil-define-key 'normal 'global (kbd "<leader> h m") 'describe-mode) ;; Describe current mode
  (evil-define-key 'normal 'global (kbd "<leader> h f") 'describe-function) ;; Describe function
  (evil-define-key 'normal 'global (kbd "<leader> h v") 'describe-variable) ;; Describe variable
  (evil-define-key 'normal 'global (kbd "<leader> h k") 'describe-key) ;; Describe key

  ;; Tab navigation
  (evil-define-key 'normal 'global (kbd "] t") 'tab-next) ;; Go to next tab
  (evil-define-key 'normal 'global (kbd "[ t") 'tab-previous) ;; Go to previous tab


  ;; Custom example. Formatting with prettier tool.
  (evil-define-key 'normal 'global (kbd "<leader> m p")
                   (lambda ()
                     (interactive)
                     (shell-command (concat "prettier --write " (shell-quote-argument (buffer-file-name))))
                     (revert-buffer t t t)))

  ;; LSP commands keybindings
  (evil-define-key 'normal lsp-mode-map
                   (kbd "gd") 'lsp-find-definition
                   (kbd "<leader> s T") #'lsp-find-type-definition
                   (kbd "<leader> w s") 'xref-find-apropos          ;; LSP workspace symbol search
                   (kbd "<leader> s r") 'lsp-find-references
                   (kbd "<leader> s a") 'lsp-execute-code-action     ;; Execute code actions
                   (kbd "<leader> v r n") 'lsp-rename                ;; Rename symbol
                   (kbd "gI") 'lsp-find-implementation               ;; Find implementation
                   (kbd "<leader> l f") 'lsp-format-buffer)          ;; Format buffer via lsp

  (evil-define-key 'insert lsp-mode-map (kbd "C-h") #'lsp-signature-activate)


  (defun ek/lsp-describe-and-jump ()
    "Show hover documentation and jump to *lsp-help* buffer."
    (interactive)
    (lsp-describe-thing-at-point)
    (let ((help-buffer "*lsp-help*"))
      (when (get-buffer help-buffer)
        (switch-to-buffer-other-window help-buffer))))

  ;; Emacs 31 finaly brings us support for 'floating windows' (a.k.a. "child frames")
  ;; to terminal Emacs. If you're still using 30, docs will be shown in a buffer at the
  ;; inferior part of your frame.
  (evil-define-key 'normal lsp-mode-map (kbd "K")
    (if (>= emacs-major-version 31)
        #'eldoc-box-help-at-point
        #'ek/lsp-describe-and-jump))

  ;; Commenting functionality for single and multiple lines
  (evil-define-key 'normal 'global (kbd "gcc")
                   (lambda ()
                     (interactive)
                     (if (not (use-region-p))
                         (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

  (evil-define-key 'visual 'global (kbd "gc")
                   (lambda ()
                     (interactive)
                     (if (use-region-p)
                         (comment-or-uncomment-region (region-beginning) (region-end)))))

  ;; Enable evil mode
  (evil-mode 1))


;; EVIL COLLECTION
;; The `evil-collection' package enhances the integration of
;; `evil-mode' with various built-in and third-party packages. It
;; provides a better modal experience by remapping keybindings and
;; commands to fit the `evil' style.
(use-package evil-collection
  :defer t
  :straight t
  :ensure t
  :custom
  (evil-collection-want-find-usages-bindings t)
  :init
  (defun ek/eww-preserve-leader (mode &rest _)
    "Keep the global Space leader available after EWW bindings are installed."
    (when (eq mode 'eww)
      (evil-define-key 'normal eww-mode-map (kbd "SPC") nil)))
  (add-hook 'evil-collection-setup-hook #'ek/eww-preserve-leader)
  ;; Hook to initialize `evil-collection' when `evil-mode' is activated.
  :hook
  (evil-mode . evil-collection-init))


;; EVIL SURROUND
;; The `evil-surround' package provides text object surround
;; functionality for `evil-mode'. This allows for easily adding,
;; changing, or deleting surrounding characters such as parentheses,
;; quotes, and more.
;;
;; With this you can change 'hello there' with ci'" to have
;; "hello there" and cs"<p> to get <p>hello there</p>.
;; More examples here:
;; - https://github.com/emacs-evil/evil-surround?tab=readme-ov-file#examples
(use-package evil-surround
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-surround-mode 1))


;; EVIL MATCHIT
;; The `evil-matchit' package extends `evil-mode' by enabling
;; text object matching for structures such as parentheses, HTML
;; tags, and other paired delimiters. This makes it easier to
;; navigate and manipulate code blocks.
;; Just use % for jumping between matching structures to check it out.
(use-package evil-matchit
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-matchit-mode 1))


;; UNDO TREE
;; The `undo-tree' package provides an advanced and visual way to
;; manage undo history. It allows you to navigate and visualize your
;; undo history as a tree structure, making it easier to manage
;; changes in your buffers.
(use-package undo-tree
  :defer t
  :ensure t
  :straight t
  :hook
  (after-init . global-undo-tree-mode)
  :init
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t
        ;; Increase undo limits to avoid losing history due to Emacs' garbage collection.
        ;; These values can be adjusted based on your needs.
        ;; 10X bump of the undo limits to avoid issues with premature
        ;; Emacs GC which truncates the undo history very aggressively.
        undo-limit 800000                     ;; Limit for undo entries.
        undo-strong-limit 12000000            ;; Strong limit for undo entries.
        undo-outer-limit 120000000)           ;; Outer limit for undo entries.
  :config
  ;; Set the directory where `undo-tree' will save its history files.
  ;; This keeps undo history across sessions, stored in a cache directory.
  ;; Keep the cache in the active config directory.  Creating ~/.emacs.d
  ;; would make Emacs ignore a config installed in ~/.config/emacs.
  (setq undo-tree-history-directory-alist
        `(("." . ,(locate-user-emacs-file ".cache/undo")))))


;;; RAINBOW DELIMITERS
;; The `rainbow-delimiters' package provides colorful parentheses, brackets, and braces
;; to enhance readability in programming modes. Each level of nested delimiter is assigned
;; a different color, making it easier to match pairs visually.
(use-package rainbow-delimiters
  :defer t
  :straight t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))


;;; DOTENV
;; A simple major mode to provide .env files with color highlighting
(use-package dotenv-mode
  :defer t
  :straight t
  :ensure t
  :config)


;;; PULSAR
;; The `pulsar' package enhances the user experience in Emacs by providing
;; visual feedback through pulsating highlights. This feature is especially
;; useful in programming modes, where it can help users easily track
;; actions such as scrolling, error navigation, yanking, deleting, and
;; jumping to definitions.
(use-package pulsar
  :defer t
  :straight t
  :ensure t
  :hook
  (after-init . pulsar-global-mode)
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.025)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'evil-ex-lazy-highlight)

  (add-to-list 'pulsar-pulse-functions 'evil-scroll-down)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-next-error)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-prev-error)
  (add-to-list 'pulsar-pulse-functions 'evil-yank)
  (add-to-list 'pulsar-pulse-functions 'evil-yank-line)
  (add-to-list 'pulsar-pulse-functions 'evil-delete)
  (add-to-list 'pulsar-pulse-functions 'evil-delete-line)
  (add-to-list 'pulsar-pulse-functions 'evil-jump-item)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-next-hunk)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-previous-hunk))


;;; DOOM MODELINE
;; The `doom-modeline' package provides a sleek, modern mode-line that is visually appealing
;; and functional. It integrates well with various Emacs features, enhancing the overall user
;; experience by displaying relevant information in a compact format.
(use-package doom-modeline
  :ensure t
  :straight t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)  ;; Set the buffer file name style to just the buffer name (without path).
  (doom-modeline-project-detection 'project)           ;; Enable project detection for displaying the project name.
  (doom-modeline-buffer-name t)                        ;; Show the buffer name in the mode line.
  (doom-modeline-vcs-max-length 25)                    ;; Limit the version control system (VCS) branch name length to 25 characters.
  :config
  (if ek-use-nerd-fonts                                ;; Check if nerd fonts are being used.
      (setq doom-modeline-icon t)                      ;; Enable icons in the mode line if nerd fonts are used.
    (setq doom-modeline-icon nil))                     ;; Disable icons if nerd fonts are not being used.
  :hook
  (after-init . doom-modeline-mode))


;;; NEOTREE
;; The `neotree' package provides a file tree explorer for Emacs, allowing easy navigation
;; through directories and files. It presents a visual representation of the file system
;; and integrates with version control to show file states.
(use-package neotree
  :ensure t
  :straight t
  :custom
  (neo-show-hidden-files t)                ;; By default shows hidden files (toggle with H)
  (neo-theme 'nerd)                        ;; Set the default theme for Neotree to 'nerd' for a visually appealing look.
  (neo-vc-integration '(face char))        ;; Enable VC integration to display file states with faces (color coding) and characters (icons).
  :defer t                                 ;; Load the package only when needed to improve startup time.
  :config
  (if ek-use-nerd-fonts                    ;; Check if nerd fonts are being used.
      (setq neo-theme 'nerd-icons)         ;; Set the theme to 'nerd-icons' if nerd fonts are available.
    (setq neo-theme 'nerd)))               ;; Otherwise, fall back to the 'nerd' theme.


;;; NERD ICONS
;; The `nerd-icons' package provides a set of icons for use in Emacs. These icons can
;; enhance the visual appearance of various modes and packages, making it easier to
;; distinguish between different file types and functionalities.
(use-package nerd-icons
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :straight t
  :defer t)                               ;; Load the package only when needed to improve startup time.


;;; NERD ICONS Dired
;; The `nerd-icons-dired' package integrates nerd icons into the Dired mode,
;; providing visual icons for files and directories. This enhances the Dired
;; interface by making it easier to identify file types at a glance.
(use-package nerd-icons-dired
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :straight t
  :defer t                                ;; Load the package only when needed to improve startup time.
  :hook
  (dired-mode . nerd-icons-dired-mode))


;;; NERD ICONS COMPLETION
;; The `nerd-icons-completion' package enhances the completion interfaces in
;; Emacs by integrating nerd icons with completion frameworks such as
;; `marginalia'. This provides visual cues for the completion candidates,
;; making it easier to distinguish between different types of items.
(use-package nerd-icons-completion
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :straight t
  :after (:all nerd-icons marginalia)     ;; Load after `nerd-icons' and `marginalia' to ensure proper integration.
  :config
  (nerd-icons-completion-mode)            ;; Activate nerd icons for completion interfaces.
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)) ;; Setup icons in the marginalia mode for enhanced completion display.


;;; GRUBER DARKER THEME
(use-package gruber-darker-theme
  :ensure nil
  :straight t
  :demand t
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'gruber-darker t)
  (set-face-attribute 'default nil :background "#000000"))


;;; UTILITARY FUNCTION TO INSTALL EMACS-KICK
(defun ek/first-install ()
  "Install tree-sitter grammars and compile packages on first run..."
  (interactive)                                      ;; Allow this function to be called interactively.
  (switch-to-buffer "*Messages*")                    ;; Switch to the *Messages* buffer to display installation messages.
  (message ">>> All required packages installed.")
  (message ">>> Configuring Emacs-Kick...")
  (message ">>> Configuring Tree Sitter parsers...")
  (require 'treesit-auto)
  (treesit-auto-install-all)                         ;; Install all available Tree Sitter grammars.
  (message ">>> Configuring Nerd Fonts...")
  (require 'nerd-icons)
  (nerd-icons-install-fonts)                         ;; Install all available nerd-fonts
  (message ">>> Emacs-Kick installed! Press any key to close the installer and open Emacs normally. First boot will compile some extra stuff :)")
  (read-key)                                         ;; Wait for the user to press any key.
  (kill-emacs))                                      ;; Close Emacs after installation is complete.

(provide 'init)
;;; init.el ends here
