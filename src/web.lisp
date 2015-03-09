(in-package :cl-user)
(defpackage cavemapper.web
  (:use :cl
        :caveman2
        :cavemapper.config
        :cavemapper.view
        :cavemapper.db
        :datafly
        :sxql)
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
  (render-json (with-connection (db)
    (retrieve-all
     (select :*
       (from :users))))))

(defroute "/dbtest2.json" ()
  (render-json (get-user "tosh")))

(defroute ("/dbtest.json" :method :POST) (&key _parsed)
    (add-user (cdr (car _parsed)))
    (render-json (get-all-users)))

;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))

;;
;; Data access stuff
(defun get-user (name)
  (with-connection (db)
    (retrieve-one
     (select :*
       (from :users)
       (where (:= :name name))))))

(defun get-all-users ()
  (with-connection (db)
    (retrieve-all
     (select :*
       (from :users)))))

(defun add-user (name)
  (with-connection (db)
    (execute
     (insert-into :users
       (set= :name name)))))
