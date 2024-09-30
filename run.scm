#! /bin/sh
# -*- mode: scheme; coding: utf-8 -*-
exec guile -L ./webXRpro/src -e main -s "$0" "$@"
!#

(use-modules (ice-9 match)
	     (mapping)
	     (system repl server))

(define (init-debug spath)
  (let ([s (make-unix-domain-server-socket #:path spath)])
    (spawn-server s)))

(define (main arg)
  (match arg
    [(_) (start)]
    [(_ "debug" spath)
     (init-debug spath)
     (main '(debug))
     (stop-server-and-clients!)
     (delete-file spath)]
    [else (error "wrong argument format to main" arg)]))
