# R bindings for jsonld.js

Tests at: 2016-12-12 21:52:41 

## Failures for jsonld.compact

## Failures for jsonld.expand

## Failures for jsonld.flatten


### Test: `flatten-0044-in.jsonld`

Expected:
```json
{
    "@context": {
        "term": "http://example/term"
    },
    "@graph": [
        {
            "@id": "http://example/foo",
            "term": [
                "value"
            ]
        }
    ]
}

```

Found output:
```json
[
    {
        "@id": "http://example/foo",
        "http://example/term": [
            {
                "@value": "value"
            }
        ]
    }
]

```


## Failures for jsonld.frame


### Test: `frame-0023-in.jsonld`

Expected:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "ex:p": null,
            "ex:q": "bar"
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [

    ]
}

```



### Test: `frame-0027-in.jsonld`

**RUNTIME ERROR!!**:  TypeError: Cannot use 'in' operator to search for '@omitDefault' in undefined 


### Test: `frame-0028-in.jsonld`

Expected:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "@type": "ex:Type1",
            "@reverse": {
                "ex:includes": {
                    "@id": "ex:Sub2",
                    "@type": "ex:Type2",
                    "ex:includes": {
                        "@id": "ex:Sub1"
                    }
                }
            }
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "@type": "ex:Type1"
        }
    ]
}

```



### Test: `frame-0029-in.jsonld`

Expected:
```json
{
    "@context": {
        "ex": "http://example.org/",
        "excludes": {
            "@reverse": "ex:includes"
        }
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "@type": "ex:Type1",
            "excludes": {
                "@id": "ex:Sub2",
                "@type": "ex:Type2",
                "ex:includes": {
                    "@id": "ex:Sub1"
                }
            }
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "ex": "http://example.org/",
        "excludes": {
            "@reverse": "ex:includes"
        }
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "@type": "ex:Type1"
        }
    ]
}

```



### Test: `frame-0031-in.jsonld`

Expected:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "ex:Sub2",
            "ex:p": "Bar"
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "@type": "ex:Type1",
            "ex:p": "Foo"
        },
        {
            "@id": "ex:Sub2",
            "ex:p": "Bar"
        }
    ]
}

```



### Test: `frame-0033-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0034-in.jsonld`

Expected:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "ex:Sub1",
            "ex:p": null,
            "ex:q": "bar"
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "ex": "http://example.org/"
    },
    "@graph": [

    ]
}

```



### Test: `frame-0037-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0038-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0039-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0040-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0041-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0042-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0043-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0044-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0045-in.jsonld`

**RUNTIME ERROR!!**:  jsonld.FrameError: Could not expand frame before framing. 


### Test: `frame-0047-in.jsonld`

Expected:
```json
{
    "@context": {
        "@vocab": "urn:"
    },
    "@graph": [
        {
            "@id": "urn:id-1",
            "@type": "Class",
            "preserve": {
                "@id": "urn:gr-1",
                "@graph": [
                    {
                        "@id": "urn:id-2",
                        "term": "data"
                    }
                ]
            }
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "@vocab": "urn:"
    },
    "@graph": [
        {
            "@id": "urn:id-1",
            "@type": "Class",
            "preserve": {
                "@id": "urn:gr-1"
            }
        }
    ]
}

```



### Test: `frame-0048-in.jsonld`

Expected:
```json
{
    "@context": {
        "@vocab": "urn:"
    },
    "@graph": [
        {
            "@id": "urn:id-1",
            "@type": "Class",
            "merge": {
                "@id": "urn:id-2",
                "term": "foo"
            },
            "preserve": {
                "@id": "urn:graph-1",
                "@graph": [
                    {
                        "@id": "urn:id-3",
                        "term": "bar"
                    }
                ]
            }
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "@vocab": "urn:"
    },
    "@graph": [
        {
            "@id": "urn:id-1",
            "@type": "Class",
            "merge": {
                "@id": "urn:id-2",
                "term": "foo"
            },
            "preserve": {
                "@id": "urn:graph-1"
            }
        }
    ]
}

```



### Test: `frame-0049-in.jsonld`

Expected:
```json
{
    "@context": {
        "@vocab": "urn:"
    },
    "@graph": [
        {
            "@id": "urn:id-1",
            "@type": "Class",
            "merge": {
                "@id": "urn:id-2",
                "term": "foo"
            },
            "preserve": {
                "@id": "_:b0",
                "deep": {
                    "@id": "_:b1",
                    "@graph": [
                        {
                            "@id": "urn:id-3",
                            "term": "bar"
                        }
                    ]
                }
            }
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "@vocab": "urn:"
    },
    "@graph": [
        {
            "@id": "urn:id-1",
            "@type": "Class",
            "merge": {
                "@id": "urn:id-2",
                "term": "foo"
            },
            "preserve": {
                "@id": "_:b0",
                "deep": {
                    "@id": "_:b1"
                }
            }
        }
    ]
}

```



### Test: `frame-0050-in.jsonld`

Expected:
```json
{
    "@context": {
        "@vocab": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "http://example.org/library",
            "@type": "Library",
            "name": "Library",
            "contains": {
                "@id": "http://example.org/graphs/books",
                "@graph": [
                    {
                        "@id": "http://example.org/library/the-republic",
                        "@type": "Book",
                        "creator": "Plato",
                        "title": "The Republic",
                        "contains": {
                            "@id": "http://example.org/library/the-republic#introduction",
                            "@type": "Chapter",
                            "description": "An introductory chapter on The Republic.",
                            "title": "The Introduction"
                        }
                    }
                ]
            }
        }
    ]
}

```

Found output:
```json
{
    "@context": {
        "@vocab": "http://example.org/"
    },
    "@graph": [
        {
            "@id": "http://example.org/library",
            "@type": "Library",
            "contains": {
                "@id": "http://example.org/graphs/books"
            },
            "name": "Library"
        }
    ]
}

```


## Failures for jsonld.fromRdf

## Failures for jsonld.toRdf

