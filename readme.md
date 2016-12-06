# jsonld

> Bindings to the JSON-LD JavaScript library

JSON-LD is designed as a light-weight syntax that can be used to express 
Linked Data. It is primarily intended to be a way to express Linked Data in JavaScript
and other Web-based programming environments. It is also useful when building 
interoperable Web Services and when storing Linked Data in JSON-based document storage
engines.

## Hello World



Example from https://github.com/digitalbazaar/jsonld.js#quick-examples. Example data:


```r
doc <- '{
  "http://schema.org/name": "Manu Sporny",
  "http://schema.org/url": {"@id": "http://manu.sporny.org/"},
  "http://schema.org/image": {"@id": "http://manu.sporny.org/images/manu.png"}
}'

context <- '{
  "name": "http://schema.org/name",
  "homepage": {"@id": "http://schema.org/url", "@type": "@id"},
  "image": {"@id": "http://schema.org/image", "@type": "@id"}
}'
```

### Compact and expand:


```r
(out <- jsonld::compact(doc, context))
```

```
{
  "@context": {
    "name": "http://schema.org/name",
    "homepage": {
      "@id": "http://schema.org/url",
      "@type": "@id"
    },
    "image": {
      "@id": "http://schema.org/image",
      "@type": "@id"
    }
  },
  "image": "http://manu.sporny.org/images/manu.png",
  "name": "Manu Sporny",
  "homepage": "http://manu.sporny.org/"
} 
```

```r
(expanded <- jsonld::expand(out))
```

```
[
  {
    "http://schema.org/url": [
      {
        "@id": "http://manu.sporny.org/"
      }
    ],
    "http://schema.org/image": [
      {
        "@id": "http://manu.sporny.org/images/manu.png"
      }
    ],
    "http://schema.org/name": [
      {
        "@value": "Manu Sporny"
      }
    ]
  }
] 
```

### Convert between JSON and RDF:


```r
cat(nquads <- jsonld::to_rdf(doc))
```

```
_:b0 <http://schema.org/image> <http://manu.sporny.org/images/manu.png> .
_:b0 <http://schema.org/name> "Manu Sporny" .
_:b0 <http://schema.org/url> <http://manu.sporny.org/> .
```

```r
jsonld::from_rdf(nquads)
```

```
[
  {
    "@id": "_:b0",
    "http://schema.org/image": [
      {
        "@id": "http://manu.sporny.org/images/manu.png"
      }
    ],
    "http://schema.org/name": [
      {
        "@value": "Manu Sporny"
      }
    ],
    "http://schema.org/url": [
      {
        "@id": "http://manu.sporny.org/"
      }
    ]
  }
] 
```

### Other utilities:


```r
jsonld::flatten(doc)
```

```
[
  {
    "@id": "_:b0",
    "http://schema.org/image": [
      {
        "@id": "http://manu.sporny.org/images/manu.png"
      }
    ],
    "http://schema.org/name": [
      {
        "@value": "Manu Sporny"
      }
    ],
    "http://schema.org/url": [
      {
        "@id": "http://manu.sporny.org/"
      }
    ]
  }
] 
```

```r
cat(jsonld::normalize(doc, algorithm = 'URDNA2015', format = 'application/nquads'))
```

```
_:c14n0 <http://schema.org/image> <http://manu.sporny.org/images/manu.png> .
_:c14n0 <http://schema.org/name> "Manu Sporny" .
_:c14n0 <http://schema.org/url> <http://manu.sporny.org/> .
```

