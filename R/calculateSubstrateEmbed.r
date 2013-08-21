calculateSubstrateEmbed <- function(uid, embed, is.center){
  #'Calculates Substrate Embeddedness metrics
  #'\code{calculateSubstrateEmbed} calculates substrate embeddedness metrics:
  #'N33, N55, VCEMBED, VEMBED, XCEMBED, XEMBED.
  #'@param uid a vector of site-visit indicators
  #'@param embed a vector of embeddedness values
  #'@param is.center a logical vector describing whether the embeddedness
  #'is from a center point
  #'@export
  #'@importFrom plyr ddply summarize '.'
  if (is.character(embed) || is.factor(embed)){
    embed <- as.numeric(as.character(embed))
  }
  x <- data.frame(uid = uid, is.center = is.center, embed = embed)
  met1 <- ddply(x, .(uid), summarize, 
                n55    = count(embed), 
                xembed = mean(embed, na.rm = T), 
                vembed = sd(embed, na.rm = T))
  cx <- subset(x, x$is.center)
  met2 <- ddply(cx, .(uid), summarize, 
                n33     = count(embed), 
                xcembed = mean(embed, na.rm = T), 
                vcembed = sd(embed, na.rm = T))
  met <- merge(met1, met2, by = 'uid', all = T)
  progressReport('Finished calculating substrate embeddedness metrics.')
  return(met)
}