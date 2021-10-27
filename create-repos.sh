#!/bin/bash
input="/Users/srujanswathi/scripts/test.txt"
while IFS= read -r line
do
    
    echo "Creating the Repository $line"
    curl -X POST -v -u user:key https://stash.com/rest/api/1.0/projects/PL123456/repos -H "Content-Type: application/json" -d "{\"name\": \"{$line}\",\"scmId\": \"git\" }"
    sleep 5

    echo "Adding REPO_WRITE Permissions to Repository:$line"
    curl -u user:key -X PUT "https://stash.com/rest/api/1.0/projects/PL123456/repos/{$line}/permissions/groups?permission=REPO_WRITE&name=test-group0&permission=REPO_WRITE&name=test-group1"
    sleep 5

    echo "Adding REPO_ADMIN Permissions to Repository:$line"
    curl -u user:key -X PUT "https://stash.com/rest/api/1.0/projects/PL123456/repos/{$line}/permissions/groups?permission=REPO_ADMIN&name=test-group2&permission"
    sleep 5

    echo "Adding REPO_READ Permissions to Repository:$line"
    curl -u user:key -X PUT "https://stash.com/rest/api/1.0/projects/PL123456/repos/{$line}/permissions/groups?permission=REPO_READ&name=test-group3&permission"

    echo "Successfully created Repository:$line and added permissions"
done < "$input"