#' Create a tCorpus using udpipe
#'
#' This is simply shorthand for using create_tcorpus with the udpipe_ arguments and certain specific settings.
#' This is the way to create a tCorpus if you want to use the syntax analysis functionalities.
#'
#' @rdname udpipe_tcorpus
#'
#' @param x           main input. can be a character (or factor) vector where each value is a full text, or a data.frame that has a column that contains full texts.
#' @param meta        A data.frame with document meta information (e.g., date, source). The rows of the data.frame need to match the values of x
#' @param model       Optionally, the name of a Universal Dependencies language model (e.g., "english-ewt", "dutch-alpino"), to use the udpipe package
#'                     (\code{\link[udpipe]{udpipe_annotate}}) for natural language processing. You can use \code{\link{show_udpipe_models}} to get
#'                     an overview of the available models. For more information about udpipe and performance benchmarks of the UD models, see the
#'                     GitHub page of the \href{https://github.com/bnosac/udpipe}{udpipe package}.
#' @param max_tokens An integer. Limits the number of tokens per document to the specified number
#' @param max_sentences An integer. Limits the number of sentences per document to the specified number. If set when split_sentences == FALSE, split_sentences will be set to TRUE.
#' @param doc_id      if x is a character/factor vector, doc_id can be used to specify document ids. This has to be a vector of the same length as x
#' @param doc_column  If x is a data.frame, this specifies the column with the document ids.
#' @param text_columns if x is a data.frame, this specifies the column(s) that contains text. The texts are paste together in the order specified here.
#' @param feats       Optionally, a character vector of additional features (options: Case, Definite, Degree, Gender, Mood, NumType, Number, Person, Poss, PronType, Reflex, Tense, Typo, VerbForm, Voice) to include in the tokens data. Default is none. Can also use 'all' to get all features. 
#' @param model_path  If udpipe_model is used, this path wil be used to look for the model, and if the model doesn't yet exist it will be downloaded to this location. Defaults to working directory
#' @param cache       The number of persistent caches to keep for inputs of udpipe. The caches store tokens in batches.
#'                          This way, if a lot of data has to be parsed, or if R crashes, udpipe can continue from the latest batch instead of start over.
#'                          The caches are stored in the udpipe_models folder (in udpipe_model_path). Only the most recent [udpipe_caches] caches will be stored.
#' @param cores       If udpipe_model is used, this sets the number of parallel cores.
#' @param batchsize   In order to report progress and cache results, texts are parsed with udpipe in batches of 50.
#'                          The price is that there will be some overhead for each batch, so for very large jobs it can be faster to increase the batchsize.
#'                          If the number of texts divided by the number of parallel cores is lower than the batchsize, the texts are evenly distributed over cores.
#' @param use_parser  If TRUE, use dependency parser (only if udpipe_model is used)
#' @param verbose     If TRUE, report progress. Only if x is large enough to require multiple sequential batches
#' @param ...         Arguments passed to create_tcorpus.character
#'
#' @export
#' @name create_tcorpus
#' @examples
#' ## ...
udpipe_tcorpus <- function(x, ...) {
  UseMethod('udpipe_tcorpus')
}

#' @rdname udpipe_tcorpus
#' @examples
#' \donttest{
#' tc = udpipe_tcorpus(c('Text one first sentence. Text one second sentence', 'Text two'), model = 'english-ewt', cores=4)
#' tc$tokens
#' }
#' @export
udpipe_tcorpus.character <- function(x, doc_id=1:length(x), model, meta=NULL, max_sentences=NULL, max_tokens=NULL, feats=NULL, model_path=getwd(), cache=3, cores=1, batchsize=50, use_parser=T, verbose=T, ...) {
  if (is.null(model)) stop('model cannot be NULL')
  tc = create_tcorpus(x=x, doc_id=doc_id, meta=meta, udpipe_model=model, max_sentences=max_sentences, max_tokens=max_tokens, udpipe_model_path=model_path, udpipe_cache=cache, udpipe_cores=cores, udpipe_batchsize=batchsize, use_parse=use_parser, verbose=verbose, remember_spaces=T, ...)
  if (is.null(feats)) {
    tc$tokens$feats = NULL
    } else {
      if (feats == 'all')
        tc = tc$feats_to_columns()
      else
        tc = tc$feats_to_columns(feats)
    }
  tc
}

#' @rdname udpipe_tcorpus
#' @examples
#' \donttest{
#' tc = udpipe_tcorpus(sotu_texts, doc_column='id', model = 'english-ewt', cores=4)
#' tc$tokens
#' }
#' @export
udpipe_tcorpus.data.frame <- function(x, model, text_columns='text', doc_column='doc_id', max_sentences=NULL, max_tokens=NULL, feats=NULL, model_path=getwd(), cache=3, cores=1, batchsize=50, use_parser=T, verbose=T, ...) {
  if (is.null(model)) stop('model cannot be NULL')
  create_tcorpus(x=x, text_columns=text_columns, doc_column=doc_column, udpipe_model=model, max_sentences=max_sentences, max_tokens=max_tokens, udpipe_model_path=model_path, udpipe_cache=cache, udpipe_cores=cores, udpipe_batchsize=batchsize, use_parse=use_parser, verbose=verbose, remember_spaces=T, ...)
  if (is.null(feats)) {
    tc$tokens$feats = NULL
  } else {
    if (feats == 'all')
      tc = tc$feats_to_columns()
    else
      tc = tc$feats_to_columns(feats)
  }
  tc
}

#' @rdname udpipe_tcorpus
#' @examples
#' ## It makes little sense to have full texts as factors, but it tends to happen.
#' ## The create_tcorpus S3 method for factors is essentially identical to the
#' ##  method for a character vector.
#' text = factor(c('Text one first sentence', 'Text one second sentence'))
#' \donttest{
#' tc = udpipe_tcorpus(text, 'english-ewt-', cores=2)
#' tc$tokens
#' }
#' @export
create_tcorpus.factor <- function(x, ...) {
  create_tcorpus(as.character(x), ...)
}

#' @rdname create_tcorpus
#' @examples
#'
#' library(quanteda)
#' \donttest{
#' create_tcorpus(data_corpus_inaugural, 'english-ewt', cores=2)
#' }
#' @export
create_tcorpus.corpus <- function(x, ...) {
  x = quanteda::convert(x, 'data.frame')
  create_tcorpus(x, text_columns='text', doc_column='doc_id', ...)
}