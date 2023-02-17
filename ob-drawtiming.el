;;; ob-drawtiming.el --- org-babel functions for drawtiming evaluation

;; Copyright (C) 2023 Free Software Foundation, Inc.

;; Author: Fabien Perez
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org

;;; Commentary:

;; Org-Babel support for evaluating drawtiming script.

;;; Requirements:

;; drawtiming   http://drawtiming.sourceforge.net/index.html

;;; Code:
(require 'ob)

(defvar org-babel-default-header-args:drawtiming
  '((:results . "file") (:exports . "results"))
  "Default arguments for evaluating a drawtiming source block.")

(defcustom org-drawtiming-path "/usr/bin/drawtiming"
  "Path to the drawtiming executable file."
  :group 'org-babel
  :version "24.1"
  :type 'string)

(defun org-babel-execute:drawtiming (body params)
  "Execute a block of drawtiming code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((result-params (split-string (or (cdr (assoc :results params)) "")))
	 (out-file (or (cdr (assoc :file params))
		       (error "Drawtiming requires a \":file\" header argument")))
	 (cmdline (cdr (assoc :cmdline params)))
	 (in-file (org-babel-temp-file "drawtiming-"))
	 (cmd (if (string= "" org-drawtiming-path)
		  (error "`org-drawtiming-path' is not set")
		(concat (shell-quote-argument
			 (expand-file-name org-drawtiming-path))
                        " -o " out-file
                        " " in-file
                        ))))
    (unless (file-exists-p org-drawtiming-path)
      (error "Could not find drawtiming executable at %s" org-drawtiming-path))
    (with-temp-file in-file (insert body))
    (message "%s" cmd)
    (org-babel-eval cmd "")
    nil))

(provide 'ob-drawtiming)

;;; ob-drawtiming.el ends here
