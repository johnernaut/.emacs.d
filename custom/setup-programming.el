(provide 'setup-programming)

(setq c-default-style "linux" ; set style to "linux"
      c-basic-offset 4)

(setq gdb-many-windows t ; use gdb many windows by default
      gdb-show-main t) ; non nil means display source file w/main routine

;; Compilation from Emacs
(defun prelude-colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

;; setup compilation-mode used by `compile' command
(require 'compile)
(setq compilation-ask-about-save nil          ; Just save before compiling
      compilation-always-kill t               ; Just kill old compile processes before starting the new one
      compilation-scroll-output 'first-error) ; Automatically scroll to first
(global-set-key (kbd "<f5>") 'compile)

;; GROUP: Programming -> Tools -> Makefile
;; takenn from prelude-c.el:48: https://github.com/bbatsov/prelude/blob/master/modules/prelude-c.el
(defun prelude-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'prelude-makefile-mode-hook)))

;; GROUP: Programming -> Tools -> Ediff
(setq ediff-diff-options "-w"
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)
