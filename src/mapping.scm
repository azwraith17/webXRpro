(define-module (mapping)
  #:use-module (config)
  #:use-module (artanis artanis)
  #:use-module (ice-9 textual-ports)
  #:use-module (main-page)
  #:use-module (model-viewer-page))


(define-public (start)
  (init-server #:statics '(css glb js usdz))
  (get "/" (lambda (rc)
	     (tpl->html (gen-main-page))))
  (get "/model?"
       (lambda (rc)
	 (parameterize ([default-model (assoc (get-from-qstr rc "model") (all-pages))]
			[title  (string-capitalize (get-from-qstr rc "model"))])
	   (display "--------------") (display (default-model)) (newline)
	   (tpl->html (gen-model-viewer)))))
  (get "/model"
       (lambda (rc)
	 (parameterize ([title "Heart"])
	   (gen-model-viewer))))

  (run #:port 8080))
