(in-package :cl-user)
(defpackage cavemapper.models
  (:use :cl
        :caveman2
        :datafly
        :cavemapper.db
        :sxql)
  (:export :user
           :get-user
           :get-all-users
           :add-user))

(in-package :cavemapper.models)

(defmodel (user)
  id
  username
  password)

;; Data access stuff
(defun get-user (name)
  (with-connection (db)
    (retrieve-one
     (select (:id :username)
       (from :users)
       (where (:= :username name)))
     :as 'user)))

(defun get-all-users ()
  (with-connection (db)
    (retrieve-all
     (select (:id :username)
       (from :users))
     :as 'user)))

(defun add-user (name password)
  (with-connection (db)
    (execute
     (insert-into :users
       (set= :username name
             :password password)))))
