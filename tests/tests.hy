(import [dashy.dash [mapcat]])
(require dashy.dash)


(defn test-mapcat []
  "test mapcat"
  (assert (= [1 2 3 4 5 6] (mapcat reversed [[3 2 1] [6 5 4]])))
  (assert (= [0 1 2 1 2 3 2 3 4] (mapcat (fn [n] [(dec n) n (inc n)]) [1 2 3]))))

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
