;; Packages
(prelude-require-packages '(twilight-theme
                            paredit
                            js2-mode
                            json-mode
                            ;auto-complete
                            company
                            ac-js2
                            ac-cider-compliment
                            company-cider
                            yasnippet))

;; Visual settings
(global-linum-mode t)                                                      ; Always show line numbers on left
(setq linum-format "%4d ")                                                 ; Line numbers gutter should be four characters wide

; Mode line shows line numbers
(line-number-mode 1)

; Mode line shows column numbers
(column-number-mode 1)

; Emacs prompts should accept "y" or "n" instead of the full word
(fset 'yes-or-no-p 'y-or-n-p)

; No more Mr. Visual Bell Guy.
(setq visible-bell nil)

;; Fuck you guru
(setq prelude-guru nil)

;; No flyspell
(setq prelude-flyspell nil)

;; General startup
(setq initial-scratch-message nil)                                         ; *scratch* starts empty
(when (locate-library "clojure-mode")                                      ; Set *scratch* to Clojure mode
  (setq initial-major-mode 'clojure-mode))

;; Projectile settings for fast nav
; Quickly navigate projects using Projectile (C-c p C-h for available commands)
(projectile-global-mode)

; Projectile shows full relative paths
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company '(add-to-list 'company-backends 'company-cider))

;; yasnippet
(yas-global-mode 1)

;; Clojure
(setq auto-mode-alist (cons '("\\.edn$" . clojure-mode) auto-mode-alist))  ; *.edn are Clojure files
(setq auto-mode-alist (cons '("\\.cljs$" . clojure-mode) auto-mode-alist)) ; *.cljs are Clojure files

;; JavaScript
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(eval-after-load 'js2-mode
  '(progn
     (setq-default js2-basic-offset 2)
     (set-variable 'indent-tabs-mode nil)
     (font-lock-add-keywords 'js2-mode
                             `(("\\(function *\\)(" (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ") nil)))))))

;; CoffeeScript
(custom-set-variables '(coffee-tab-width 2))

;; web-mode
(add-to-list 'auto-mode-alist '("\\.rhtml?\\'" . web-mode))
(setq web-mode-code-indent-offset 2)

;; ;; Auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (ac-set-trigger-key "TAB")
;; (ac-set-trigger-key "<tab>")

;; ;; Auto-complete hooks
;; (add-hook 'js2-mode-hook (lambda () (interactive) (auto-complete-mode)))
;; (add-hook 'coffee-mode-hook (lambda () (interactive) (auto-complete-mode)))
;; (add-hook 'ruby-mode-hook (lambda () (interactive) (auto-complete-mode)))
;; (add-hook 'scss-mode-hook (lambda () (interactive) (auto-complete-mode)))

;; Keep the good whitespace
(setq require-final-newline t)
;; Clean Whitespace handling
(add-hook 'before-save-hook 'delete-trailing-whitespace)
