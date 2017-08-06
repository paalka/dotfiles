(require 'package-util)

(ensure-package-installed 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))

(exec-path-from-shell-copy-env "PATH")
(exec-path-from-shell-copy-env "GOPATH")
(simpleclip-mode 1)

(provide 'exec-path-cfg)
