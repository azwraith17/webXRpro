(define-module (main-page)
  #:use-module (ice-9 match)
  #:use-module (config)
  #:use-module ((srfi srfi-1) #:select (fold unfold)))

(define (model->qurl m)
  (format #f "~a?model=~a" (model-viewer) m))
(define (model->path m)
  (format #f "./~a.html" (cadr (assoc m (all-pages)))))

(define (link name ref)
  `(a (@ (class "model-btn") (href ,ref)) ,name))


(define (gen-buttons)
  (map (match-lambda
	 [(model name)
	  (link name ((if (static-gen) model->path model->qurl)
		      model))])
       (all-pages)))

(define (header)
  `(head
    (link (@ (rel "stylesheet") (href "style.css")))
    (meta (@ (charset "utf-8")))
    (meta (@ (name "view-port")
	     (content"width=device-width, initial-scale=1.0")))
    (title ,(title))))

(define-public (gen-main-page)
  `(html (@ (lang "en"))
	 ,(header)
	 (body
	  (div (@ (id "nav-box"))
	       ,@(gen-buttons)))))
