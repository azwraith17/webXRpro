(define-module (main-page)
  #:use-module ((srfi srfi-1) #:select (fold unfold))
  #:use-module (ice-9 match))

(define button-assoc
  ;;name    model-file   mapping
  '(("Skull\n" "leo.glb"     "/leo")
    ("Heart\n" "heart.glb"   "/heart")))

(define (gen-buttons l)
  (map (match-lambda
	 [(name model mapping)
	  `(div (a (@ (id   ,name)
		      (href ,mapping))
		   ,name)
		(br))])
       l))

(define-public (main-page)
  `(html (@ (lang "en"))
	 (head
	  (link (@ (rel "stylesheet") (href "style.css")))
	  (meta (@ (charset "utf-8")))
	  (title "Welcome to Vritual lab"))
	 (body
	  (div (@ (id "nav-box"))
	       ,@(gen-buttons button-assoc)))))
