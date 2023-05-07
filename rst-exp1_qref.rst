
Quick reStructuredText
===================================
https://docutils.sourceforge.io/docs/user/rst/quickref.html  :
Being a cheat-sheet for reStructuredText

------------------------------------------------------------------------------

----- Inline Markup :
------------------------------------
- *emphasis*
- **strong emphasis**
- `interpreted text`
- ``inline literal``
- reference_
- `phrase reference`_
- anonymous__
- _`inline internal target`
- |substitution reference|
- |substitution-reference-1|
- footnote reference [1]_
- citation reference [CIT2002]_
- https://docutils.sourceforge.io/
- External hyperlinks, like `Python <https://www.python.org/>`_
- cross ref links as line-blocks-sec_

------------------------------------------------------------------------------

----- Escaping with Backslashes:
---------------------------------------
- *escape* ``with`` "\"
- \*escape* \``with`` "\\"

..  _line-blocks-sec:

------------------------------------------------------------------------------

----- Line Blocks :
------------------------------------
| Line blocks are useful for addresses,
| verse, and adornment-free lists.
|
| Each new line begins with a
| vertical bar ("|").
|     Line breaks and initial indents
|     are preserved.
| Continuation lines are wrapped
  portions of long lines; they begin
  with spaces in place of vertical bars.

.............................................................

----- table (simple):
------------------------------------
=====  =====  ======
  A      B    A or B
=====  =====  ======
False  False  False
True   False  True
False  True   True
True   True   True
=====  =====  ======

_________________________________________

----- Block Quotes :
------------------------------------
Block quotes are just:
    Indented paragraphs,
    line-2 Block

        and they may nest.

.............................................................

----- Literal Blocks:
_______________________
A paragraph containing only two colons indicates that the following indented or quoted text is a literal block.

::

  Whitespace, newlines, blank lines, and
  all kinds of markup (like *this* or
  \this) is preserved by literal blocks.

  The paragraph containing only '::'
  will be omitted from the result.

.....................................................


----- References / ...:
-----------------------------------------
.. |substitution reference| image::  ./python-docutils-1.png
.. |substitution-reference-1| replace::  replaced-text-1 : just placeholder/varibale-name for the final text!
.. _reference:  https://docutils.sourceforge.io/docs/user/rst/quickref.html
.. _phrase reference:  https://docutils.sourceforge.io/docs/user/rst/quickref.html
.. _reference:  https://docutils.sourceforge.io/docs/user/rst/quickref.html
.. [1] footnote-1
.. [CIT2002] "citation-2002-txt"
__ reference_

