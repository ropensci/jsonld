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

function r_compact(doc, context){
  var err;
  var compacted;
  jsonld.compact(doc, context, function(x, y) {
    err = x;
    compacted = y;
  });
  if(err) throw err;
  if(!compacted) throw "Invalid input";
  return JSON.stringify(compacted, null, 2);
}

function r_expand(compacted){
  var err;
  var expanded;
  jsonld.expand(compacted, function(x, y) {
    err = x;
    expanded = y;
  });
  if(err) throw err;
  if(!expanded) throw "Invalid input";
  return JSON.stringify(expanded, null, 2);
}

function r_flatten(doc){
  var err;
  var flattened;
  jsonld.flatten(doc, function(x, y) {
    err = x;
    flattened = y;
  });
  if(err) throw err;
  if(!flattened) throw "Invalid input";
  return JSON.stringify(flattened, null, 2);
}

function r_frame(doc, frame){
  var err;
  var framed;
  jsonld.frame(doc, frame, function(x, y) {
    err = x;
    framed = y;
  });
  if(err) throw err;
  if(!framed) throw "Invalid input";
  return JSON.stringify(framed, null, 2);
}

function r_normalize(doc, algorithm, format){
  var err;
  var normalized;
  jsonld.normalize(doc, {
    algorithm: algorithm,
    format: format
  }, function(x, y) {
    err = x;
    normalized = y;
  });
  if(err) throw err;
  if(!normalized) throw "Invalid input";
  return normalized;
}

function r_to_rdf(doc, format){
  var err;
  var nquads;
  jsonld.toRDF(doc, {format : format}, function(x, y) {
    err = x;
    nquads = y;
  });
  if(err) throw err;
  if(!nquads) throw "Invalid input";
  return nquads;
}

function r_from_rdf(text, format){
  var err;
  var doc;
  jsonld.fromRDF(text, {format : format}, function(x, y) {
    err = x;
    doc = y;
  });
  if(err) throw err;
  if(!doc) throw "Invalid input";
  return JSON.stringify(doc, null, 2);
}
