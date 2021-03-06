% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fetchCorrGrinnNetwork.R
\name{fetchCorrGrinnNetwork}
\alias{fetchCorrGrinnNetwork}
\title{Compute a weighted correlation network and expand the network with information from Grinn internal database}
\usage{
fetchCorrGrinnNetwork(datX, datY, corrCoef, pval, method, returnAs, xTo, yTo, filterSource)
}
\arguments{
\item{datX}{data frame containing normalized, quantified omics data e.g. expression data, metabolite intensities. 
Columns correspond to entities e.g. genes, metabolites, and rows to samples e.g. normals, tumors. 
Require 'nodetype' at the first row to indicate the type of entities in each column. See below for details.}

\item{datY}{data frame containing normalized, quantified omics data e.g. expression data, metabolite intensities.
Use the same format as \code{datX} or it can be NULL. See below for details.}

\item{corrCoef}{numerical value to define the minimum value of absolute correlation, from 0 to 1, to include edges in the output.}

\item{pval}{numerical value to define the maximum value of pvalues, to include edges in the output.}

\item{method}{string to define which correlation is to be used. It can be one of "pearson","kendall","spearman" (default), see \code{\link{cor}}.}

\item{returnAs}{string of output type. Specify the type of the returned network. 
It can be one of "tab","json","cytoscape", default is "tab". "cytoscape" is the format used in Cytoscape.js}

\item{xTo}{string of node type. It can be one of "metabolite","protein","gene","pathway". See below for details.}

\item{yTo}{string of node type. It can be one of "metabolite","protein","gene","pathway". See below for details.}

\item{filterSource}{string or list of pathway databases. The argument is required, if \code{xTo} or \code{yTo = "pathway"}.
The argument value can be any of "SMPDB","KEGG","REACTOME" or combination of them e.g. list("KEGG","REACTOME").}
}
\value{
list of nodes and edges. The list is with the following componens: edges and nodes. Return empty list if found nothing
}
\description{
from input omics data e.g. normalized expression data or metabolomics data, it is a one step function to:

1. Compute a weighted correlation network of input omics data using WGCNA functions \code{cor} and \code{corPvalueStudent}. 
The correlation coefficients are continuous values between -1 (negative correlation) and 1 (positive correlation), with numbers close to 1 or -1, meaning very closely correlated.

2. Expand the correlation network using information from the Grinn internal database.
The nodes of the correlation network are the keywords input to query the Grinn internal database.
The Grinn internal database contains the networks of the following types that can get expanded to: 
metabolite-protein, metabolite-protein-gene, metabolite-pathway, protein-gene, protein-pathway and gene-pathway, see also \code{\link{fetchGrinnNetwork}}.
}
\details{
datX and datY are matrices in which rows are samples and columns are entities. 

If datY is given, then the correlations between the columns of datX and the columns of datY are computed.
In this case: 

- The correlation network can be expand from datX (by providing a value to \code{xTo}) or datY (by providing a value to \code{yTo}) or both entities to the specified nodetype.

Otherwise if datY is not given, the correlations of the columns of datX are computed. 
In this case:

- The correlation network can be expand from datX entites to a specific nodetype, by providing a value to \code{xTo}.

If \code{xTo} or \code{yTo} or both is given, the columns of both datX and datY are required to use grinn ids for extended queries on the Grinn internal database, see \code{\link{convertToGrinnID}} for id conversion.

If \code{xTo} = NULL and \code{yTo} = NULL, only the correlation network will be returned.
}
\examples{
# Compute a correlation network of metabolites and expand to a grinn network of metabolite-protein
dummy <- rbind(nodetype=rep("metabolite"),t(mtcars))
colnames(dummy) <- c('G1.1','G27967','G371','G4.1',paste0('G',sample(400:22000, 28)))
result <- fetchCorrGrinnNetwork(datX=dummy, corrCoef=0.7, pval=1e-12, method="spearman", returnAs="tab", xTo="protein")
library(igraph)
plot(graph.data.frame(result$edges[,1:2], directed=FALSE))
# Compute a correlation network of metabolites and proteins and expand to the grinn network of metabolite-pathway and protein-gene
dummyX <- rbind(nodetype=rep("metabolite"),t(mtcars)[,1:16])
colnames(dummyX) <- c('G1.1','G27967','G371','G4.1',paste0('G',sample(400:22000, 12)))
dummyY <- rbind(nodetype=rep("protein"),t(mtcars)[,17:32])
colnames(dummyY) <- c('P28845','P08235','Q08AG9','P80365',paste0('P',sample(10000:80000, 12)))
result <- fetchCorrGrinnNetwork(datX=dummyX, datY=dummyY, corrCoef=0.7, pval=1e-4, method="spearman", returnAs="json", xTo="pathway", yTo="gene")
}
\author{
Kwanjeera W \email{kwanich@ucdavis.edu}
}
\references{
Langfelder P. and Horvath S. (2008) WGCNA: an R package for weighted correlation network analysis. BMC Bioinformatics, 9:559

Dudoit S., Yang YH., Callow MJ. and Speed TP. (2002) Statistical methods for identifying differentially expressed genes in replicated cDNA microarray experiments, STATISTICA SINICA, 12:111

Langfelder P. and Horvath S. Tutorials for the WGCNA package \url{http://labs.genetics.ucla.edu/horvath/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/index.html}
}
\seealso{
\code{\link{cor}}, \code{\link{corPvalueStudent}}, \code{\link{fetchGrinnNetwork}}, \url{http://js.cytoscape.org/}
}

