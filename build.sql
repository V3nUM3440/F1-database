-- creates tables
\. createTables.sql
-- inserts sample data
\. insertData.sql
-- creates the advanced features
\. advanced.sql
-- updates the points of the teams, depending on their driver's points
CALL insertTeamPoints();
-- Uncomment to run the queries discussed in the report aswell
-- \. queries.sql