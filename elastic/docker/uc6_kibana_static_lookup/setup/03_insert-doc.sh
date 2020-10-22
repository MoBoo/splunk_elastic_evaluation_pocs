#!/bin/bash
#echo ">>> Create Index: http_access_logs"
#/usr/bin/curl -X PUT "localhost:9200/http_access_logs?pretty=true";echo

echo ">>> Inserting Test Data"
/usr/bin/curl -H "Content-Type: application/json" -X POST "localhost:9200/http_access_logs/_doc?pipeline=access_combined_wcookie_parsing_pipeline&refresh=wait_for&pretty=true" -d '{"message":"74.125.19.106 - - [16/Aug/2020:18:27:48] \"GET /product.screen?productId=FS-SG-G03&JSESSIONID=SD10SL4FF4ADFF4976 HTTP 1.1\" 200 3770 \"http://www.buttercupgames.com/category.screen?categoryId=STRATEGY\" \"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5\" 667"}';echo

echo ">>> Searching for documents..."
/usr/bin/curl -X GET "localhost:9200/http_access_logs/_search?pretty=true";echo
