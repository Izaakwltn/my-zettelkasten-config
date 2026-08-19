# My Zettelkasten org-mode config

This is my basic zettelkasten config, built using `org-roam`.

My config depends on two catch-all ledgers: a journal, and a reading list, for fleeting notes and media I plan to consume respectively.

Ledger/list/aggregate files can be be initialized using `M-o p <title> RET z`, and then `C-c C-c` after making any desired changes to the header.

## Setup:

Add the following to your `.emacs`, init.el, or other emacs config file

```Emacs Lisp
(add-to-list 'load-path "path/to/this/directory")

(require 'my-zettelkasten-config)
(my-zettelkasten-config-init "path/to/your/notes/directory")
```

Then initialize the journal and reading list with:

`M-o p journal RET z C-c C-c`

and

`M-o p reading-list RET z C-c C-c`

## Keymap

Commands for using zettelkasten are mapped on to `M-o`, with the following options:


| option | command | description |
|-----|------------------------|--------------------------------------------------------|
| `i` | `org-roam-node-insert` | Add a link to a node, creating one if it doesn't exist |
| `j` | `open-journal`         | Access the fleeting note journal                       |
| `l` | `open-reading-list`    | Access the reading list                                |
| `p` | `org-roam-node-find`   | Visit an existing node or capture a new one            |
| `q` | `org-mark-ring-goto`   | Go back from whence you jumped                         |
| `r` | `org-roam-node-find`   | Visit a random node                                    |
