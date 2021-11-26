ct <- NULL
.onLoad <- function(libname, pkgname) {
    ct <<- V8::v8()
    rubbish <- ct$source(system.file("js", "compromise.min.js", package = "compromiser"))
    rubbish <- ct$source(system.file("js", "compromise-penn-tags.min.js", package = "compromiser"))
    ct$eval("nlp.extend(compromisePennTags)")
    rubbish <- ct$source(system.file("js", "compromiser.js", package = "compromiser"))
    vctrs::s3_register("quanteda::as.tokens", "compromiser", as.tokens.compromiser)
}

#' @export
tag <- function(x) {
    doc_id <- names(x)
    if (is.null(doc_id)) {
        ## quanteda style default docid
        doc_id <- paste0("text", seq_along(x))
    }
    if (length(x) == 1) {
        x <- list(x) ### To prevent V8 to be "too smart"
    }
    res <- list()
    res$pos <- ct$call("pos_tagging", x)
    res$doc_id <- doc_id
    class(res) <- "compromiser"
    return(res)
}

## dealing with one pos, e.g. x$pos[[1]]
.pos_res_to_df <- function(x, doc_id) {
    res <- purrr::map2_dfr(.x = x$terms, .y = seq_along(x$terms), .f = .conv)
    colnames(res)[which(colnames(res) == "text")] <- "token"
    res$doc_id <- doc_id
    return(dplyr::relocate(res, "doc_id"))
}

.conv <- function(x, sent_id) {
    res <- dplyr::bind_rows(x)
    res$sent_id <- sent_id
    return(dplyr::relocate(res, "sent_id"))
}

.as_ <- function(x, v = .pos_res_to_df) {
    purrr::map2_dfr(x$pos, x$doc_id, v)
}

#' @method as.data.frame compromiser
#' @export
as.data.frame.compromiser <- function(x, ...) {
    return(.as_(x))
}


.cal_ntokens <- function(x) {
    ntokens <- purrr::map_int(x$pos, ~ sum(purrr::map_int(.$terms, nrow)))
    return(sum(ntokens))
}

.pos_res_to_vec <- function(x) {
    res <- purrr::map2_dfr(.x = x$terms, .y = seq_along(x$terms), .f = .conv)
    vec <- paste0(res$text, "/", res$penn)
    return(vec)
}

#' @method print compromiser
#' @export
print.compromiser <- function(x, ...) {
    cat("Parsed by compromiser\n")
    cat("n. docs:", length(x$doc_id), "\n")
    cat("n. tokens:", .cal_ntokens(x), "\n")
}

#' @export
as.tokens.compromiser <- function(x, ...) {
    res <- purrr::map(x$pos, .pos_res_to_vec)
    names(res) <- x$doc_id
    res <- quanteda::as.tokens(res)
    return(res)
}
