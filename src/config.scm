(define-module (config)
  #:export (all-pages od model-viewer
		      title default-model
		      static-gen))

(define title (make-parameter "Welcome to Vritual lab"))
(define od (make-parameter "./output/"))
(define model-viewer (make-parameter "/model" ))
(define default-model (make-parameter `("heart.glb" "Heart")))
(define static-gen (make-parameter #f))
(define all-pages
  (make-parameter `(("skull.glb" "Skull")
		    ("heart.glb" "Heart")
		    ("cube.glb" "Cube"))))
