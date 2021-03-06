# Gets rid of annoying note about "unable to verify current time".

Sys.setenv('_R_CHECK_SYSTEM_CLOCK_' = 0)

.onLoad <- function(libname, pkgname){

  # Purpose of this code is to define functions which will override their
  # equivalents from the learnr package. Then, we do the actual overriding.

  # We want to allow for 5 blank lines in text questions. This is too many for
  # things like e-mail address, but good for many other questions.

  # Got this magic from a Dan Kaplan issues filing to rstudio/learnr.

  # I don't like the rlang::`%||%` gibberish, but it made a warning about %||%
  # not being a global variable go away.

  question_ui_initialize.learnr_text <- function(question, value, ...) {
    shiny::textAreaInput(
      question$ids$answer,
      label = question$question,
      placeholder = question$options$placeholder,
      value = value,
      rows = rlang::`%||%`(question$options$nrows, 1))
  }

  # How does this next code work? I don't know! I got it from:

  # https://stackoverflow.com/questions/24331690/modify-package-function

  environment(question_ui_initialize.learnr_text) <- asNamespace('learnr')
  utils::assignInNamespace("question_ui_initialize.learnr_text",
                    question_ui_initialize.learnr_text,
                    ns = "learnr")

  # Because learnr will not export these three functions that I use, we have no
  # choice but to use ::: in order to access them. Doing do produces a NOTE when
  # we run R command check. I find that annoying. I tried just providing my own
  # copies here or in submission_functions.R, but neither seemed to work.
  # (Perhaps the problem is that they themselves use other learnr functions
  # which I don't have access to?) Anyway, I just went back and accepted the
  # NOTE.

  # I really need a way to automatically test the Submit functionality.
}
