# write_str vectors

    Code
      tojson$write_str(NULL)
    Output
      [1] "{}"
    Code
      tojson$write_str(list())
    Output
      [1] "[]"
    Code
      tojson$write_str(integer())
    Output
      [1] "[]"
    Code
      tojson$write_str(double())
    Output
      [1] "[]"
    Code
      tojson$write_str(character())
    Output
      [1] "[]"
    Code
      tojson$write_str(logical())
    Output
      [1] "[]"

---

    Code
      tojson$write_str(complex())
    Condition
      Error in `j_atomic()`:
      ! Cannot convert atomic complex vectors to JSON.
    Code
      tojson$write_str(raw())
    Condition
      Error in `j_atomic()`:
      ! Cannot convert atomic raw vectors to JSON.

---

    Code
      tojson$write_str(list(1))
    Output
      [1] "[\n  1\n]"
    Code
      tojson$write_str(1L)
    Output
      [1] "1"
    Code
      tojson$write_str(1)
    Output
      [1] "1"
    Code
      tojson$write_str("foo")
    Output
      [1] "\"foo\""
    Code
      tojson$write_str(TRUE)
    Output
      [1] "true"

---

    Code
      tojson$write_str(list(1, 2))
    Output
      [1] "[\n  1,\n  2\n]"
    Code
      tojson$write_str(1:2)
    Output
      [1] "[1, 2]"
    Code
      tojson$write_str(c(1, 2))
    Output
      [1] "[1, 2]"
    Code
      tojson$write_str(c("foo", "bar"))
    Output
      [1] "[\"foo\", \"bar\"]"
    Code
      tojson$write_str(c(TRUE, FALSE))
    Output
      [1] "[true, false]"

---

    Code
      tojson$write_str(NA_integer_)
    Output
      [1] "null"
    Code
      tojson$write_str(NA_real_)
    Output
      [1] "null"
    Code
      tojson$write_str(NA_character_)
    Output
      [1] "null"
    Code
      tojson$write_str(NA)
    Output
      [1] "null"

---

    Code
      tojson$write_str(c(1L, NA_integer_))
    Output
      [1] "[1, null]"
    Code
      tojson$write_str(c(1, NA_real_))
    Output
      [1] "[1, null]"
    Code
      tojson$write_str(c("foo", NA_character_))
    Output
      [1] "[\"foo\", null]"
    Code
      tojson$write_str(c(TRUE, NA))
    Output
      [1] "[true, null]"

---

    Code
      tojson$write_str(c(a = 1L, b = 2L))
    Output
      [1] "[1, 2]"
    Code
      tojson$write_str(c(a = 1, b = 2))
    Output
      [1] "[1, 2]"
    Code
      tojson$write_str(c(a = "foo", b = "bar"))
    Output
      [1] "[\"foo\", \"bar\"]"
    Code
      tojson$write_str(c(a = TRUE, b = FALSE))
    Output
      [1] "[true, false]"

# write_str character encoding and escaping

    Code
      cat(tojson$write_str("foo\"\\bar"))
    Output
      "foo\"\\bar"
    Code
      charToRaw(tojson$write_str(iconv(utf8, "UTF-8", "latin1")))
    Output
      [1] 22 47 c3 a1 62 6f 72 22

# lists

    Code
      cat(tojson$write_str(list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9))))
    Output
      [
        [
          1,
          2,
          3
        ],
        [
          4,
          5,
          6
        ],
        [
          7,
          8,
          9
        ]
      ]

---

    Code
      cat(tojson$write_str(list(a = 1, b = 2)))
    Output
      {
        "a": 1,
        "b": 2
      }

---

    Code
      cat(tojson$write_str(list(a = list(a1 = 1, a2 = 2), b = list(b1 = 3, b2 = 4))))
    Output
      {
        "a": {
          "a1": 1,
          "a2": 2
        },
        "b": {
          "b1": 3,
          "b2": 4
        }
      }

---

    Code
      cat(tojson$write_str(list(a = list(1, a2 = 2), list(b1 = 3, 4))))
    Output
      {
        "a": {
          "1": 1,
          "a2": 2
        },
        "2": {
          "b1": 3,
          "2": 4
        }
      }

