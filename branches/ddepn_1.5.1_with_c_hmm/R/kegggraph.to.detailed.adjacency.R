# Convert KEGGgraph graphviz object to adjacency matrix.
# 
# Author: benderc
###############################################################################


kegggraph.to.detailed.adjacency <- function(gR) {
	phi <- as(gR,"matrix")
	kedges <- edges(gR)
	for(i in 1:length(kedges)) {
		ed <- kedges[[i]]
		from <- names(kedges[i])
		if(length(ed)==0) {
			next
		}
		for(j in 1:length(ed)) {
			to <- ed[j]
			ked <- getKEGGedgeData(gR,paste(from,to,sep="~"))
			stype <- getSubtype(ked)
			if(class(stype)=="list" & length(stype)>0) {
				st <- getSubtype(ked)$subtype@name
				if(st=="inhibition") {
					if(phi[from,to]==1) {
						phi[from,to] <- 2
					}
				}
			}
		}
	}
	phi
}
