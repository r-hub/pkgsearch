
index <- "cran-devel"

mapping <- '{
  "mappings": {
    "package": {
      "dynamic_templates": [

        { "Package": {
          "match": "Package",
          "mapping": {
            "type": "string",
            "index": "not_analyzed"
          }
        }},

        { "Title": {
          "match": "Title",
          "mapping": {
            "type": "string",
            "analyzer": "english"
          }
        }},

        { "Version": {
          "match": "Version",
          "mapping": {
            "type": "string",
            "index": "not_analyzed"
          }
        }},

        { "Author": {
          "match": "Author",
          "mapping": {
            "type": "string"
          }
        }},

        { "Maintainer": {
          "match": "Maintainer",
          "mapping": {
            "type": "string"
          }
        }},

        { "Description": {
          "match": "Description",
          "mapping": {
            "type": "string",
            "analyzer": "english"
          }
        }},

        { "License": {
          "match": "License",
          "mapping": {
            "type": "string",
            "index": "not_analyzed"
          }
        }},

        { "URL": {
          "match": "URL",
          "mapping": {
            "type": "string",
            "analyzer": "simple"
          }
        }},

        { "BugReports": {
          "match": "BugReports",
          "mapping": {
            "type": "string",
            "analyzer": "simple"
          }
        }},

        { "Date": {
          "match": "Date",
          "mapping": {
            "type": "string"
          }
        }},

        { "date": {
          "match": "date",
          "mapping": {
            "type": "date"
          }
        }},

        { "default": {
          "match": "*",
          "mapping": {
            "type": "string",
            "index": "not_analyzed"
          }
        }}
      ]
    }
  }
}
'
