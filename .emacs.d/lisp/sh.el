(defun my-eshell-prompt ()
  (let ((branch-name (git-branch-name)))
    (concat
     "\n# " (abbreviate-file-name (eshell/pwd)) " "
     (if branch-name
	 (propertize
	  (format "[%s] " branch-name) 'face `(:foreground "green"))
       "")
     "λ ")))
