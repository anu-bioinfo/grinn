% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/formatNodeOutput.R
\name{formatNodeOutput}
\alias{formatNodeOutput}
\title{\code{formatNodeOutput} format resulting node}
\usage{
formatNodeOutput(node, returnAs)
}
\description{
Format node output for further uses by \code{fetchNode}. Retrieve also node relationships using \code{fetchNodeRelation}.
}
\seealso{
\code{fetchNode}, \code{fetchNodeRelation}
#querystring="UNWIND ['G371','G783'] AS x WITH x MATCH (node:Metabolite) WHERE lower(node.GID) = lower(x) RETURN DISTINCT node"
#node = curlRequestCypher(querystring)
#formatNodeOutput(node,returnAs="list")
}

