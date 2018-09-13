;; Disable ugly elements
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Set up 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

; Package definitions
(use-package all-the-icons
  :defer t)

(use-package doom-themes
  :ensure t
  :defer t
  :init (load-theme 'doom-one t))

(use-package evil
             :init
             (setq evil-search-module 'evil-search)
             (setq evil-ex-complete-emacs-commands nil)
             (setq evil-ex-complete-emacs-commands nil)
             (setq evil-vsplit-window-right t)
             (setq evil-split-window-below t)
             (setq evil-shift-round nil)
             (setq evil-want-C-u-scroll t)
             :config
             (evil-mode 1)
             (setq evil-emacs-state-modes nil)
             (setq evil-insert-state-modes nil)
             (setq evil-motion-state-modes nil))
;             (use-package evil-leader
;	       :config
;	       (setq evil-leader/in-all-states t)
;	       (evil-leader/set-leader " ")
;	       (global-evil-leader-mode)))


(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))

(use-package graphviz-dot-mode)

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package magit)

(use-package alchemist
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-mode))
  (add-to-list 'auto-mode-alist '("\\.exs\\'" . elixir-mode))
  (add-to-list 'auto-mode-alist '("\\.eex\\'" . elixir-mode)))

(use-package company
  :defer t
  :init (global-company-mode)
  :config
  (progn
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
	  company-show-numbers t)
    (setq company-dabbrev-downcase nil)))

(use-package treemacs)
(use-package treemacs-evil)

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

(use-package general
  :ensure t
  :config 
  (setq general-override-states '(insert
                                  emacs
                                  hybrid
                                  normal
                                  visual
                                  motion
                                  operator
                                  replace))
  (general-override-mode)
  (general-define-key
    :states '(normal visual motion)
    :keymaps 'override
    "SPC" 'hydra-space/body))
  
;  (general-define-key
;            :states '(normal visual insert emacs)
;            :prefix "SPC"
;            :non-normal-prefix "M-SPC"
;            ;; "/" '(counsel-rg :which-key "riggrep") ; need counsel
;            "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
;            "SPC" '(helm-M-x :which-key "M-x")
;            "pf"  '(helm-find-files :which-key "find files")
;            ;; Buffers
;            "bb"  '(helm-buffers-list :which-key "buffers list")
;            ;; Window
;            "wl"  '(windmove-right :which-key "move right")
;            "wh"  '(windmove-left :which-key "move left")
;            "wj"  '(windmove-down :which-key "move down")
;            "wk"  '(windmove-up :which-key "move up")
;            "w/"  '(split-window-right :which-key "split right")
;            "w-"  '(split-window-below :which-key "split below")
;            "wx"  '(delete-window :which-key "delete window")
;            ;; Others
;            "ot"  '(ansi-term :which-key "open terminal"))
;  (general-define-key
;    :states '(normal visual insert emacs)
;)

; configuration
;(evil-leader/set-key-for-mode 'org-mode
;                              "oI" 'org-display-inline-images)
(setq my-preferred-font
      (cond ((eq system-type 'windows-nt) "Source Code Variable-10")
            ((eq system-type 'gnu/linux) "SourceCodePro-10")
            (t nil)))

(when my-preferred-font
  (set-frame-font my-preferred-font nil t))

(setq tab-width 4)
(setq indent-tabs-mode nil)
(setq show-paren-delay 0)
(show-paren-mode 1)
(setq show-paren-priority -50)
(set-face-attribute 'show-paren-match nil :weight 'normal :foreground "tomato3" :background "default")
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

