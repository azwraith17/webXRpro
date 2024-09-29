#! /bin/sh
# -*- mode: scheme; coding: utf-8 -*-
exec guile -L /home/koorosh/proj/webXRpro/src -e main -s "$0" "$@"
!#

(use-modules (ice-9 match))
(define (main args)
  (match args
    [(output )]))
