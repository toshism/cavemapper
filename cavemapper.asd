(in-package :cl-user)
(defpackage cavemapper-asd
  (:use :cl :asdf))
(in-package :cavemapper-asd)

(defsystem cavemapper
  :version "0.1"
  :author "Tosh Lyons"
  :license ""
  :depends-on (:clack
               :caveman2
               :envy
               :cl-ppcre

               ;; HTML Template
               :cl-emb

               ;; for DB
               :datafly
               :sxql)
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op cavemapper-test))))
