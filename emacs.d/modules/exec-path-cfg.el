(require 'package-util)

(ensure-package-installed 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))

(exec-path-from-shell-copy-env "PATH")
(exec-path-from-shell-copy-env "GOPATH")
(exec-path-from-shell-copy-env "GOROOT")
(exec-path-from-shell-copy-env "RUST_SRC_PATH")

(provide 'exec-path-cfg)
