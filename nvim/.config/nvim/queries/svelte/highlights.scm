; inherits: html

(raw_text) @none

; Keywords
[
  "as"
  "key"
  "html"
  "snippet"
  "render"
] @keyword

"const" @keyword.modifier

[
  "if"
  "else if"
  "else"
  "then"
] @keyword.conditional

"each" @keyword.repeat

[
  "await"
  "then"
] @keyword.coroutine

"catch" @keyword.exception
"debug" @keyword.debug

; Punctuation
[
  "{"
  "}"
] @punctuation.bracket

[
  "#"
  ":"
  "/"
  "@"
] @tag.delimiter

; Identifiers and functions
(identifier) @variable
(property_identifier) @property
(call_expression function: (identifier) @function)
(call_expression function: (member_expression property: (property_identifier) @method))

; Literals
(string) @string
(number) @number
(true) @boolean
(false) @boolean
(null) @constant.builtin

; Operators
[
  "="
  "+"
  "-"
  "*"
  "/"
  "%"
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
  "&&"
  "||"
  "!"
] @operator
