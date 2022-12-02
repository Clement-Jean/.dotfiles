;; this code is coming from: https://github.com/magnars/s.el/blob/master/s.el

(defun s-split (separator s &optional omit-nulls)
  "Split S into substrings bounded by matches for regexp SEPARATOR.
If OMIT-NULLS is non-nil, zero-length substrings are omitted.
This is a simple wrapper around the built-in `split-string'."
  (declare (side-effect-free t))
  (save-match-data
    (split-string s separator omit-nulls)))

(defun s-split-words (s)
  "Split S into list of words."
  (declare (side-effect-free t))
  (s-split
   "[^[:word:]0-9]+"
   (let ((case-fold-search nil))
     (replace-regexp-in-string
      "\\([[:lower:]]\\)\\([[:upper:]]\\)" "\\1 \\2"
      (replace-regexp-in-string "\\([[:upper:]]\\)\\([[:upper:]][0-9[:lower:]]\\)" "\\1 \\2" s)))
   t))

(defun s-join (separator strings)
  "Join all the strings in STRINGS with SEPARATOR in between."
  (declare (pure t) (side-effect-free t))
  (mapconcat 'identity strings separator))

(defun s-snake-case (s)
  "Convert S to snake_case."
  (declare (side-effect-free t))
  (s-join "_" (mapcar 'downcase (s-split-words s))))