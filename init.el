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
(use-package diminish)
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
    	     (setq evil-want-keybinding nil)
             :config
             (evil-mode 1)
             (setq evil-emacs-state-modes nil)
             (setq evil-insert-state-modes nil)
             (setq evil-motion-state-modes nil))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))


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

(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :init (ivy-mode 1)
  :config
  ;(setq ivy-use-virtual-buffers t)
  ;(setq ivy-height 20)
  ;(setq ivy-count-format "(%d/%d) ")
)

(use-package counsel :ensure t)

;; Which Key
(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :config
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :diminish which-key-mode)


(use-package general
  :ensure t
  :config 
  (general-evil-setup t)
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
   :states '(normal visual motion emacs)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "C-SPC"
   "" nil
   ;; "/" '(counsel-rg :which-key "riggrep") ; need counsel
   "SPC" '(counsel-M-x :which-key "M-x")
   ;"pf"  '(helm-find-files :which-key "find files")
   ;; Buffers
   "b"   '(:ignore t :which-key "buffers")
   "bx"  '(kill-buffer-and-window :which-key "kill buffer / window")
   "bb"  '(ivy-switch-buffer :which-key "switch buffer")
   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
   ;; Window
   "w"   '(:ignore t :which-key "window")
   "w/"  '(split-window-right :which-key "split right")
   "w-"  '(split-window-below :which-key "split below")
   "wx"  '(delete-window :which-key "delete window")
   ;; Git
   "g"   '(:ignore t :which-key "git")
   "gg"  '(magit-status :which-key "status")
   "gs"  '(magit-stage :which-key "stage")
   "gu"  '(magit-unstage :which-key "unstage")
   "gc"  '(magit-commit :which-key "commit")
   "gd"  '(magit-diff :which-key "diff")
   "gl"  '(magit-log :which-key "log")
   "gb"  '(magit-blame :which-key "blame")
   "gp"  '(magit-push-to-remote :which-key "push")
   "gP"  '(magit-pull :which-key "pull")
   "gf"  '(magit-fetch :which-key "fetch")
   ;"gn"  '(magit-blob-next :which-key "next blob")
   ;"gp"  '(magit-blob-previous :which-key "prev blob")
   ;; Avy
   "a"   '(:ignore t :which-key "avy")
   "al"  '(evil-avy-goto-line :which-key "goto-line")
   "ac"  '(evil-avy-goto-char :which-key "goto-char")
   ;; Other
   "o"   '(:ignore t :which-key "org")
   "oc"  '(counsel-org-capture :which-key "org-capture")
   "of"  '(counsel-org-capture-finalize :which-key "org-capture-finalize")
   "e"  '(eval-buffer :which-key "eval-buffer")
   "p"  '(treemacs :which-key "treemacs")
   ;"ot"  '(ansi-term :which-key "open terminal"))
   )
)

(use-package org
  :ensure org-plus-contrib)

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/notes/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("R" "Reminder" entry
                               (file+headline "~/notes/reminder.org" "Reminder")
                               "* %i%? \n %U")))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

; Overwrite some evil-org keys
(define-key evil-motion-state-map  (kbd "C-h") #'evil-window-left)
(define-key evil-motion-state-map  (kbd "C-j") #'evil-window-down)
(define-key evil-motion-state-map  (kbd "C-k") #'evil-window-up)
(define-key evil-motion-state-map  (kbd "C-l") #'evil-window-right)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-plus-contrib ox-taskjuggler evil-collection which-key use-package treemacs-evil smooth-scrolling org-bullets magit graphviz-dot-mode general doom-themes diminish counsel alchemist))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
