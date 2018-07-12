(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

; Package definitions
(use-package all-the-icons
  :defer t)

(use-package doom-themes
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
	     (evil-mode 1))
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


; configuration
;(evil-leader/set-key-for-mode 'org-mode
;                              "oI" 'org-display-inline-images)
(setq my-preferred-font
      (cond ((eq system-type 'windows-nt) "Source Code Variable-10")
            ((eq system-type 'gnu/linux) "SourceCodePro-10")
            (t nil)))

(when my-preferred-font
  (set-frame-font my-preferred-font nil t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "b4c13d25b1f9f66eb769e05889ee000f89d64b089f96851b6da643cee4fdab08" "a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" default)))
 '(package-selected-packages (quote (doom-themes evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
