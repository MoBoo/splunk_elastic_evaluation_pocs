# THIS DOES NOT WORK PROPERLY. IF THIS IS USED, KIBANA WILL OVERRIDE ALL FIELDS IN THE INDEX PATTERN. THEREFORE THIS INDEX PATTERN BECOMES USELESS.
# to make this work a manual refresh of the index-pattern field list is required. This can be done in "Stack Management -> Index Patterns -> http_access_logs* -> refresh field list"


#!/bin/bash
echo ">>> Create kibana index-pattern: http_access_logs_pattern with scripted field http.reponse.status_code_desc"
curl -X POST "localhost:5601/api/saved_objects/index-pattern/http_access_logs_pattern"  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
	"attributes": {
		"title": "http_access_logs*",
		"timeFieldName": "timestamp",
		"fields": "[{\"name\":\"http.response.status_code_desc\",\"type\":\"string\",\"count\":1,\"scripted\":true,\"script\":\"String status_code = doc['http.response.status_code'].value;\\nif (status_code == \\\"200\\\") {\\n    return \\\"Ok\\\";\\n}\\nelse if (status_code == \\\"404\\\") {\\n    return \\\"Not Found\\\";\\n}\\nelse if (status_code == \\\"500\\\") {\\n    return \\\"Internal Server Error\\\"\\n}\\nelse {\\n    return \\\"n/a\\\"\\n}\",\"lang\":\"painless\",\"searchable\":true,\"aggregatable\":true,\"readFromDocValues\":false}]"
	}
}';echo

# This does not work so easy. See link on how to set this up. (https://discuss.elastic.co/t/api-for-creating-scripted-fields/139236/2)
# Basically you cannot just update the fields like this. First you need to get the fields, parse the json, append your field and send it all back.
# As of now there is only this solution, no way to update only a single fields. It is basically an overwrite of everything everytime.

