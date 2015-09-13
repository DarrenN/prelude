;; Packages
(prelude-require-packages '(twilight-theme
                            paredit
                            js2-mode
                            json-mode
                            racket-mode
                            markdown-mode
                            company
                            ac-js2
                            yasnippet
                            editorconfig))

;; EditorConfig settings
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "/usr/local/opt/editorconfig-emacs/share/emacs/site-lisp/editorconfig")
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "editorconfig")

;; NO AUTOSAVE!
(setq auto-save-default nil)

;; Visual settings
(global-linum-mode t)

; Always show line numbers on left
(setq linum-format "%4d ")

; Mode line shows line numbers
(line-number-mode 1)

; Mode line shows column numbers
(column-number-mode 1)

; Emacs prompts should accept "y" or "n" instead of the full word
(fset 'yes-or-no-p 'y-or-n-p)

; No more Mr. Visual Bell Guy.
(setq visible-bell nil)

;; Fuck you guru
;(setq prelude-guru nil)

;; No flyspell
(setq prelude-flyspell nil)

;; UTF8 All the things
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

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
;(eval-after-load 'company '(add-to-list 'company-backends))

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
                             `(("\\(function *\\)("
                                (0 (progn
                                     (compose-region
                                      (match-beginning 1)
                                      (match-end 1)
                                      "λ") nil)))))))

;; CoffeeScript
(custom-set-variables '(coffee-tab-width 2))

;; web-mode
(require 'web-mode)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (add-to-list 'auto-mode-alist '("\\.rhtml?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs?\\'" . web-mode))
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)

;; yasnippet
(yas-global-mode 1)

;; Keep the good whitespace
(setq require-final-newline t)

;; Clean Whitespace handling
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Use right Option key to insert UTF-8 symbols like ¥ ü etc,
(setq ns-right-option-modifier 'option)

;; enable lozenge for Pollen
;; ◊◊◊◊◊◊◊◊◊◊◊◊◊
;; 'mule-unicode part from
;; https://lists.gnu.org/archive/html//emacs-devel/2005-03/msg01187.html
(defun insert-lozenge ()
  "inserts the lozenge character for use with Pollen"
  ;; enables function through M-x
  (interactive)
  ;; insert the proper character
  (insert (make-char
           'mule-unicode-2500-33ff 34 42)))

;; Racket mode
;; ===========
;; This will set M-\ as the λ character
;; This will set M-] as the ◊ character for Pollen
;; Switches on unicode-input
(require 'racket-mode)
(defun my-racket-mode-hook ()
  (racket-unicode-input-method-enable)
  (global-set-key "\M-\\" 'racket-insert-lambda)
  (global-set-key "\M-\]" 'insert-lozenge))

(add-hook 'racket-mode-hook 'my-racket-mode-hook)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;; Prevents .rkt from opening in Geiser
;; (This will open .pm, .pmd and .pp files in Racket mode (for Pollen))
(add-to-list 'auto-mode-alist '("\\.rkt?\\'" . racket-mode))
(add-to-list 'auto-mode-alist '("\\.p[pmd]+\\'" . racket-mode))
