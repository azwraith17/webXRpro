#! /bin/sh
# -*- mode: scheme; coding: utf-8 -*-
exec guile -L /home/koorosh/proj/webXRpro/src -e main -s "$0" "$@"
!#
(use-modules (ice-9 match)
	     (ice-9 popen)
	     (ice-9 textual-ports)
	     (srfi srfi-26)
	     (artanis artanis)
	     (config))

(define od (make-parameter "./output/"))
(define-inlinable (tpl->html-string tpl) (format #f "<!DOCTYPE html>\n~a" (tpl->html tpl)))
(define-inlinable (file-in-output name)  (format #f "./~a/~a" (od) name))

(define (tpl->html-file)
  (parameterize ([static-gen #t])
    (map (match-lambda
	   [(name pager)
	    (with-output-to-file (write (tpl->html-string (pager)) p))])
	 all-pages)))

(define (copy-statics)
  (let* ([files-in-pub (map car (cddr (file-system-tree "./pub/")))]
	 [pipe (open-input-pipe (format #f "cp -r ./pub/*  ./~a" (od)) )])
    (display (get-string-all pipe))
    (close-pipe pipe)));;done

(define (gen-output)
  (copy-statics)
  (tpl->html-file ))

(define (main args)
  (match (cdr args)
    [() (gen-output)]
    [(output)
     (when (or (not (file-exists?       output))
	       (not (file-is-directory? output)))
       (format (current-error-port) "~a does not exist or is not a directory\n" output)
       (exit -1))
     (parameterize ([od output])
       (gen-output))]
    [else (display "name one directory for output of pages") (exit -2)]))
