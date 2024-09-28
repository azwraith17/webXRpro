#! /bin/sh
# -*- mode: scheme; coding: utf-8 -*-
exec guile -e main -s "$0" "$@"
!#
(use-modules (artanis artanis)
	     (ice-9 textual-ports))
(define-public (start)
  (init-server #:statics '(css js glb) #:exclude '())
  (get "/" (lambda (rc)
	     (call-with-input-file "/home/quasikote/proj/webXRpro/index.html"
	       get-string-all)))
  (run #:port 8080))
(define (main . a)
  (start))
