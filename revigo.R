#' Run Revigo to produce Gene Ontology Treemap
#'
#' @param GOs character vector of GO Ids, required
#' @param pvals numeric vector of p-values for each GO Id (same length as GOs), required
#' @param cutoff revigo simialrity threshold allowed values: "0.90" "0.70" "0.50" "0.40", default set at 0.4
#' @param organism string describing organism based on the list provided below, default "whole UniProt"
#' @param isPValue string value of "yes" or "no", defaukt set to yes
#' @param whatIsBetter string value of "higher" "lower" "absolute" "abs_log", defaults to "higher"
#' @param measure string value of similarity measure "RESNIK" "LIN" "SIMREL" "JIANG", default "SIMREL"
#' @export
#' @examples
#' runRevigo((GOs =NULL, pvals=NULL, cutoff = 0.5, organism = "whole UniProt", isPValue="yes", whatIsBetter="higher", measure="SIMREL"))


runRevigo <- function(GOs =NULL, pvals=NULL, cutoff = 0.5, organism = "whole UniProt", 
                      isPValue="yes", whatIsBetter="higher", measure="SIMREL"){

organism.list <- list(
  "whole UniProt"=0, 
  "Homo sapiens"=9606,
  "Mus musculus"=10090,
  "Rattus norvegicus"=10116,
  "Bos taurus"=9913,
  "Gallus gallus"=9031,
  "Danio rerio"=7955,
  "Takifugu rubripes"=31033,
  "Xenopus laevis"=8355,
  "Drosophila melanogaster"=7227,
  "Caenorhabditis elegans"=6239,
  "Arabidopsis thaliana"=3702,
  "Oryza sativa"=39947,
  "Zea mays"=4577,
  "Saccharomyces cerevisiae"=4932,
  "Schizosaccharomyces pombe"=4896,
  "Dictyostelium discoideum"=44689,
  "Plasmodium falciparum"=5833,
  "Chlamydomonas reinhardtii"=3055,
  "Escherichia coli"=83333,
  "Bacillus subtilis"=1423,
  "Pseudomonas aeruginosa"=287,
  "Mycobacterium tuberculosis"=1773,
  "Mycoplasma genitalium"=2097,
  "Synechocystis sp."=1148
)
organism.db <- as.character(organism.list[organism])

mycommand  <- paste('revigo.pl -goterms', paste(GOs,collapse=","), 
                    '-gopvals', paste(pvals,collapse=","), 
                    '-cutoff', cutoff,  
                    '-organism', organism.db, 
                    '-ispvalue', isPValue, 
                    '-whatisbetter', whatIsBetter, 
                    '-measure', measure, sep=" ")

mytempfile <- tempfile()
system2(command='perl', args=mycommand, stdout=mytempfile)
source(mytempfile)

}
