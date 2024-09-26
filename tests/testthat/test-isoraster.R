test_that("lines works", {
  r <- rast(volcano)
  b <- isoband_terra(r)
  expect_true(inherits(b, "SpatVector"))
  expect_true(length(b$lo) > 1)

  l <- isoline_terra(r)
  expect_true(inherits(l, "SpatVector"))
  expect_true(length(l$line) > 1)




  b <- isoband_terra(r, lo = c(100, 105), hi = c(105, 115))
  expect_true(inherits(b, "SpatVector"))
  expect_true(length(b$lo) == 2L)

  l <- isoline_terra(r, c(95, 102, 150))
  expect_true(inherits(l, "SpatVector"))
  expect_true(length(l$line) == 3L)

})
