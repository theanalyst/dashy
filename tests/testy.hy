;; A simpler way to write examples and convert to tests
;; Almost entirely borrowed from dash.el

(import [dash.core [partition]])

(defmacro env [&rest body] `(do ~@body)) ;;bazinga

(defmacro examples [&rest body]
  `(do ~@(map assert-example (partition body 3))))

(defn assert-example [body]
  (let [[actual (car body)]
	[expected (nth body 2)]]
    `(assert (= ~actual ~expected))))

(defmacro tests [case &rest body &optional (docs "")]
  `(defn ~case []
     ~docs
     ~@body))
