(defun run-breadth (start goal)
  (declare (special *open*)
           (special *closed*)
           (special *goal*))
  (setq *open* (list start))
  (setq *closed* nil)
  (setq *goal* goal)
  (breadth-first))


(defun breadth-first ()
  (declare (special *open*)
           (special *closed*)
           (special *goal*)
           (special *moves*))
  (cond ((null *open*) nil)
        (t (let ((state (car *open*)))
             (cond ((equal state *goal*) 'success)
                   (t (setq *closed* (cons state *closed*))
                      (setq *open* 
                            (append (cdr *open*)
                                    (generate-descendants state *moves*)))
                      (breadth-first)))))))

;;; Generates all the descendants of a given state.

(defun generate-descendants (state moves)
  (declare (special *open*)
           (special *closed*))
  (cond ((null moves) nil)
        (t (let ((child (funcall (car moves) state))
                 (rest (generate-descendants state (cdr moves))))
             (cond ((null child) rest)
                   ((member child rest :test #'equal) rest)
                   ((member child *open* :test #'equal) rest)
                   ((member child *closed* :test #'equal) rest)
                   (t (cons child rest)))))))