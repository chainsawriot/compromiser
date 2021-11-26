
<!-- README.md is generated from README.Rmd. Please edit that file -->

# compromiser

<!-- badges: start -->

<!-- badges: end -->

The goal of compromiser is to make the elegant
[compromise](https://compromise.cool/) javascript library available to
R. So, what is `compromise`? Self-described as “modest natural language
processing”, `compromise` is an extremely lightweight, easy-to-use,
rule-based NLP library for English. As of writing, the entire library is
200kB (smaller than a typical animated gif file). The library is
optimized for speed and being “accurate enough”.

Similar to the original `compromise`, compromiser is optimized for speed
and ease of use. You may know
[spacyr](https://github.com/quanteda/spacyr). The current package is
modeled after spacyr, but with speed, out-of-the-box experience and
“enough” accuracy. Similar to spacyr, all output formats are
[tif](https://github.com/ropensci/tif)-compatible.

Caveats:

  - At the moment `compromiser` does POS tagging only
  - English only
  - It won’t keep punctuations
  - It is only accurate enough for most applications. Don’t expect
    state-of-the-art performance.

## Installation

``` r
devtools::install_github("chainsawriot/compromiser")
```

## Example

Unlike spacyr, udpipe, or openNLP, no post-installation setup is
required for compromiser. You can directly go POS parsing a small
corpus.

``` r
library(compromiser)
```

``` r
textdata <- c("The dog has been selectively bred over millennia for various
 behaviors, sensory capabilities, and physical attributes. Dog breeds vary
 widely in shape, size, and color. They perform many roles for humans, such
 as hunting, herding, pulling loads, protection, assisting police and the
 military, companionship, therapy, and aiding disabled people. This influence
 on human society has given them the sobriquet of \"man's best friend.\"",
 "A methane gas explosion and fire in a Siberian coal mine left more than
 50 miners and rescuers dead. Another 239 people were rescued.")

x <- tag(textdata)
x
#> Parsed by compromiser
#> n. docs: 2 
#> n. tokens: 87
```

It gets the job done. Some tricky words are tagged incorrectly, though.
(e.g. breeds, mine)

``` r
as.data.frame(x)
#>    doc_id sent_id         token penn                               tags
#> 1   text1       1           The  WDT                         Determiner
#> 2   text1       1           dog   NN                     Noun, Singular
#> 3   text1       1           has   VB                    Verb, Auxiliary
#> 4   text1       1          been  VBD                    PastTense, Verb
#> 5   text1       1   selectively   RB                             Adverb
#> 6   text1       1          bred  VBD                    PastTense, Verb
#> 7   text1       1          over   JJ                          Adjective
#> 8   text1       1     millennia   NN                     Noun, Singular
#> 9   text1       1           for   IN                        Preposition
#> 10  text1       1       various  WDT                         Determiner
#> 11  text1       2     behaviors  NNS                       Noun, Plural
#> 12  text1       2       sensory   NN                     Singular, Noun
#> 13  text1       2  capabilities  NNS                       Plural, Noun
#> 14  text1       2           and   CC                        Conjunction
#> 15  text1       2      physical   JJ                          Adjective
#> 16  text1       2    attributes  NNS                       Noun, Plural
#> 17  text1       3           Dog   NN                     Noun, Singular
#> 18  text1       3        breeds  VBZ                 PresentTense, Verb
#> 19  text1       3          vary  VBP     Infinitive, PresentTense, Verb
#> 20  text1       4        widely   RB                             Adverb
#> 21  text1       4            in   IN                        Preposition
#> 22  text1       4         shape   NN                     Noun, Singular
#> 23  text1       4          size   NN                     Singular, Noun
#> 24  text1       4           and   CC                        Conjunction
#> 25  text1       4         color   NN                     Noun, Singular
#> 26  text1       5          They  PRP                      Pronoun, Noun
#> 27  text1       5       perform  VBP     Infinitive, PresentTense, Verb
#> 28  text1       5          many   JJ                          Adjective
#> 29  text1       5         roles  NNS                       Noun, Plural
#> 30  text1       5           for   IN                        Preposition
#> 31  text1       5        humans  NNS                       Noun, Plural
#> 32  text1       5          such   RB                             Adverb
#> 33  text1       6            as   IN                        Preposition
#> 34  text1       6       hunting  VBG         Gerund, PresentTense, Verb
#> 35  text1       6       herding  VBG         Gerund, PresentTense, Verb
#> 36  text1       6       pulling  VBG         Gerund, PresentTense, Verb
#> 37  text1       6         loads  VBZ                 PresentTense, Verb
#> 38  text1       6    protection   NN                     Singular, Noun
#> 39  text1       6     assisting  VBG         Gerund, PresentTense, Verb
#> 40  text1       6        police  NNS                       Noun, Plural
#> 41  text1       6           and   CC                        Conjunction
#> 42  text1       6           the  WDT                         Determiner
#> 43  text1       7      military   JJ                          Adjective
#> 44  text1       7 companionship   NN                     Noun, Singular
#> 45  text1       7       therapy   NN                     Noun, Singular
#> 46  text1       7           and   CC                        Conjunction
#> 47  text1       7        aiding   NN                               Noun
#> 48  text1       7      disabled  VBD                    PastTense, Verb
#> 49  text1       7        people  NNS                       Plural, Noun
#> 50  text1       8          This  WDT                         Determiner
#> 51  text1       8     influence  VBP     Infinitive, PresentTense, Verb
#> 52  text1       9            on   IN                        Preposition
#> 53  text1       9         human   NN                     Noun, Singular
#> 54  text1       9       society   NN                     Noun, Singular
#> 55  text1       9           has   VB                               Verb
#> 56  text1       9         given   VB                               Verb
#> 57  text1       9          them  PRP                      Pronoun, Noun
#> 58  text1       9           the  WDT                         Determiner
#> 59  text1       9     sobriquet   NN                     Noun, Singular
#> 60  text1       9            of   IN                        Preposition
#> 61  text1       9         man's   NN         Singular, Noun, Possessive
#> 62  text1       9          best   JJ                          Adjective
#> 63  text1       9        friend   NN                     Singular, Noun
#> 64  text2       1             A  WDT                         Determiner
#> 65  text2       1       methane   NN                     Noun, Singular
#> 66  text2       1           gas   NN                     Noun, Singular
#> 67  text2       1     explosion   NN                     Noun, Singular
#> 68  text2       1           and   CC                        Conjunction
#> 69  text2       1          fire   NN                     Noun, Singular
#> 70  text2       1            in   IN                        Preposition
#> 71  text2       1             a  WDT                         Determiner
#> 72  text2       1      Siberian  NNP         ProperNoun, Noun, Singular
#> 73  text2       1          coal   NN                  Uncountable, Noun
#> 74  text2       1          mine  POS         Possessive, Noun, Singular
#> 75  text2       1          left  VBD                    PastTense, Verb
#> 76  text2       1          more   RB                             Adverb
#> 77  text2       1          than   IN                        Preposition
#> 78  text2       2            50   CD      Cardinal, Value, NumericValue
#> 79  text2       2        miners  NNS                       Noun, Plural
#> 80  text2       2           and   CC                        Conjunction
#> 81  text2       2      rescuers  NNS                       Noun, Plural
#> 82  text2       2          dead   JJ              Comparable, Adjective
#> 83  text2       3       Another  WDT                         Determiner
#> 84  text2       3           239   CD      Cardinal, Value, NumericValue
#> 85  text2       3        people  NNS                       Plural, Noun
#> 86  text2       3          were   VB Copula, Verb, PastTense, Auxiliary
#> 87  text2       3       rescued  VBD                    PastTense, Verb
```

# Integration with quanteda

``` r
library(quanteda)
```

Conversion to Quanteda’s tokens.

``` r
x_toks <- as.tokens(x)
x_toks
#> Tokens consisting of 2 documents.
#> text1 :
#>  [1] "The/WDT"        "dog/NN"         "has/VB"         "been/VBD"      
#>  [5] "selectively/RB" "bred/VBD"       "over/JJ"        "millennia/NN"  
#>  [9] "for/IN"         "various/WDT"    "behaviors/NNS"  "sensory/NN"    
#> [ ... and 51 more ]
#> 
#> text2 :
#>  [1] "A/WDT"        "methane/NN"   "gas/NN"       "explosion/NN" "and/CC"      
#>  [6] "fire/NN"      "in/IN"        "a/WDT"        "Siberian/NNP" "coal/NN"     
#> [11] "mine/POS"     "left/VBD"    
#> [ ... and 12 more ]
```

Suppose you are only interested in nouns and adjectives.

``` r
tokens_select(x_toks, pattern = c("*/N*", "*/JJ"))
#> Tokens consisting of 2 documents.
#> text1 :
#>  [1] "dog/NN"           "over/JJ"          "millennia/NN"     "behaviors/NNS"   
#>  [5] "sensory/NN"       "capabilities/NNS" "physical/JJ"      "attributes/NNS"  
#>  [9] "Dog/NN"           "shape/NN"         "size/NN"          "color/NN"        
#> [ ... and 16 more ]
#> 
#> text2 :
#>  [1] "methane/NN"   "gas/NN"       "explosion/NN" "fire/NN"      "Siberian/NNP"
#>  [6] "coal/NN"      "miners/NNS"   "rescuers/NNS" "dead/JJ"      "people/NNS"
```

# Integration with tidytext

I don’t care.
