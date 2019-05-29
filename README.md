# jsonld

> JSON for Linking Data

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/jsonld.svg?branch=master)](https://travis-ci.org/ropensci/jsonld)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/jsonld?branch=master&svg=true)](https://ci.appveyor.com/project/jeroen/jsonld)
[![Coverage Status](https://codecov.io/github/ropensci/jsonld/coverage.svg?branch=master)](https://codecov.io/github/ropensci/jsonld?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/jsonld)](https://cran.r-project.org/package=jsonld)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/jsonld)](https://cran.r-project.org/package=jsonld)
[![Github Stars](https://img.shields.io/github/stars/ropensci/jsonld.svg?style=social&label=Github)](https://github.com/ropensci/jsonld)


JSON-LD is a light-weight syntax for expressing linked data. It is primarily
intended for web-based programming environments, interoperable web services and for 
storing linked data in JSON-based databases. This package provides bindings to the 
JavaScript library for converting, expanding and compacting JSON-LD documents.

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
(out <- jsonld_compact(doc, context))
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
(expanded <- jsonld_expand(out))
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
cat(nquads <- jsonld_to_rdf(doc))
```

```
_:b0 <http://schema.org/image> <http://manu.sporny.org/images/manu.png> .
_:b0 <http://schema.org/name> "Manu Sporny" .
_:b0 <http://schema.org/url> <http://manu.sporny.org/> .
```

```r
jsonld_from_rdf(nquads)
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
jsonld_flatten(doc)
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
cat(jsonld_normalize(doc, algorithm = 'URDNA2015', format = 'application/nquads'))
```

```
_:c14n0 <http://schema.org/image> <http://manu.sporny.org/images/manu.png> .
_:c14n0 <http://schema.org/name> "Manu Sporny" .
_:c14n0 <http://schema.org/url> <http://manu.sporny.org/> .
```

