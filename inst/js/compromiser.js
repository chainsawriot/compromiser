function pos_tagging (sentences) {
    return sentences.map(text => nlp(text).pennTags({term:{normal: true}}))
}
