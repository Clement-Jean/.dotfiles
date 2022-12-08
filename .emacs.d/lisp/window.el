(defun my-default-window-setup ()
  "Called by emacs-startup-hook to set up the initial window config."
  (split-window-right)
  (other-window 1)
  (find-file "~/todo.org")
  (other-window 1))

(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(defun bury-compile-buffer-if-successful (buffer string)
 "Bury a compilation buffer if succeeded without warnings "
 (when (and
         (buffer-live-p buffer)
         (string-match "compilation" (buffer-name buffer))
         (string-match "finished" string)
         (not
          (with-current-buffer buffer
            (goto-char (point-min))
            (search-forward "warning" nil t))))
    (run-with-timer 1 nil
                    (lambda (buf)
                      (bury-buffer buf)
		      (delete-window)
                      (switch-to-prev-buffer (get-buffer-window buf) 'kill))
                    buffer)))
