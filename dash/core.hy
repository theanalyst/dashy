(import [collections [deque]])

(if-python2 (import [itertools [imap :as map]]) None)

(defmacro -dotimes [n &rest body]
  "Anaphoric form of dotimes; allows `it' to be used in the body for
   eg. (-dotimes 10 (print it))"
  `(for [it (range ~n)] ~@body))

(defmacro -map [f coll]
  "Anaphoric map form, `it' is allowed for variable capture"
  `(map (fn [it] ~f) ~coll))

(defn take-last (n coll)
  "Take n items from the coll in reverse order"
  (let [[dq (deque coll)]]
    (-dotimes n (yield (.pop dq)))))

(defn last (coll)
  "The last item of a collection"
  (next (take-last 1 coll)))

(defn mapcat [f &rest colls]
  "Apply f to collections and concat the results.
   The function f must return a collection for this to work "
  (let [[res []]]
    (for [coll colls it (iter coll)]
      (.extend res (f it)))
    res))

(defn partition [coll n &optional (steps 0)]
  "Returns a list with items grouped in n sized sublists at offset
   `steps' apart, if there are not enough items to make the last group
    n sized, they are dropped"
  (let [[res []]
	[citer (iter coll)]
	[part (list (take n citer))]
	[step (or steps n) ]]
    (if (not (and (pos? n) (pos? step)))
      (raise (ValueError "partition steps must be positive"))
      (while (= (len part) n)
	(.append res part)
	(setv part (+ (list (drop step part)) (list (take step citer))))))
    res))

(defn flatten [lst]
  "returns a list that has all members as a single flat list "
  (if (or (instance? list lst) (instance? tuple lst))
    (-flatten-r lst)
    (raise (TypeError "arguments to flatten must be a list or a tuple"))))

(defn -flatten-r [lst]
  "internal function called by flatten"
  (if (and (iterable? lst) (iterable? (rest lst)))
    (mapcat -flatten-r lst)
    [lst]))

(defn accumulate (coll &optional (f (fn [a b] (+ a b))))
  "Make an iterator returning accumulated sums, optionally
   f can be a binary function, and an iterator is returned by
   repeatedly applying f to the collection"
  (let [[citer (iter coll)]
	[acc (next citer)]]
    (yield acc)
    (for [it citer]
      (setv acc (f acc it))
      (yield acc))))

;; Probably need to depreciate the functions below this/ or come up
;; with something more convincing
(defmacro -concat [item &rest coll]
  "a buggy concat, works for strings and collections normally will
   break when you try something fancy in arguments like a function
   that returns a list"
  (if (all (map iterable? coll))
    `(+ ~item ~@coll)
    (macro-error coll "invalid args..must be collections")))
