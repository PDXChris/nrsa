% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculateHumanInfluence.r
\name{calculateBankHardening}
\alias{calculateBankHardening}
\title{Calculates a bank hardening metric for City of Portland use.}
\usage{
calculateBankHardening(uid, transect, plot, parameter, result)
}
\arguments{
\item{uid}{a vector that differentiates among sites or site visits.}

\item{transect}{a vector of transect indicators}

\item{plot}{a vector of transect direction indicators}

\item{parameter}{a vector of parameter names for the 11 human influence parameters}

\item{result}{a vector of results 0 (not present), P (present > 10 m), 
C (present < 10 m), B (present on bank)}
}
\description{
Calculates a bank hardening metric for City of Portland use.  The percentage of bank
where either bldg, pave, wall, or road are marked 'B' is calculated.
}

