# valStructLittoral.r
#
# 09/24/09 cws Created valStructChancov
# 10/06/09  SSR adapted for tblLITTORAL2
# 10/22/09 cws Added unit test.  Modified structure check to correct uniqueness
#          check and only allow main channel transects.
# 11/06/09  mrc - changed parameter values BOTTOMDOM and BOTTOMSEC to reflect
#           a real change in parameter values
#  2/22/10 cws Removed UNITS column from dataframe in unit test.
#  2/25/10 cws moved source() calls to NRSAvalidation.r
#

# Contains functions valStructLittoral 

require(RODBC)
#intermediateMessages <- TRUE

valStructLittoral <- function(df, test='all')
# Performs structure checks on the NRSA table tblLITTORAL2.  Returns NULL if
# no errors have been found, or an Nx1 character matrix describing the detected
# errors.
#
# ARGUMENTS:
# df        dataframe of NRSA littoral data
# test      String describing which tests to perform.  May be one of the
#             following:
#             'all'       default, performs all tests
#             'vital'     performs only vital tests
#             'nonvital'  performs only nonvital tests
#             'synopsis'  performs all tests, returning counts of detected
#                           errors for all tests
#
# ASSUMPTIONS:
#
{
  intermediateMessage('Structure validation of littoral data ', loc='start')
  
  probs <- NULL

  # sanity checks
  if(!(test %in% c('all', 'vital', 'nonvital', 'synopsis'))) {
      probs<-"Error: test argument must be 'all', 'vital', 'nonvital' or 'synopsis'"
      return(as.matrix(probs))
  }
  
  # Check for correct column names no matter what, and stop early if there
  # are any errors, since nothing else will work without them
  intermediateMessage('.1')
  probs <- stValColumnPresence(df, c('UID', 'TRANSECT'
                                    ,'PARAMETER', 'RESULT', 'FLAG'
                                    ,'SAMPLE_TYPE'
                                    )
                              )
  if(!is.null(probs)) {
      colnames(probs)[1] <-'User.MUST.fix.these.errors.before.proceding'
      intermediateMessage('.  Done (terminated early).', loc='end')
      return(probs)
  }
  
  #  Perform 'vital' tests if requested
  if(test %in% c('all','vital','synopsis')) {

      # Check for missing UID values
      intermediateMessage('.2')
      pp <- stValMissingValues(df, 'UID')
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,ifelse(is.null(pp)
                               ,"No Missing UID values"
                               ,"Missing UID values exist (vital)"
                               )
                        )
      } else {
          probs <- rbind(probs, pp)
      }

      
      # Check for missing TRANSECT values
      intermediateMessage('.3')
      pp <- stValMissingValues(df, 'TRANSECT')
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,ifelse(is.null(pp)
                               ,"No Missing TRANSECT values"
                               ,"Missing TRANSECT values exist (vital)"
                               )
                        )
      } else {
          probs <- rbind(probs, pp)
      }


      # Check for missing PARAMETER values
      intermediateMessage('.4')
      pp <- stValMissingValues(df, 'PARAMETER')
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,ifelse(is.null(pp)
                               ,"No Missing PARAMETER values"
                               ,"Missing PARAMETER values exist (vital)"
                               )
                        )
      } else {
          probs <- rbind(probs, pp)
      }


      # Check for missing SAMPLE_TYPE values
      intermediateMessage('.5')
      pp <- stValMissingValues(df, 'SAMPLE_TYPE')
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,ifelse(is.null(pp)
                               ,"No Missing SAMPLE_TYPE values"
                               ,"Missing SAMPLE_TYPE values exist (vital)"
                               )
                        )
      } else {
          probs <- rbind(probs, pp)
      }


      # Check for unexpected TRANSECT values in Rivers
      intermediateMessage('.6')
      pp <- stValUnexpectedValues(df, 'TRANSECT'
                                 ,c('A','B','C','D','E','F','G','H','I','J','K'
                                   )
                                 ,'UID'
                                 )
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,sprintf("Unexpected TRANSECT values: %d (vital)"
                                ,ifelse(is.null(pp), 0, nrow(pp))
                                )
                        )
      } else {
          probs <- rbind(probs, pp)
      }


      # Check for uniqueness of each UID-TRANSECT-PARAMETER
      intermediateMessage('.7')
      pp <- stValCountRows(df, c('UID','TRANSECT','PARAMETER'), 1)
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,sprintf("Duplicate UID-TRANSECT values: %d (vital)"
                                ,ifelse(is.null(pp), 0, nrow(pp))
                                )
                        )
      } else {
          probs <- rbind(probs, pp)
      }


  }
  
  # Perform nonvital tests if requested
  if(test %in% c('all','nonvital','synopsis')) {

      # Check for absent TRANSECT values at each UID
      intermediateMessage('.8')
      pp <- stValAbsentValues(df, 'TRANSECT'
                             ,c('A','B','C','D','E','F','G','H','I','J','K')
                             ,'UID'
                             )
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,sprintf("Absent TRANSECT values: %d"
                                ,ifelse(is.null(pp), 0, nrow(pp))
                                )
                        )
      } else {
          probs <- rbind(probs, pp)
      }

      # Check for unexpected PARAMETER values
      intermediateMessage('.9')
      pp <- stValUnexpectedValues(df
                                 ,'PARAMETER'
                                 ,c('BOTTOMDOM', 'BOTTOMSEC', 'SHOREDOM',
                                    'SHORESEC', 'SUBOBS')
                                 ,c('UID', 'TRANSECT')
                                 )
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,sprintf("Unexpected PARAMETER values: %d"
                                ,ifelse(is.null(pp), 0, nrow(pp))
                                )
                        )
      } else {
          probs <- rbind(probs, pp)
      }

      # Check for absent PARAMETER values
      intermediateMessage('.10')
      pp <- stValAbsentValues(df
                                 ,'PARAMETER'
                                 ,c('BOTTOMDOM', 'BOTTOMSEC', 'SHOREDOM',
                                    'SHORESEC', 'SUBOBS')
                                 ,c('UID', 'TRANSECT')
                                 )
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,sprintf("Absent PARAMETER values: %d"
                                ,ifelse(is.null(pp), 0, nrow(pp))
                                )
                        )
      } else {
          probs <- rbind(probs, pp)
      }

      # Check for unexpected values of SAMPLE_TYPE.
      intermediateMessage('.11')
      pp <- stValUnexpectedValues(df
                                 ,'SAMPLE_TYPE'
                                 ,c('PHAB_CHANBFRONT')
                                 ,c('UID', 'TRANSECT','PARAMETER')
                                 )
      if(test=='synopsis') {
          probs <- rbind(probs
                        ,sprintf("Unexpected SAMPLE_TYPE values: %d"
                                ,ifelse(is.null(pp), 0, nrow(pp))
                                )
                        )
      } else {
          probs <- rbind(probs, pp)
      }


  }

  intermediateMessage('.  Done', loc='end')
  return(probs)

}
