//create person
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/avila-michel/neo4j-unisul/master/data/person.csv" as row
create (p:Person {name:row.name, gender:row.gender, orientation:row.orientation})
return count(*);

//create place
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/avila-michel/neo4j-unisul/master/data/place.csv" as row
create (p:Place {name:row.place})
return count(*);

//create behavior
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/avila-michel/neo4j-unisul/master/data/behavior.csv" as row
create (b:Behavior {name:row.behavior})
return count(*);

//connect person to place
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/avila-michel/neo4j-unisul/master/data/person_place.csv" as row
match (p:Person {name:row.person}), (pl:Place {name:row.place})
create (p)-[:lives_in]->(pl);

//connect person to behavior
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/avila-michel/neo4j-unisul/master/data/person_behavior.csv" as row
match (p:Person {name:row.person}), (b:Behavior {name:row.behavior})
call apoc.create.relationship(p, row.rel, null, b) yield rel
return count(rel);

//create unique constraint on name
CREATE CONSTRAINT ON (p:Person)   ASSERT p.name IS UNIQUE;
CREATE CONSTRAINT ON (p:Place)    ASSERT p.name IS UNIQUE;
CREATE CONSTRAINT ON (b:Behavior) ASSERT b.name IS UNIQUE;

/*
expected output:
+----------------------------------------------+
¦"labels(n)"¦"type(r)" ¦"labels(m)" ¦"count(*)"¦
¦-----------+----------+------------+----------¦
¦["Person"] ¦"has"     ¦["Behavior"]¦14586     ¦
+-----------+----------+------------+----------¦
¦["Person"] ¦"wants"   ¦["Behavior"]¦14361     ¦
+-----------+----------+------------+----------¦
¦["Person"] ¦"lives_in"¦["Place"]   ¦1000      ¦
+----------------------------------------------+
*/

//verify results
match (n)-[r]->(m) return labels(n), type(r), labels(m), count(*);
