(string
    (string_content) @injection.content
    (#vim-match? @injection.content "^\w*SELECT|FROM|INNER JOIN|WHERE|CREATE|DROP|INSERT|UPDATE|ALTER.*$")
    (#set! injection.language "sql"))
