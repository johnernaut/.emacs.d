(provide 'setup-applications)

(require 'duplicate-thing)
(global-set-key (kbd "M-c") 'duplicate-thing)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'yasnippet)
(yas-global-mode 1)

(add-hook 'after-init-hook 'global-company-mode)

(require 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)

(projectile-global-mode)

(global-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

; magit
(require 'magit)
(set-default 'magit-stage-all-confirm nil)
(add-hook 'magit-mode-hook 'magit-load-config-extensions)

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(global-unset-key (kbd "C-x g"))
(global-set-key (kbd "C-x g h") 'magit-log)
(global-set-key (kbd "C-x g f") 'magit-file-log)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
(global-set-key (kbd "C-x g m") 'magit-branch-manager)
(global-set-key (kbd "C-x g c") 'magit-branch)
(global-set-key (kbd "C-x g s") 'magit-status)
(global-set-key (kbd "C-x g r") 'magit-reflog)
(global-set-key (kbd "C-x g t") 'magit-tag)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'flycheck-tip)
(flycheck-tip-use-timer 'verbose)

(require 'eshell)
(require 'em-alias)
(require 'cl)

;; Advise find-file-other-window to accept more than one file
(defadvice find-file-other-window (around find-files activate)
  "Also find all files within a list of files. This even works recursively."
  (if (listp filename)
      (loop for f in filename do (find-file-other-window f wildcards))
    ad-do-it))

;; In Eshell, you can run the commands in M-x
;; Here are the aliases to the commands.
;; $* means accepts all arguments.
(eshell/alias "o" "")
(eshell/alias "o" "find-file-other-window $*")
(eshell/alias "vi" "find-file-other-window $*")
(eshell/alias "vim" "find-file-other-window $*")
(eshell/alias "emacs" "find-file-other-windpow $*")
(eshell/alias "em" "find-file-other-window $*")

(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; change listing switches based on OS
(when (not (eq system-type 'windows-nt))
  (eshell/alias "ls" "ls --color -h --group-directories-first $*"))

;; golden ratio
(require 'golden-ratio)

(add-to-list 'golden-ratio-exclude-modes "ediff-mode")
(add-to-list 'golden-ratio-exclude-modes "helm-mode")
(add-to-list 'golden-ratio-exclude-modes "dired-mode")
(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)

(defun pl/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

;; do not enable golden-raio in thses modes
(setq golden-ratio-exclude-modes '("ediff-mode"
                                   "gud-mode"
                                   "gdb-locals-mode"
                                   "gdb-registers-mode"
                                   "gdb-breakpoints-mode"
                                   "gdb-threads-mode"
                                   "gdb-frames-mode"
                                   "gdb-inferior-io-mode"
                                   "gud-mode"
                                   "gdb-inferior-io-mode"
                                   "gdb-disassembly-mode"
                                   "gdb-memory-mode"
                                   "magit-log-mode"
                                   "magit-reflog-mode"
                                   "magit-status-mode"
                                   "IELM"
                                   "eshell-mode" "dired-mode"))

(golden-ratio-mode)

;; highlight numbers
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; highlight symbols
(require 'highlight-symbol)

(highlight-symbol-nav-mode)

(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

(setq highlight-symbol-idle-delay 0.2
      highlight-symbol-on-navigation-p t)

(global-set-key [(control shift mouse-1)]
                (lambda (event)
                  (interactive "e")
                  (goto-char (posn-point (event-start event)))
                  (highlight-symbol-at-point)))

(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;; golang
(ac-config-default)
(require 'auto-complete-config)
(require 'go-autocomplete)

;;; setup-applications.el ends here
