; Requires
(require 'package)
(require 'org-tempo)

; Meta
(set-face-attribute 'default nil :font "Monospace" :height 250)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(load-file (expand-file-name "lisp/window.el" user-emacs-directory))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq
 inhibit-startup-screen t
 ring-bell-function 'ignore
 make-backup-files nil
 use-package-always-ensure t)

(load-theme 'tango-dark)

; Modes
(menu-bar-mode -1)
(display-battery-mode 1)
(display-time-mode 1)
(column-number-mode)
(global-display-line-numbers-mode t)

; Hooks
(add-hook 'emacs-startup-hook #'my-default-window-setup)

(add-hook 'shell-mode-hook
	  (lambda()
	    (define-key shell-mode-map "\C-l"
	      'comint-clear-buffer)))

(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

(add-hook 'prog-mode-hook (lambda()
			    (whitespace-mode 0)
			    (setq-default show-trailing-whitespace t)
			    (setq whitespace-line-column 80
				  whitespace-style '(face lines)
				  tab-face (make-face 'lines-face))
			    (set-face-foreground 'lines-face "white")
			    (set-face-background 'lines-face "red")
			    (setq whitespace-line 'lines-face)
			    (whitespace-mode 1)))

(dolist (mode '(shell-mode-hook ielm-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

; Packages
(use-package yasnippet
	     :defer 15
	     :diminish yas-minor-mode
	     :config (yas-global-mode)
	     :custom (yas-prompt-functions '(yas-completing-prompt)))

(use-package go-mode
	     :defer t
	     :config
	     (add-hook 'before-save-hook #'gofmt-before-save))

(use-package rust-mode
	     :defer t
	     :custom
	     (rust-format-on-save t)
	     (lsp-rust-server 'rust-analyzer))

(use-package bazel
	     :defer t
	     :config
	     (add-hook 'bazel-mode-hook
		       (lambda()
			 (add-hook 'before-save-hook #'bazel-mode-buildifier nil t))))

(mapc 'load (file-expand-wildcards "~/.emacs.d/lisp/protobuf-fn/*.el"))
(defconst protobuf-ident-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(use-package protobuf-mode
	     :defer t
	     :config
	     (add-hook 'protobuf-mode-hook
		       (lambda()
			 (c-add-style "ident-style" protobuf-ident-style t)
			 (setq compile-command "protoc "))))

(use-package nix-mode :defer t)
(use-package yaml-mode :defer t)
(use-package dockerfile-mode :defer t)
(use-package toml-mode :defer t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(toml-mode yaml-mode use-package yasnippet rust-mode protobuf-mode org nix-mode magit lsp-mode go-mode exwm dockerfile-mode docker bazel all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
