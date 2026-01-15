;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; LSP Headerline Breadcrumb のトグル設定
(map! :leader
      :desc "Toggle LSP headerline breadcrumb"
      "l b" #'lsp-headerline-breadcrumb-mode)

(map! :leader
      :desc "Toggle Scroll Bar"
      "l s" #'scroll-bar-mode)

(map! :leader
      :desc "Vertico project search"
      "/" #'+vertico/project-search)

;; *太字* や /斜体/ などの記号を隠して表示する
(setq org-hide-emphasis-markers t)
;; 見出しの余計な「*」を消してインデントを整理する
(add-hook 'org-mode-hook 'org-indent-mode)
;; 画像のリンクを実際の画像として表示する
(setq org-startup-with-inline-images t)
;; org-modernの設定
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇" "✳" "◆" "●" "◌") ;; 見出し記号のカスタム（お好みで）
        org-modern-table-vertical 1   ;; 表の縦線を表示（1:あり, nil:なし）
        org-modern-table-horizontal 0.2 ;; 表の横線の太さ
        org-modern-list '((43 . "➤") (45 . "–") (42 . "•")) ;; リストの記号 (+, -, *) を変える
        org-modern-todo t ;; TODOの装飾。Doom標準の色を使いたい場合はnil、org-modern流にするならt
        org-modern-tag nil  ;; タグの装飾。同上
        ))

;; グローバルに設定
(setq-default tab-width 2)

;; after-change-major-mode-hook で確実に適用
(add-hook 'after-change-major-mode-hook
          (lambda () (setq tab-width 2)))

;; rubyをmiseでインストールした場合のruby-lspの設定をzshから読み取る設定
(after! exec-path-from-shell
  ;; GUI起動時にログインシェル相当の環境を取り込む
  (setq exec-path-from-shell-shell-name "zsh"
        exec-path-from-shell-arguments '("-l"))
  ;; 取り込みたい環境変数
  (dolist (var '("PATH" "GEM_HOME" "GEM_PATH" "RBENV_ROOT" "RUBYOPT" "BUNDLE_GEMFILE"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(after! lsp-mode
  ;; ruby-lsp を bundler 経由で起動（プロジェクトのGemfileに合わせる）
  (setq lsp-ruby-lsp-use-bundler t)

  ;; Solargraph を使わず ruby-lsp を優先
  ;; （lsp-mode のバージョン差異があるので、まずは server command を明示）
  (setq lsp-ruby-lsp-server-command '("bundle" "exec" "ruby-lsp")))

(after! lsp-mode
  ;; plistではなくhash-tableで扱う（ruby-lsp 側と噛み合わない時の対策）
  (setq lsp-use-plists nil))
