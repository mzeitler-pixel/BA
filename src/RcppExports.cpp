// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// fast_factor
SEXP fast_factor(SEXP x, SEXP levs);
RcppExport SEXP corpustools_fast_factor(SEXP xSEXP, SEXP levsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type x(xSEXP);
    Rcpp::traits::input_parameter< SEXP >::type levs(levsSEXP);
    rcpp_result_gen = Rcpp::wrap(fast_factor(x, levs));
    return rcpp_result_gen;
END_RCPP
}
// proximity_hit_ids
IntegerVector proximity_hit_ids(IntegerVector pos, IntegerVector value, int n_unique, int window);
RcppExport SEXP corpustools_proximity_hit_ids(SEXP posSEXP, SEXP valueSEXP, SEXP n_uniqueSEXP, SEXP windowSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< IntegerVector >::type pos(posSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type value(valueSEXP);
    Rcpp::traits::input_parameter< int >::type n_unique(n_uniqueSEXP);
    Rcpp::traits::input_parameter< int >::type window(windowSEXP);
    rcpp_result_gen = Rcpp::wrap(proximity_hit_ids(pos, value, n_unique, window));
    return rcpp_result_gen;
END_RCPP
}
// sequence_hit_ids
IntegerVector sequence_hit_ids(IntegerVector pos, IntegerVector value, int length);
RcppExport SEXP corpustools_sequence_hit_ids(SEXP posSEXP, SEXP valueSEXP, SEXP lengthSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< IntegerVector >::type pos(posSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type value(valueSEXP);
    Rcpp::traits::input_parameter< int >::type length(lengthSEXP);
    rcpp_result_gen = Rcpp::wrap(sequence_hit_ids(pos, value, length));
    return rcpp_result_gen;
END_RCPP
}
// ngrams
CharacterVector ngrams(CharacterVector tokens, CharacterVector group, int n, std::string sep, std::string empty);
RcppExport SEXP corpustools_ngrams(SEXP tokensSEXP, SEXP groupSEXP, SEXP nSEXP, SEXP sepSEXP, SEXP emptySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< CharacterVector >::type tokens(tokensSEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type group(groupSEXP);
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< std::string >::type sep(sepSEXP);
    Rcpp::traits::input_parameter< std::string >::type empty(emptySEXP);
    rcpp_result_gen = Rcpp::wrap(ngrams(tokens, group, n, sep, empty));
    return rcpp_result_gen;
END_RCPP
}
// test
CharacterVector test(CharacterVector v);
RcppExport SEXP corpustools_test(SEXP vSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< CharacterVector >::type v(vSEXP);
    rcpp_result_gen = Rcpp::wrap(test(v));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"corpustools_fast_factor", (DL_FUNC) &corpustools_fast_factor, 2},
    {"corpustools_proximity_hit_ids", (DL_FUNC) &corpustools_proximity_hit_ids, 4},
    {"corpustools_sequence_hit_ids", (DL_FUNC) &corpustools_sequence_hit_ids, 3},
    {"corpustools_ngrams", (DL_FUNC) &corpustools_ngrams, 5},
    {"corpustools_test", (DL_FUNC) &corpustools_test, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_corpustools(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
