

# A few functions and things to handle the student rosters

#' grab student names, emails and github accounts out of their email bodies
#'
#' If the students have sent a series of emails such that they can be
#' whittled into a text file that looks like:
#'
#' name: Melissa Monk
#' github: mad4moch
#' email: melissa@gmail.com
#'
#' name: Shannon Johnson
#' github: sjohnson216
#' email: sjohnson@nada.com
#'
#' name: Brian Spence
#' github: okisutch99
#' email: brian.spence@wherever.org
#'
#' Then this function will slurp that all into a data frame
#'
#' @param f the path to the file holding all the info
slurpStudents <- function(f) {
  x <- readLines(f)
  x <- x[x != ""]
  x <- matrix(x, ncol = 3, byrow = TRUE)
  x <- as.data.frame(gsub(pattern = ".*:  *", replacement = "", x), stringsAsFactors = FALSE)
  names(x) <- c("name", "github", "email")
  x
}

