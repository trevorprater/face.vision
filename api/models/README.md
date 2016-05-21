In order to optimize for development time, we use a go library known as `modelq`, which infers the schema used to initialize a psql db. In order to generate new models in the event of a db schema change, execute the following: `modelq -db="dbname=face sslmode=disable" -pkg=models -driver=postgres -schema=public -tables=detection,face,grouping,img,person`.

**note: If you add a table to the db that is not listed in the previous command's `tables` argument, you will need to add it and update this file.**
