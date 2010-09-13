;;Erlang Mode
(setq load-path (cons  "/usr/local/Cellar/erlang/HEAD/lib/erlang/lib/tools-2.6.6/emacs/" load-path))

(setq erlang-root-dir "/usr/local/Cellar/erlang/HEAD/lib/erlang/")
(setq exec-path (cons "/usr/local/Cellar/erlang/HEAD/lib/erlang/bin" exec-path))
;(setq erlang-man-root-dir "/usr/local/Cellar/erlang/HEAD/lib/erlang/man")

(require 'erlang-start)
(require 'erlang-flymake)

;; indent only with spaces
(add-hook 'erlang-mode-hook '(lambda() (setq indent-tabs-mode nil)))

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))


(defun my-erlang-mode-hook ()
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  ;; add Erlang functions to an imenu menu
  (imenu-add-to-menubar "imenu")
  ;; customize keys
  (local-set-key [return] 'newline-and-indent)
)
;; Some Erlang customizations
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)


;; distel stuff

(add-to-list 'load-path (concat kitfiles-dir "/vendor/distel"))
(require 'distel)
(distel-setup)

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;; add some Distel bindings to the Erlang shell
	    (dolist (spec distel-shell-keys)
	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))


(provide 'erlang-mode-stuff)
