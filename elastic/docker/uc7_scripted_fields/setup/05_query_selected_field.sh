echo ">>> Query http_access_logs with scripted field applied."
# '_source: true' has to be set in order to return all fields. If omitted only the scripted field is returned. (https://stackoverflow.com/questions/36859065/how-to-return-all-fields-when-using-scripted-fields-in-elastic-search)
curl -H "Content-Type: application/json" -X GET "localhost:9200/http_access_logs_summary/_search?pretty" -d'
{
  "query": {
    "match_all": {}
  },
  "_source": true,
  "script_fields": {
    "http.response.status_code_desc": {
      "script": {
        "lang": "painless",
        "source": "int status_code = (int)doc[\"http.response.status_code\"].value;\nif (status_code == 200) {\n    return \"Ok\";\n}\nelse if (status_code == 404) {\n    return \"Not Found\";\n}\nelse if (status_code == 500) {\n    return \"Internal Server Error\"\n}\nelse {\n    return \"n/a\"\n}"
      }
    }
  }
}
';echo

