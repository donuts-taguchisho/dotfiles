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

;; TAB幅を2に設定
(setq-default tab-width 2)
;; 確実を期すために
;; (add-hook 'after-change-major-mode-hook
;;           (lambda () (setq tab-width 2)))

;; erbファイル用
(with-eval-after-load 'flycheck
  (add-hook 'mhtml-mode-hook
            (lambda ()
              ;; html-tidy というチェッカーだけ無効リストに追加
              (setq-local flycheck-disabled-checkers '(html-tidy)))))

(add-hook 'web-mode-hook
  (lambda ()
    (font-lock-add-keywords
     nil
     ;; < の直後に非ASCII文字（日本語など）が来る場合、
     ;; そのブロック全体を 'default フェイス（通常色）で上書きする
     '(("<\\([[:nonascii:]][^>]*\\)>" 0 'default t))
     'append))) ;; 'append を指定して web-mode のハイライトより後に適用させる

(setq pangu-spacing-mode nil)

;; treemacsの設定
(after! treemacs
  ;; 幅を固定ロックしない（手で調整可能にする）
  (setq treemacs-width-is-initially-locked nil
        treemacs-width 50) ; デフォルト幅

  (defun my/treemacs-set-width (width)
    "Treemacs の幅を WIDTH（列数）に設定する。"
    (interactive "nTreemacs width: ")
    (setq treemacs-width width)
    (when-let ((win (treemacs-get-local-window)))
      (adjust-window-trailing-edge win (- width (window-total-width win)) t))))
