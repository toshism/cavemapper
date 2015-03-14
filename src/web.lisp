(in-package :cl-user)
(defpackage cavemapper.web
  (:use :cl
        :caveman2
        :cavemapper.config
        :cavemapper.view
        :cavemapper.models)
  (:export :*web*))
(in-package :cavemapper.web)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (with-layout (:title "Welcome to Caveman2")
    (render #P"index.tmpl")))

(defroute "/test.json" (&key (|name| "default"))
  (let ((test (list :a 1 :b "yes!" :message "so this is pretty awesome" :name |name|)))
    (render-json test)))

(defroute ("/dbtest.json" :method :GET) ()
  (render-json (get-all-users)))

(defroute "/dbtest2.json" ()
  (render-json (get-user "tosh")))

(defroute ("/dbtest.json" :method :POST) (&key _parsed)
    (add-user (cdar _parsed) (cdadr _parsed))
    (render-json (get-all-users)))

;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
