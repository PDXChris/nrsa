% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculateRelativeBedStability.R
\name{calculateRelativeBedStability}
\alias{calculateRelativeBedStability}
\title{Calculate relative bed stability metrics.}
\usage{
calculateRelativeBedStability(lsub_dmm, lsub2dmm, ltest, ldmb_bw4, ldmb_bw5,
  s_ldmb_bw5, ldcbf_g08)
}
\arguments{
\item{lsub_dmm}{mean log10(substrate diameter)}

\item{lsub2dmm}{mean log2(substrate diameter)}

\item{ltest}{critical diameter (crude)}

\item{ldmb_bw4}{critical diameter (refined) old version}

\item{ldmb_bw5}{critical diameter (refined)}

\item{s_ldmb_bw5}{critical diameter (refined) with s_rp100 rather than rp100}

\item{ldcbf_g08}{critial diameter from Kauffman 2007}
}
\value{
a matrix of relative bed stability metrics.
}
\description{
Calculates several version of relative bed stability metrics using two versions
of substrate diamter and several critical diameter versions.
}

