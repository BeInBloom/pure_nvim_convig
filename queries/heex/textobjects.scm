;; extends

(tag) @tag.outer

(tag
  (start_tag)
  .
  (_) @tag.inner
  .
  (end_tag))

(tag
  (start_tag)
  _+ @tag.inner
  (end_tag))
