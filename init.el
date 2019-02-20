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
             (setq evil-motion-state-modes nil)
             ; Make movement keys work like they should
             (define-key evil-normal-state-map (kbd "<remap> <evil-next-line") 'evil-next-visual-line)
             (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line") 'evil-previous-visual-line)
             ; Make horizontal movement cross lines
             (setq-default evil-cross-lines t)
             )
        

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

(use-package magit)

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1)
  (setq git-gutter:update-interval 2)
  (setq git-gutter:ask-p nil))

(use-package git-timemachine
  :ensure t)

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package elixir-mode
  :defer t)

(use-package alchemist
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-mode))
  (add-to-list 'auto-mode-alist '("\\.exs\\'" . elixir-mode))
  (add-to-list 'auto-mode-alist '("\\.eex\\'" . elixir-mode))
  (setq alchemist-goto-elixir-source-dir "~/src/elixir"))

(use-package company
  :defer t
  :init (global-company-mode)
  :config
  (progn
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
	  company-show-numbers t)
    (setq company-dabbrev-downcase nil)))

(use-package elm-mode
  :ensure t
  :config
  (add-to-list 'company-backends 'company-elm)
  (setq elm-interactive-command '("elm" "repl"))
  (setq elm-reactor-command '("elm" "reactor"))
  (setq elm-reactor-arguments '("--port" "8000"))
  (setq elm-compile-command '("elm" "make"))
  (setq elm-compile-arguments '("--output=elm.js" "--debug"))
  (setq elm-package-command '("elm" "package"))
  (setq elm-package-json "elm.json")
  (remove-hook 'elm-mode-hook 'elm-indent-mode)
  )

(use-package csharp-mode
  :ensure t)

(use-package omnisharp
  :ensure t
  :hook ((csharp-mode . omnisharp-mode)
         (before-save . omnisharp-code-format-entire-file))
  :config
  (add-to-list 'company-backends 'company-omnisharp))

(use-package fsharp-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

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
   "bx"  '(kill-buffer :which-key "kill buffer")
   "bb"  '(ivy-switch-buffer :which-key "switch buffer")
   "bn"  '(next-buffer :which-key "next buffer")
   "bp"  '(previous-buffer :which-key "previous buffer")
   "be"  '(eval-buffer :which-key "eval buffer")
   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
   ;; Window
   "w"   '(:ignore t :which-key "window")
   "w/"  '(split-window-right :which-key "split right")
   "w-"  '(split-window-below :which-key "split below")
   "wx"  '(delete-window :which-key "delete window")
   "wh"  '(evil-window-left :which-key "left")
   "wj"  '(evil-window-down :which-key "down")
   "wk"  '(evil-window-up :which-key "up")
   "wl"  '(evil-window-right :which-key "right")
   "wn"  '(evil-window-next :which-key "next window")
   "wp"  '(evil-window-prev :which-key "previous window")
   "wN"  '(evil-window-rotate-downwards :which-key "window rotate downwards")
   "wP"  '(evil-window-rotate-upwards :which-key "window rotate upwards")
   ;; Git
   "g"   '(:ignore t :which-key "git")
   "gg"  '(magit-status :which-key "status")
   "gS"  '(magit-stage :which-key "stage file")
   "gU"  '(magit-unstage :which-key "unstage file")
   "gc"  '(magit-commit :which-key "commit")
   "gd"  '(magit-diff :which-key "diff")
   "gl"  '(magit-log :which-key "log")
   "gb"  '(magit-blame :which-key "blame")
   "gp"  '(magit-push-to-remote :which-key "push")
   "gP"  '(magit-pull :which-key "pull")
   "gf"  '(magit-fetch :which-key "fetch")
   "gj"  '(git-gutter:next-hunk :which-key "next hunk")
   "gk"  '(git-gutter:previous-hunk :which-key "previous hunk")
   "gs"  '(git-gutter:stage-hunk :which-key "stage hunk")
   "gr"  '(git-gutter:stage-hunk :which-key "revert hunk")
   "gm"  '(git-gutter:stage-hunk :which-key "mark hunk")
   ;"gn"  '(magit-blob-next :which-key "next blob")
   ;"gp"  '(magit-blob-previous :which-key "prev blob")
   ;; Avy
   "l"    '(evil-avy-goto-line :which-key "goto-line")
   "c"    '(evil-avy-goto-char :which-key "goto-char")
   ;; Alchemist
   "a"    '(:ignore t :which-key "alchemist")
   "am"   '(:ignore t :which-key "mix")
   "amm"  '(alchemist-mix :which-key "mix")
   "amc"  '(alchemist-mix-compile :which-key "mix compile")
   "amr"  '(alchemist-mix-run :which-key "mix run")
   "ah"   '(:ignore t :which-key "hex")
   "ahr"  '(alchemist-hex-releases :which-key "hex releases")
   "ahi"  '(alchemist-hex-info :which-key "hex info")
   "ah.i" '(alchemist-hex-info-at-point :which-key "hex info at point")
   "ah.r" '(alchemist-hex-releases-at-point :which-key "hex releases at point")
   "ahs"  '(alchemist-hex-search :which-key "hex search")
   "at"   '(:ignore t :which-key "testing")
   "att"  '(alchemist-mix-test :which-key "mix test")
   "atr"  '(alchemist-mix-rerun-last-test :which-key "mix rerun last test")
   "atf"  '(alchemist-mix-test-file :which-key "mix test file")
   "atb"  '(alchemist-mix-test-this-buffer :which-key "mix test buffer")
   "at."  '(alchemist-mix-test-at-point :which-key "mix test at point")
   "atd"  '(alchemist-test-toggle-test-report-display :which-key "toggle test report display")
   "ac"   '(:ignore t :which-key "compilation")
   "acc"  '(alchemist-compile :which-key "compile")
   "acf"  '(alchemist-compile-file :which-key "compile file")
   "acb"  '(alchemist-compile-buffer :which-key "compile buffer")
   "ae"   '(:ignore t :which-key "execution")
   "aee"  '(alchemist-execute :which-key "execute")
   "aef"  '(alchemist-execute-file :which-key "execute file")
   "aeb"  '(alchemist-execute-buffer :which-key "execute buffer")
   "ah"   '(:ignore t :which-key "help")
   "ahh"  '(alchemist-help :which-key "help")
   "ahi"  '(alchemist-help-history :which-key "help history")
   "ah."  '(alchemist-help-search-at-point :which-key "help search at point")
   "ahr"  '(alchemist-refcard :which-key "alchemist refcard")
   "ad"   '(:ignore t :which-key "definition lookup")
   "ad."  '(alchemist-goto-definition-at-point :which-key "goto definition at point")
   "adb"  '(alchemist-goto-jump-back :which-key "goto jump back")
   "adp"  '(alchemist-goto-jump-to-previous-def-symbol :which-key "jump to prev def symbol")
   "adn"  '(alchemist-goto-jump-to-next-def-symbol :which-key "jump to next def symbol")
   "adl"  '(alchemist-goto-list-symbol-definitions :which-key "list symbol definitions")
   "ap"   '(:ignore t :which-key "project")
   "apf"  '(:ignore t :which-key "find")
   "apft" '(alchemist-project-find-test :which-key "find test")
   "apfd" '(alchemist-project-find-dir :which-key "find dir")
   "apfl" '(alchemist-project-find-lib :which-key "find lib")
   "aps"  '(alchemist-project-toggle-file-and-tests :which-key "toggle file and tests")
   "apo"  '(alchemist-project-toggle-file-and-tests-other-window :which-key "toggle file and tests other window")
   "apt"  '(alchemist-project-run-tests-for-current-file :which-key "run tests for file")
   "ai"   '(:ignore t :which-key "IEx")
   "air"  '(alchemist-iex-run :which-key "iex run")
   "aip"  '(alchemist-iex-project-run :which-key "iex project run")
   "ais"  '(:ignore t :which-key "iex send")
   "aisl" '(alchemist-iex-send-current-line :which-key "send line")
   "aisc" '(alchemist-iex-send-current-line-and-go :which-key "send line and go")
   "aisr" '(alchemist-iex-send-region :which-key "send region")
   "aism" '(alchemist-iex-send-region-and-go :which-key "send region and go")
   "aib"  '(alchemist-iex-compile-this-buffer :which-key "iex compile this buffer")
   "av"   '(:ignore t :which-key "eval")
   "avl"  '(:ignore t :which-key "eval line")
   "avll" '(alchemist-eval-current-line :which-key "eval line")
   "avlp" '(alchemist-eval-print-current-line :which-key "eval line (print)")
   "avlq" '(alchemist-eval-quoted-current-line :which-key "eval line (quoted)")
   "avlo" '(alchemist-eval-print-quoted-current-line :which-key "eval line (print quoted)")
   "avr"  '(:ignore t :which-key "eval region")
   "avrl" '(alchemist-eval-current-region :which-key "eval region")
   "avrp" '(alchemist-eval-print-current-region :which-key "eval region (print)")
   "avrq" '(alchemist-eval-quoted-current-region :which-key "eval region (quoted)")
   "avro" '(alchemist-eval-print-quoted-current-region :which-key "eval region (print quoted)")
   "avb"  '(:ignore t :which-key "eval buffer")
   "avbl" '(alchemist-eval-current-buffer :which-key "eval buffer")
   "avbp" '(alchemist-eval-print-current-buffer :which-key "eval buffer (print)")
   "avbq" '(alchemist-eval-quoted-current-buffer :which-key "eval buffer (quoted)")
   "avbo" '(alchemist-eval-print-quoted-current-buffer :which-key "eval buffer (print quoted)")
   "avq"  '(alchemist-eval-close-popup :which-key "close eval popup")
   "ao"   '(:ignore t :which-key "macroexpand")
   "aol"  '(:ignore t :which-key "current line")
   "aolc" '(alchemist-macroexpand-current-line :which-key "current line")
   "aolo" '(alchemist-macroexpand-once-current-line :which-key "once current line")
   "aolp" '(alchemist-macroexpand-once-print-current-line :which-key "once print current line")
   "aor"  '(:ignore t :which-key "current region")
   "aorc" '(alchemist-macroexpand-current-region :which-key "current region")
   "aoro" '(alchemist-macroexpand-once-current-region :which-key "once current region")
   "aorp" '(alchemist-macroexpand-once-print-current-region :which-key "once print current region")
   ;; Eyebrowse
   "0"    '(eyebrowse-switch-to-window-config-0 :which-key "workspace 0")
   "1"    '(eyebrowse-switch-to-window-config-1 :which-key "workspace 1")
   "2"    '(eyebrowse-switch-to-window-config-2 :which-key "workspace 2")
   "3"    '(eyebrowse-switch-to-window-config-3 :which-key "workspace 3")
   "4"    '(eyebrowse-switch-to-window-config-4 :which-key "workspace 4")
   "5"    '(eyebrowse-switch-to-window-config-5 :which-key "workspace 5")
   ;; Other
   "o"    '(:ignore t :which-key "org")
   "oc"   '(counsel-org-capture :which-key "org-capture")
   "oa"   '(org-agenda :which-key "org-agenda")
   "ol"   '(org-store-link :which-key "org-store-link")
   "ob"   '(org-switchb :which-key "org-switchb")
   "or"   '(org-refile :which-key "refile")
   "oi"   '(org-display-inline-images :which-key "display images")
   "p"    '(neotree :which-key "neotree")
   "t"    '(ansi-term :which-key "open terminal")
   "f"   '(find-file :which-key "find file")
   )
)

(use-package avy
  :ensure t)

(use-package org
  :ensure org-plus-contrib
  :config
  (setq org-agenda-dim-blocked-tasks t)
  (setq org-enforce-todo-dependencies t)
  (setq org-agenda-start-on-weekday 0)
  (setq org-agenda-files '("~/org/notes/inbox.org"
                           "~/org/notes/projects.org"
                           "~/org/notes/reminder.org"))

  (setq org-capture-templates '(("t" "Task [inbox]" entry
                                 (file+olp+datetree "~/org/notes/inbox.org" "Tasks")
                                 "* TODO %i%?" :tree-type week)
                                ("n" "Note [inbox]" entry
                                 (file+olp+datetree "~/org/notes/inbox.org" "Notes")
                                 "* %i%?")
                                ("r" "Reminder" entry
                                 (file+headline "~/org/notes/reminder.org" "Reminders")
                                 "* %i%? \n %U")))

  (setq org-refile-targets '(("~/org/notes/projects.org" :maxlevel . 5)
                             ("~/org/notes/someday.org" :level . 2)
                             ("~/org/notes/reminder.org" :maxlevel .2)))

  (setq org-refile-use-outline-path 'file)

  (setq org-outline-path-complete-in-steps nil)

  (setq org-todo-keywords '((sequence "TODO(t)"
                                      "NEXT(n)"
                                      "WORKING(W)"
                                      "WAITING(w)"
                                      "DELEGATED(D)"
                                      "MAYBE(m)"
                                      "|"
                                      "DONE(d)"
                                      "LATER(l)"
                                      "CANCELLED(c)")))

  (setq org-image-actual-width (/ (display-pixel-width) 3))
  (require 'ox-md)
  (require 'ox-org)
  (require 'ox-latex)
  (add-to-list 'org-latex-classes
               '("beamer"
                 "\\documentclass\[presentation\]\{beamer\}"
                 ("\\section\{%s\}" . "\\section*\{%s\}")
                 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
                 ("\\subsubsection\{%s\}" . "\\subsubsection *\{%s\}")))

  (setq org-agenda-files '("~org/projects.org"))

  )

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-download
  :ensure t)

; Overwrite some evil-org keys

; configuration
;(evil-leader/set-key-for-mode 'org-mode
;                              "oI" 'org-display-inline-images)

(use-package projectile
  :ensure t)

(use-package notmuch)

(use-package eyebrowse
  :diminish eyebrowse-mode
  :config
  (setq eyebrowse-new-workspace t)
  (eyebrowse-mode t))

(setq my-preferred-font
      (cond ((eq system-type 'windows-nt) "Iosevka Medium-10.5")
            ((eq system-type 'gnu/linux) "Iosevka-13")
            (t nil)))

(when my-preferred-font
  (set-frame-font my-preferred-font nil t))

(setq-default js-indent-level 4)
(setq-default tab-width 4)
(setq-default default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-stop-list (number-sequence 4 120 4))
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
    (eyebrowse notmuch org-mu4e neotree avy evil-org fsharp-mode omnisharp csharp-mode anaconda-mode git-timemachine projectile git-gutter elm-mode rust-mode org-download org-plus-contrib ox-taskjuggler evil-collection which-key use-package smooth-scrolling org-bullets magit graphviz-dot-mode general doom-themes diminish counsel alchemist))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
