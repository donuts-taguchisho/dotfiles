;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! org-modern)
(package! pangu-spacing :disable t)
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
