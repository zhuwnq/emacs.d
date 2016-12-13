;;; init-20-nav-interface.el --- Customize emacs interface (mostly Helm)

;; Copyright (C) 2016 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration, helm
;; Homepage: https://github.com/gjstein/emacs.d
;; License: GNU General Public License (see init.el for details)

;;; Commentary:
;; Mostly configures helm-mode, which is great for getting around
;; For more on Helm, see:
;;     http://tuhdo.github.io/helm-intro.html
;;     https://github.com/emacs-helm/helm/wiki

;;; Code:
(require 'use-package)


;; == Evil Mode ==
(use-package evil
  :ensure t
  :init
  (evil-mode 1)
  (define-key evil-ex-map "b " 'helm-mini)
  (define-key evil-ex-map "e" 'helm-find-files)
  ;; Resolve sentence jumping issue
  (setq sentence-end-double-space nil)
  )


;; == Helm Mode ==
(use-package helm
  :ensure t
  :diminish helm-mode
  :init

  ;; Changes the helm prefix key
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  ;; Supress warning
  (setq ad-redefinition-action 'accept)

  :config

  (require 'helm)
  (require 'helm-files)
  (require 'helm-config) ; Necessary for helm-mode
  
  ;; Key bindings
  (bind-key "<tab>" 'helm-execute-persistent-action helm-map)
  (bind-key "C-i" 'helm-execute-persistent-action helm-map)
  (bind-key "C-z" 'helm-select-action helm-map) ; list actions using C-z
  (bind-key [escape] 'helm-keyboard-quit)

  (setq helm-split-window-in-side-p           t
	helm-move-to-line-cycle-in-source     t
	helm-ff-search-library-in-sexp        t
	helm-scroll-amount                    8
	helm-M-x-fuzzy-match                  t
	helm-ff-file-name-history-use-recentf t)


  (if (string-equal system-type "darwin")
      ;; This requires the 'ggrep' command to be installed for OSX
      (setq helm-grep-default-command
	    "ggrep --color=always -d skip %e -n%cH -e %p %f"
	    helm-grep-default-recurse-command
	    "ggrep --color=always -d recurse %e -n%cH -e %p %f"))
  (if (string-equal system-type "gnu/linux")
      (setq helm-grep-default-command
	    "grep --color=always -d skip %e -n%cH -e %p %f"
	    helm-grep-default-recurse-command
	    "grep --color=always -d recurse %e -n%cH -e %p %f"))

  (helm-mode 1)

  (defun spacemacs//hide-cursor-in-helm-buffer ()
    "Hide the cursor in helm buffers."
    (with-helm-buffer
      (setq cursor-in-non-selected-windows nil)))
  (add-hook 'helm-after-initialize-hook 'spacemacs//hide-cursor-in-helm-buffer)
  
  :bind (("C-x b" . helm-mini)
	 ("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 )
  )



;;; init-20-nav-interface.el ends here
