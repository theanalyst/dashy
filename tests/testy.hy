(import [dash.core [partition]])

(defmacro env [&rest body] `(do ~@body)) ;;bazinga

;;FIXME bro
(defmacro examples [&rest body]
  `(do ~@(map 'assert-example (partition body 3))))

(defmacro assert-example [&rest body]
  (let [[actual (car body)]
	[expected (nth body 2)]]
    `(assert (= ~actual ~expected))))

(defmacro tests [case &rest body &optional (docs "")]
  `(defn ~case []
     ~docs
     ~@body))
