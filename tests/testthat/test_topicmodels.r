test_that("topicmodels works", {
  library(corpustools)
  data(sotu_texts)

  tc = create_tcorpus(sotu_texts[1:500,], 'text', doc_column = 'id')
  tc = tc$preprocess('word', 'feature', lowercase = T, remove_punctuation = T, remove_stopwords = T, use_stemming = T, language = 'english')
  tc = tc$feature_subset('feature', subset = freq(feature) > 10 & docfreq_pct(feature) < 50)

  m = tc$lda_fit(feature = 'feature', create_feature = 'lda', K=5)
  expect_true('lda' %in% tc$feature_names)
})

