;;; Personal configuration -*- lexical-binding: t -*-

;; Save the contents of this file under ~/.emacs.d/init.el
;; Do not forget to use Emacs' built-in help system:
;; Use C-h C-h to get an overview of all help commands.  All you
;; need to know about Emacs (what commands exist, what functions do,
;; what variables specify), the help system can provide.

;; Add the NonGNU ELPA package archive
(require 'package)
(add-to-list 'package-archives  '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

;; Load a custom theme
(load-theme 'misterioso t)

;; Set default font face
(set-face-attribute 'default nil :font "14")

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bars
(scroll-bar-mode -1)

;; Disable splash screen
(setq inhibit-startup-screen t)

;;; Completion framework
(unless (package-installed-p 'vertico)
  (package-install 'vertico))

;; Enable completion by narrowing
(vertico-mode t)

;; Improve directory navigation
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "RET") #'vertico-directory-enter)
  (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-word)
  (define-key vertico-map (kbd "M-d") #'vertico-directory-delete-char))

;;; Extended completion utilities
(unless (package-installed-p 'consult)
  (package-install 'consult))
(global-set-key [rebind switch-to-buffer] #'consult-buffer)
(global-set-key (kbd "C-c j") #'consult-line)
(global-set-key (kbd "C-c i") #'consult-imenu)
(setq read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t
      completion-ignore-case t)

;; Enable line numbering in `prog-mode'
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Automatically pair parentheses
(electric-pair-mode t)

;;; LSP Support
(unless (package-installed-p 'eglot)
  (package-install 'eglot))

;; Enable LSP support by default in programming buffers
(add-hook 'prog-mode-hook #'eglot-ensure)

;;; Inline static analysis

;; Enabled inline static analysis
(add-hook 'prog-mode-hook #'flymake-mode)

;; Message navigation bindings
(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "C-c n") #'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "C-c p") #'flymake-goto-prev-error))

;;; Pop-up auto-completion
(unless (package-installed-p 'company)
  (package-install 'company))

;; Enable Company by default in programming buffers
(add-hook 'prog-mode-hook #'company-mode)

;;; Git client
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; Bind the `magit-status' command to a convenient key.
(global-set-key (kbd "C-c g") #'magit-status)

;; Show word-granularity differences within diff hunks
(setq magit-diff-refine-hunk t)

;;; Indication of local VCS changes
(unless (package-installed-p 'diff-hl)
  (package-install 'diff-hl))

;; Enable `diff-hl' support by default in programming buffers
(add-hook 'prog-mode-hook #'diff-hl-mode)

;;; Go Support
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))

;;; JSON Support
(unless (package-installed-p 'json-mode)
  (package-install 'json-mode))

;;; Lua Support
(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))

;;; Rust Support
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))

;;; Typescript Support
(unless (package-installed-p 'typescript-mode)
  (package-install 'typescript-mode))

;;; YAML Support
(unless (package-installed-p 'yaml-mode)
  (package-install 'yaml-mode))

;;; Markdown support
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

;;; Outline-based notes management and organizer
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)

;;; Additional Org-mode related functionality
(unless (package-installed-p 'org-contrib)
  (package-install 'org-contrib))

;;; EditorConfig support
(unless (package-installed-p 'editorconfig)
  (package-install 'editorconfig))

;; Enable EditorConfig
(editorconfig-mode t)

;;; Jump to arbitrary positions
(unless (package-installed-p 'avy)
  (package-install 'avy))
(global-set-key (kbd "C-c z") #'avy-goto-word-1)

;;; Vim Emulation
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Miscellaneous options
(setq-default major-mode
              (lambda () ; guess major mode from file name
                (unless buffer-file-name
                  (let ((buffer-file-name (buffer-name)))
                    (set-auto-mode)))))
(setq confirm-kill-emacs #'yes-or-no-p)
(setq window-resize-pixelwise t)
(setq frame-resize-pixelwise t)
(save-place-mode t)
(savehist-mode t)
(recentf-mode t)
(defalias 'yes-or-no #'y-or-n-p)

;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))