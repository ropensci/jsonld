function setTimeout(fun){
  fun();
}

/* V8 does not have network support, so we call back to R */
jsonld.documentLoaders.curl = function(options){
  function loader(url, callback){
    var res = console.r.call('jsonld:::download', {url : url});
    var doc = {contextUrl: null, documentUrl: res.final_url, document: JSON.parse(res.response_text)};
    var contentType = res.content_type;
    var linkHeader = res.link;

    // copied from 'jsonld.documentLoaders.jquery'
    if(linkHeader && contentType !== 'application/ld+json') {
      // only 1 related link header permitted
      linkHeader = jsonld.parseLinkHeader(linkHeader)[LINK_HEADER_REL];
      if(_isArray(linkHeader)) {
        return callback(new JsonLdError(
          'URL could not be dereferenced, it has more than one ' +
          'associated HTTP Link Header.',
          'jsonld.InvalidUrl',
          {code: 'multiple context link headers', url: url}), doc);
      }
      if(linkHeader) {
        doc.contextUrl = linkHeader.target;
      }
    }
    callback(null, doc);
  }
  return loader;
};

jsonld.useDocumentLoader('curl');

function r_compact(doc, context, options){
  var err;
  var compacted;
  jsonld.compact(doc, context, options, function(x, y) {
    err = x;
    compacted = y;
  });
  if(err) throw err;
  if(compacted === undefined) throw "Invalid input";
  return JSON.stringify(compacted, null, 2);
}

function r_expand(compacted, options){
  var err;
  var expanded;
  jsonld.expand(compacted, options, function(x, y) {
    err = x;
    expanded = y;
  });
  if(err) throw err;
  if(expanded === undefined) throw "Invalid input";
  return JSON.stringify(expanded, null, 2);
}

function r_flatten(doc, context, options){
  var err;
  var flattened;
  jsonld.flatten(doc, context, options, function(x, y) {
    err = x;
    flattened = y;
  });
  if(err) throw err;
  if(flattened === undefined) throw "Invalid input";
  return JSON.stringify(flattened, null, 2);
}

function r_frame(doc, frame, options){
  var err;
  var framed;
  jsonld.frame(doc, frame, options, function(x, y) {
    err = x;
    framed = y;
  });
  if(err) throw err;
  if(framed === undefined) throw "Invalid input";
  return JSON.stringify(framed, null, 2);
}

function r_normalize(doc, options){
  var err;
  var normalized;
  jsonld.normalize(doc, options, function(x, y) {
    err = x;
    normalized = y;
  });
  if(err) throw err;
  if(normalized === undefined) throw "Invalid input";
  return normalized;
}

function r_to_rdf(doc, options){
  var err;
  var nquads;
  jsonld.toRDF(doc, options, function(x, y) {
    err = x;
    nquads = y;
  });
  if(err) throw err;
  if(nquads === undefined) throw "Invalid input";
  return nquads;
}

function r_from_rdf(text, options){
  var err;
  var doc;
  jsonld.fromRDF(text, options, function(x, y) {
    err = x;
    doc = y;
  });
  if(err) throw err;
  if(doc === undefined) throw "Invalid input";
  return JSON.stringify(doc, null, 2);
}
