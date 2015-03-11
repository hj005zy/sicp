;;; add-streams.scm

(load "50-stream-map.scm")

(define (add-streams s1 s2)
   (stream-map + s1 s2))
