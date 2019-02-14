# R bindings for jsonld.js

Tests at: 2019-02-01 12:30:49 

## Failures for jsonld.compact


### Test: `compact-0038-in.jsonld`

Expected:
```json
{
    "@context": {
        "site": "http://example.com/",
        "site-cd": "site:site-schema/content-deployment/",
        "title": {
            "@id": "site-cd:node/article/title",
            "@container": "@index"
        },
        "body": {
            "@id": "site-cd:node/article/body",
            "@container": "@index"
        },
        "field_tags": {
            "@id": "site-cd:node/article/field_tags",
            "@container": "@index"
        }
    },
    "@id": "site:node/1",
    "@type": "site-cd:node/article",
    "title": {
        "en": {
            "@type": "site-cd:field-types/title_field",
            "title:/value": "This is the English title"
        },
        "es": {
            "@type": "site-cd:field-types/title_field",
            "title:/value": "Este es el t’tulo espa–ol"
        }
    },
    "body": {
        "en": {
            "@type": "site-cd:field-types/text_with_summary",
            "body:/value": "This is the English body. There is no Spanish body, so this will be displayed for both the English and Spanish versions.",
            "body:/summary": "This is the teaser for the body.",
            "body:/format": "full_html"
        }
    },
    "field_tags": {
        "en": {
            "@type": "site-cd:taxonomy/term",
            "@id": "site:taxonomy/term/1",
            "site-cd:taxonomy/term/uuid": "e34b982c-98ac-4862-9b00-fa771a388010"
        },
        "es": [
            {
                "@type": "site-cd:taxonomy/term",
                "@id": "site:taxonomy/term/1",
                "site-cd:taxonomy/term/uuid": "e34b982c-98ac-4862-9b00-fa771a388010"
            },
            {
                "@type": "site-cd:taxonomy/term",
                "@id": "site:taxonomy/term/2",
                "site-cd:taxonomy/term/uuid": "a55b982c-58ac-4862-9b00-aa221a388010"
            }
        ]
    }
}

```

Found output:
```json
{
    "@context": {
        "site": "http://example.com/",
        "site-cd": "site:site-schema/content-deployment/",
        "title": {
            "@id": "site-cd:node/article/title",
            "@container": "@index"
        },
        "body": {
            "@id": "site-cd:node/article/body",
            "@container": "@index"
        },
        "field_tags": {
            "@id": "site-cd:node/article/field_tags",
            "@container": "@index"
        }
    },
    "@id": "site:node/1",
    "@type": "site-cd:node/article",
    "body": {
        "en": {
            "@type": "site-cd:field-types/text_with_summary",
            "site-cd:node/article/body/format": "full_html",
            "site-cd:node/article/body/summary": "This is the teaser for the body.",
            "site-cd:node/article/body/value": "This is the English body. There is no Spanish body, so this will be displayed for both the English and Spanish versions."
        }
    },
    "field_tags": {
        "en": {
            "@id": "site:taxonomy/term/1",
            "@type": "site-cd:taxonomy/term",
            "site-cd:taxonomy/term/uuid": "e34b982c-98ac-4862-9b00-fa771a388010"
        },
        "es": [
            {
                "@id": "site:taxonomy/term/1",
                "@type": "site-cd:taxonomy/term",
                "site-cd:taxonomy/term/uuid": "e34b982c-98ac-4862-9b00-fa771a388010"
            },
            {
                "@id": "site:taxonomy/term/2",
                "@type": "site-cd:taxonomy/term",
                "site-cd:taxonomy/term/uuid": "a55b982c-58ac-4862-9b00-aa221a388010"
            }
        ]
    },
    "title": {
        "en": {
            "@type": "site-cd:field-types/title_field",
            "site-cd:node/article/title/value": "This is the English title"
        },
        "es": {
            "@type": "site-cd:field-types/title_field",
            "site-cd:node/article/title/value": "Este es el t’tulo espa–ol"
        }
    }
}

```



### Test: `compact-0045-in.jsonld`

Expected:
```json
{
    "@context": {
        "term": "http://example.com/terms-are-not-considered-in-id",
        "compact-iris": "http://example.com/compact-iris-",
        "property": "http://example.com/property",
        "@vocab": "http://example.org/vocab-is-not-considered-for-id"
    },
    "@id": "term",
    "property": [
        {
            "@id": "compact-iris:are-considered",
            "property": "@id supports the following values: relative, absolute, and compact IRIs"
        },
        {
            "@id": "../parent-node",
            "property": "relative IRIs get resolved against the document's base IRI"
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "term": "http://example.com/terms-are-not-considered-in-id",
        "compact-iris": "http://example.com/compact-iris-",
        "property": "http://example.com/property",
        "@vocab": "http://example.org/vocab-is-not-considered-for-id"
    },
    "@id": "term",
    "property": [
        {
            "@id": "http://example.com/compact-iris-are-considered",
            "property": "@id supports the following values: relative, absolute, and compact IRIs"
        },
        {
            "@id": "../parent-node",
            "property": "relative IRIs get resolved against the document's base IRI"
        }
    ]
}

```


## Failures for error messages


### Test: `error-0042-in.jsonld`

Failed to raise error!


### Test: `error-0043-in.jsonld`

Failed to raise error!

## Failures for jsonld.expand

## Failures for jsonld.flatten

## Failures for jsonld.frame


### Test: `frame-0010-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 


### Test: `frame-0020-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 


### Test: `frame-0046-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 


### Test: `frame-0047-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 


### Test: `frame-0048-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 


### Test: `frame-0049-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 


### Test: `frame-0050-in.jsonld`

**RUNTIME ERROR!!**:  x$success isn't true. 

