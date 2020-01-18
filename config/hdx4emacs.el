(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (dap-mode lsp-mode ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'dap-mode)
(require 'dap-utils)

(dap-mode 1)
(dap-ui-mode 1)
(dap-tooltip-mode 1)
(tooltip-mode 1)
(setq debug-on-error t)

(dap-register-debug-provider
  "hda"
  (lambda (conf)
    (plist-put conf :dap-server-path (list "haskell-debug-adapter" "--hackage-version=0.0.31.0"))
    conf))

(dap-register-debug-template "haskell-debug-adapter"
  (list :type "hda"
    :request "launch"
    :name "haskell-debug-adapter"
    :internalConsoleOptions "openOnSessionStart"
    ;; :workspace (lsp-find-session-folder (lsp-session) (buffer-file-name))
    :workspace "C:/work/haskell/sample"
    :startup "C:/work/haskell/sample/app/Main.hs"
    :startupFunc ""
    :startupArgs ""
    :stopOnEntry t
    :mainArgs ""
    :ghciPrompt "H>>= "
    :ghciInitialPrompt "Prelude>"
    :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
    :ghciEnv (list :dummy "")
    :logFile "C:/work/haskell/sample/hdx4emacs.log"
    :logLevel "DEBUG"
    :forceInspect nil))

;; c:\tool\emacs-26.3-x86_64\bin\emacs.exe --load .\hdx4emacs.el app\Main.hs

