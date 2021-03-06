% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pipeline-helpers.R
\name{fast_left_join}
\alias{fast_left_join}
\title{Fast left join for large tables}
\usage{
fast_left_join(left, right, by)
}
\arguments{
\item{left}{The left-side table to join.  Any class inheriting from
\code{data.frame} is acceptable.}

\item{right}{The right-side table to join.  Any class inheriting from
\code{data.frame} is acceptable.}

\item{by}{Character vector of column names to join by.}
}
\value{
The left join of \code{left} and \code{right}.  It will be returned
as a \code{tbl_df}, irrespective of the type of the inputs.
}
\description{
The dplyr join functions are a little on the slow side for very large
tables.  This version converts its inputs
\code{\link[data.table]{data.table}} structures, and uses that package's
faster indexing capabilities to do a faster join.
}
\details{
Because there is some overhead associated with setting up and indexing the
data.table structures, this function is only useful when the right-side table
is big enough that the savings in the join to make up for the overhead.
Therefore, this function should only be used for joins that are demonstrably
causing bottlenecks due to the size of the tables involved.  This version
should \emph{never} be the first choice in development.  As a rule of thumb,
any join that is taking more than 500ms using the dplyr join functions is a
candidate for this function.

When using this function, be aware that data.table has some slightly
different conventions for handling duplicated columns that are not being
joined on.  Suppose we have tables \code{A} and \code{B}, both of which have
a column \code{value} that is not being joined on.  Then,
\code{AB <- dplyr::left_join(A, B)} will have columns \code{AB$value.x} with
the values from table \code{A} and \code{AB$value.y} with the values from
table \code{B}.  In \code{AB <- gcamdata::fast_left_join(A, B)}, the
corresponding columns will be \code{AB$i.value} for the values from table
\code{A}, and \code{AB$value} \emph{(sic)} for the values from table
\code{B}.  This function makes no attempt to correct the column names in the
result to conform to the dplyr convention, and is therefore not exactly a
drop-in replacement for \code{left_join}.  However, it is usually easy enough
to make corrections on the returned value.

Since this function is intended only for specialized use, we don't provide
any of the other join variants like first-only or error-no-match.  The cases
where that extra functionality is needed \emph{and} the tables involved are
too large for the slower version of join are uncommon enough that they can be
handled on a case by case basis.  (That's documentation-speak for "You're on
your own.")
}
