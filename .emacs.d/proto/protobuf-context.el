(defun protobuf-at-file-level()
  (cond
   ((eq (c-where-wrt-brace-construct) 'outwith-function) t)
   (t nil)))

(defun protobuf-in-class(keyword)
  (cond
   ; check if keyword is not in c-class-decl-kwds
   ; in this case return null
   ((not (member keyword (c-lang-const c-class-decl-kwds)))
    ;(message "keyword not defined in classes: %s" keyword)
    nil)
   ; if we are in block
   ((eq (c-where-wrt-brace-construct) 'in-block)
    (setq tmp (point)) ; save current point
    (backward-word) ; go before snippet
    (c-beginning-of-defun) ; go to the beginning of declaration
    (setq res (looking-at keyword))
    (goto-char tmp) ; go back to previous point
    res))) ; check if we are looking at $keyword

(defun protobuf-not-repeated()
  (backward-word) ; go before snippet
  (backward-word) ; go to repeated or other
  (not (looking-at "repeated")))

(defun protobuf-conditional-expand()
  (cond ((looking-at ";")
	 "[deprecated = true]")
	(t "option deprecated = true;")))
