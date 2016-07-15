(provide 'setup-environment)

(setq
 inhibit-startup-screen t
 )

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; (icomplete-mode)

;; savehist saves minibuffer history by defaults
(setq savehist-additional-variables '(search ring regexp-search-ring) ; also save your regexp search queries
      savehist-autosave-interval 60     ; save every minute
      )

(winner-mode 1)

(column-number-mode 1)

;; gopath
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "GOPATH")
