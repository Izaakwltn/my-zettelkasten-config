;;;; zettelkasten-config.el
;;;;
;;;;

(require 'package)

(unless (package-installed-p 'org-roam)
  (package-install 'org-roam))

(require 'org-roam)

;;;
;;; Zettelkasten structure:
;;;
;;; Fleeting notes (collected in journal.org):
;;; - spur of the moment notes, scattered brainstorms, and as I read notes
;;; - this will be processed and turned into permanent or literature notes
;;; - fleeting notes will be collected in a number of sources
;;;
;;; reading-list:
;;; - books (or other media) I'm interested in reading
;;; - entered with basic metadata and a synopsis of what it is why I'm curious
;;;
;;; Literature notes:
;;; - notes on books/sources I have at least inspected Adler-style, if not read in full
;;;
;;; Permanent notes:
;;; - atomic, personal ideas, interconnected with other notes

(setq org-roam-capture-templates
      '((";" "jot a note in the journal" entry
	 "* ${title} %U\n %i\n %a\n\n\n%?"
	 ;; Make sure to define a permanent note "journal" first
	 :target (node "journal")
	 :unnarrowed t
	 :prepend t
	 :empty-lines 3)
	("k" "add to reading list" entry
	 "* ${title}\nEntered:%U\n %i\n** Metadata:\n- Title:\n- Medium:\n- Author(s):\n- Date of Publication:\n- Subject(s):\n- Link/Source:\n\n** Blurb:\n%?"
	 ;; Make sure to define a permanent note "reading-list" first
	 :target (node "reading-list")
	 :unnarrowed t
	 :prepend t
	 :empty-lines 5)
	("l" "literature" plain "%?"
	 :target (file+head "literature-%<%Y%m%d%H%M%S>-${slug}.org"
			    "#+title: ${title}\n#+date: %U\n %i\n\n* Metadata:\n- Title\n- Medium:\n- Author(s):\n- Date of Publication:\n- Subject(s):\n- Link/Source:\n\n\n* Notes:\n")
	 :unnarrowed t)
	("p" "permanent" plain "%?"
	 :target (file+head "permanent-%<%Y%m%d%H%M%S>-${slug}.org"
			    "#+title: ${title}\n\n")
	 :unnarrowed t)
	("z" "initialize top level entry-ledger (journal, reading list, etc)" plain "%?"
	 :target (file+head "${slug}.org"
			    "#+title: ${title}\n\n A ledger file for entries.")
	 :unnarrowed t)))

;; TODO: Eventually I'd like to hack an initialization for journal and reading-list 

(defun open-journal ()
  "Open journal/peruse fleeting notes."
  (interactive)
  (find-file (expand-file-name "journal.org" org-roam-directory)))

(defun open-reading-list ()
  "Open journal/peruse fleeting notes."
  (interactive)
  (find-file (expand-file-name "reading-list.org" org-roam-directory)))

;;;
;;;
;;;

(defvar *zettelkasten-keybindings*
  '((i . org-roam-node-insert)
    (j . open-journal)
    (l . open-reading-list)
    ;; visit an existing node or capture a new one
    (p . org-roam-node-find)
    ;; Go back from whence you jumped to a node
    (q . org-mark-ring-goto)
    (r . org-roam-node-random)))

(defvar *zettelkasten-leader-map* (make-sparse-keymap))
(define-prefix-command 'zettelkasten-leader-map)
(global-set-key (kbd "M-o") zettelkasten-leader-map)

(defun zettelkasten-keybind (key-pair)
  (define-key zettelkasten-leader-map
	      (kbd (symbol-name (car key-pair)))
	      (cdr key-pair)))

;;;
;;; Initialization
;;;

(defun my-zettelkasten-config-init (zettelkasten-directory &optional buffer-sections)

  (setq org-roam-directory zettelkasten-directory)
  
  ;; Personal taste
  (setq org-hide-emphasis-markers t)

  (org-roam-db-autosync-mode)

  (setq org-roam-database-connector 'sqlite3)

  (setq org-roam-mode-sections
	(or buffer-sections
	    (list #'org-roam-backlinks-section
		  #'org-roam-reflinks-section)))
  
  (mapc #'zettelkasten-keybind *zettelkasten-keybindings*))

(provide 'my-zettelkasten-config)


