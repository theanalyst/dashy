(import [dashy.dash [mapcat flatten partition]])
(require dashy.dash)
(require tests.testy)

(tests mapcat-tests-v1
      (env (defn simple-gen [l] (foreach [it l] (yield it))))
      (assert-example (mapcat reversed [[3 2 1] [6 5 4]]) => [1 2 3 4 5 6]))

(tests test-partition
       (assert-example (partition (range 6) 2) ⇔ [[0 1] [2 3] [4 5]])
       (assert-example (partition (range 6) 4) ⇔ [[0 1 2 3]])
       (assert-example (partition (range 6) 2 1) ⇔ [[0 1] [1 2] [2 3] [3 4] [4 5]]))

(defn test-mapcat []
  "test mapcat"
  (defn simple-gen [l] (foreach [it l] (yield it)))
  (assert (= [1 2 3 4 5 6] (mapcat reversed [[3 2 1] [6 5 4]])))
  (assert (= [0 1 2 1 2 3 2 3 4] (mapcat (fn [n] [(dec n) n (inc n)]) [1 2 3])))
  (assert (= [0 1 2 1 2 3 2 3 4]
	     (mapcat (fn [n] [(dec n) n (inc n)]) (simple-gen [1 2 3])))))

(defn test-dotimes []
  "test dotimes; since this has side effects and doesn't return
   Kinda gross; need a better example"
  (defn fibgen [a b]
    "the canonical ∞ fibonacci generator"
    (while true
      (yield a)
      (setv (, a b) (, b (+ a b)))))

  (def fibs (fibgen 0 1))

  (assert (= 55 (let [] (-dotimes 10 (.next fibs)) (.next fibs) )))
  )

(defn test-flatten []
  "flattening a list/tuple"
  (assert (= [1 2 3 4] (flatten [1 2 [3 4]])))
  (assert (= [1 2 3 4] (flatten [1 2 3 4])))
  (assert (= [1 2 3 4] (flatten (, 1 (, 2 3) 4)))))
