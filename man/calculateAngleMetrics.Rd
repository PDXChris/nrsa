% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculateSlopeBearing.R
\name{calculateAngleMetrics}
\alias{calculateAngleMetrics}
\alias{calculateSlopeMetrics}
\alias{calculateTransectSpacing}
\title{Calculate slope and bearing metrics}
\usage{
calculateAngleMetrics(uid, azimuth, distance)

calculateSlopeMetrics(uid, transect, slope, proportion)

calculateTransectSpacing(uid, transpc)
}
\description{
Functions for calculating slope and bearing metrics from NRSA protocol channel
geometry data.  The metrics calculated are: xbearing, sinu, xslope, vslope, nslope.
}
\details{
The general strategy for calculationg slope and bearing metrics using these functions is:
\enumerate{
   \item Calculate transect spacing for wadeable as: \code{increment * nWadeableStationsPerTransect}
   \item Calculate wadeable distance for each slope/bearing as \code{transp * proportion}
   \item Calculate boatable transect spacing as \code{sum(distance)} and proportion as \code{distance / sum(distance)}
   \item Calculate grade (as percent) from boatable elevation change measurements in centimeters, if applicable.
   \item Calculate angle metrics using \code{calculateAngleMetrics}
   \item Calculate slope metrics using \code{calculateSlopeMetrics}
 }
 The overall working of \code{calculateAngleMetrics} differs somewhat than the
 EPA code.  EPA calculated total distances East and North at each transect,
 then summed to get the total distance East and North for the site.  \code{calculateAngleMetrics}
 treats the channel geometry as a single line string and calculates the length
 of the line string and the distance from the first to last point.  It calculates
 xbearing as the azimuth between the first and last points.
 
Function calculateTransectSpacing calculates the transect spacing. These should be the same for every transect. 
But for some sites, it's possible to get discrepancies between
transects because of numerical issues. In that case the transect spacing 
won't be exactly the same at every transect. For that reason,
we take the mean of the the transect spacing values for the site.
 
 @param uid a vector of site identifiers
 @param transect a vector of transect identifiers
 @param azimuth a vector of bearings; more properly azimuths
 @param distance a vector of distances
 @param transpc a vector of transect spacing values
 @export
 @import plyr
 @examples
 d <- data.frame(uid = c(1,1), azimuth = c(180,90), distance = c(1,1))
 calculateAngleMetrics(d$uid, d$azimuth, d$distance)
 d <- data.frame(uid = rep(1,6), transect = rep(1:2,each = 3),
                 slope = rep(c(10, 20, 30), 2), proportion = rep(1,6) / 3)
 with(d, calculateSlopeMetrics(uid, transect, slope, proportion))
}

