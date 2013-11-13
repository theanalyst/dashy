(defmacro inc! [var]
  "increments and sets the variable to incremented value"
  `(setv ~var (inc ~var)))

(defmacro --dotimes [n &rest body]
  "Anaphoric form of dotimes; allows `it' to be used in the body for
   eg. (--dotimes 10 (print it))"
  `(let [[it 0]]
     (while (< it ~n)
       ~@body
       (inc! it))))

(defmacro -dotimes [n &rest body]
  `(foreach [i (range ~n)] ~@body))

(defmacro -concat [item &rest coll]
  "a buggy concat, works for strings and collections normally will
   break when you try something fancy in arguments like a function
   that returns a list"
  (if (all (map iterable? coll))
    `(+ ~item ~@coll)
    (macro-error coll "invalid args..must be collections")))
