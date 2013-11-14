(defmacro -dotimes [n &rest body]
  "Anaphoric form of dotimes; allows `it' to be used in the body for
   eg. (-dotimes 10 (print it))"
  `(foreach [it (range ~n)] ~@body))

(defn mapcat [f &rest colls]
  "Apply f to collections and concat the results.
   The function f must return a collection for this to work "
  (let [[res []]]
    (for [coll colls it coll]
      (.extend res (f it)))
    res))

;; Probably need to depreciate the functions below this/ or come up
;; with something more convincing
(defmacro -concat [item &rest coll]
  "a buggy concat, works for strings and collections normally will
   break when you try something fancy in arguments like a function
   that returns a list"
  (if (all (map iterable? coll))
    `(+ ~item ~@coll)
    (macro-error coll "invalid args..must be collections")))
