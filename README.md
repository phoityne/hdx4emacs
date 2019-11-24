
# Haskell Debugger Extension for Emacs
This is an experimental.

## System Design
![101_deploy.png](https://raw.githubusercontent.com/phoityne/hdx4emacs/master/docs/design/101_deploy.png)

## Movie
![01_sample_debug.gif](https://raw.githubusercontent.com/phoityne/hdx4emacs/master/docs/01_sample_debug.gif)


# Setup

## 1. Install emacs
Just get the windows binary.
http://ftp.gnu.org/gnu/emacs/windows/emacs-26/

## 2. package setting
@see : https://melpa.org/#/getting-started

Install lsp-mode and dap-mode from melpa.
```
[ESC-x] package-refresh-contents
[ESC-x] package-install lsp-mode
[ESC-x] package-install dap-mode
```

## 3. Create a stack project
```
> stack new sample rio
>
> cd sample
> stack test
>
```

## 4. Install haskell-debugger

 Install [haskell-dap](https://hackage.haskell.org/package/haskell-dap), [ghci-dap](https://hackage.haskell.org/package/ghci-dap), [haskell-debug-adapter](https://hackage.haskell.org/package/haskell-debug-adapter) at once.

```
> stack install haskell-dap ghci-dap haskell-debug-adapter
  !! current version not work.
     get new one from github.
>
```

## 5. Prepare load el
sample/hdx4emacs.el
```
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
    :logLevel "WARNING"
    :forceInspect nil))

```

## 6. Run emacs
```
> cd sample
> emacs.exe --load .\hdx4emacs.el app\Main.hs

[ESC-x] dap-debug
        haskell-debug-adapter
[ESC-x] dap-ui-locals
[ESC-x] dap-next
[ESC-x] dap-continue

```
