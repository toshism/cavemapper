(in-package :cl-user)
(defpackage cavemapper-test-asd
  (:use :cl :asdf))
(in-package :cavemapper-test-asd)

(defsystem cavemapper-test
  :author "Tosh Lyons"
  :license ""
  :depends-on (:cavemapper
               :prove)
  :components ((:module "t"
                :components
                ((:file "cavemapper"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
