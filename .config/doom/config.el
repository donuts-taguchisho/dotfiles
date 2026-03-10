;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(after! doom-modeline
  (setq doom-modeline-vcs-max-length 60))
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

;; mise shims を exec-path と PATH に追加
(let ((mise-shims (expand-file-name "~/.local/share/mise/shims")))
  (add-to-list 'exec-path mise-shims)
  (setenv "PATH" (concat mise-shims ":" (getenv "PATH"))))

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

;; 自動で日本語と英数字の間にスペースを入れる機能をオフにする
(after! pangu-spacing
  ;; もしどこかで有効化されていても起動後に必ずOFFにする
  (when (bound-and-true-p pangu-spacing-mode)
    (pangu-spacing-mode -1))

  ;; もし global-pangu-spacing-mode が存在する環境ならそれもOFF
  (when (fboundp 'global-pangu-spacing-mode)
    (global-pangu-spacing-mode -1))

  ;; “実際に挿入”を無効化
  (setq pangu-spacing-real-insert-separtor nil)

  ;; 念のため：コミットメッセージでは常にOFF
  (add-hook 'git-commit-mode-hook
            (lambda ()
              (setq-local pangu-spacing-real-insert-separtor nil)
              (when (bound-and-true-p pangu-spacing-mode)
                (pangu-spacing-mode -1)))))

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

;; まず「クラス」として設定を書く
(dir-locals-set-class-variables
 'my-ruby-project
 '((ruby-mode . ((lsp-enabled-clients . (my-ruby-lsp))))))

;; そのクラスを特定ディレクトリに紐づける
(dir-locals-set-directory-class
 "Users/taguchishoh/Documents/github/rails-training-app" 'my-ruby-project)
;; ↑ 末尾の / を忘れない & 実際のプロジェクトパスに差し替える

(use-package lsp-mode
  :init
  ;; rubocop-ls や標準の ruby-lsp-ls を無効にしておく
  (setq lsp-disabled-clients '(rubocop-ls ruby-lsp-ls))
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "ruby-lsp")
    :major-modes '(ruby-mode ruby-ts-mode)
    :server-id 'my-ruby-lsp))
  ;; Ruby では常に自作クライアントだけを有効にする
  (add-hook 'ruby-mode-hook
            (lambda ()
              (setq-local lsp-enabled-clients '(my-ruby-lsp))
              (lsp-deferred))))

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

(map! :leader
      :desc "treemacs select window"
      "l w" #'treemacs-select-window)

;; 東城さんの設定
;; おそらくそのまま適用しても、DoomEmacs用ではないので効果がなかったかも
;; (use-package lsp-mode
;;   :config
;;   (setq lsp-inlay-hint-enable t)
;;   (setq lsp-disabled-clients '(rubocop-ls))
;;   (setq lsp-javascript-format-enable nil)
;;   (setq lsp-typescript-format-enable nil)
;;   :hook
;;   ((ruby-mode . lsp)
;;    (tsx-ts-mode . lsp)
;;    (typescript-ts-mode . lsp)))
;;
;; (use-package lsp-ui)

(defun my/im-select-abc ()
  (when (executable-find "im-select")
    (start-process "im-select" nil "im-select" "com.apple.keylayout.ABC")))

;; insertから抜けたタイミング
(add-hook 'evil-insert-state-exit-hook #'my/im-select-abc)

;; minibuffer（コマンド入力）終了時も寄せたい場合
(add-hook 'minibuffer-exit-hook #'my/im-select-abc)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(after! copilot
  (setq copilot-indent-offset-warning-disable t)
  (defadvice! my/copilot-indent-offset (&rest _)
    :override #'copilot--infer-indentation-offset
    tab-width))

(defun open-in-cursor ()
  "Open the current file in Cursor."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (start-process "open-in-cursor" nil "open" "-a" "Cursor" filename)
      (message "No file associated with this buffer."))))

(map! :leader
      :desc "Open in Cursor"
      "o C" #'open-in-cursor)
