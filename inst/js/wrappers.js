//Fix missing polyfill in jsonld 1.0.0
String.prototype.endsWith = function(suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
};

function setTimeout(fun){
  fun();
}

/* V8 does not have network support, so we call back to R */
jsonld.documentLoaders.curl = function(options){
  LINK_HEADER_REL = 'http://www.w3.org/ns/json-ld#context';
  function loader(url, callback){
    var res = console.r.call('jsonld:::download', {url : url});
    var doc = {contextUrl: null, documentUrl: res.final_url, document: JSON.parse(res.response_text)};
    var contentType = res.content_type;
    var linkHeader = res.link;

    // copied from 'jsonld.documentLoaders.jquery'
    if(linkHeader && linkHeader.length && contentType !== 'application/ld+json') {
      // only 1 related link header permitted
      linkHeader = jsonld.parseLinkHeader(linkHeader)[LINK_HEADER_REL];
      if(Array.isArray(linkHeader)) {
        throw new JsonLdError(
          'URL could not be dereferenced, it has more than one ' +
          'associated HTTP Link Header.',
          'jsonld.InvalidUrl',
          {code: 'multiple context link headers', url: url});
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

function store_value(err, val){
  console.r.call('jsonld:::store_val', {set: {err : err, val : val}});
}

function store_json(err, val){
  store_value(err, JSON.stringify(val, null, 2));
}

function r_compact(doc, context, options){
  jsonld.compact(doc, context, options, store_json);
}

function r_expand(compacted, options){
  jsonld.expand(compacted, options, store_json);
}

function r_flatten(doc, context, options){
  jsonld.flatten(doc, context, options, store_json);
}

function r_frame(doc, frame, options){
  jsonld.frame(doc, frame, options, store_json);
}

function r_normalize(doc, options){
  jsonld.normalize(doc, options, store_value);
}

function r_to_rdf(doc, options){
  jsonld.toRDF(doc, options, store_value);
}

function r_from_rdf(text, options){
  jsonld.fromRDF(text, options, store_json);
}
