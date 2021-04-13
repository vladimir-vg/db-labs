-- Using Neo4J-empty project, build a representation of the relationship between the following fighters (fighter is a Node{name,weight}, beat is a relationship)
-- see screenshot0.png
CREATE
  (f1:Fighter{name: "Khabib Nurmagomedov", weight: 155}),
  (f2:Fighter{name: "Rafael Dos Anjos", weight: 155}),
  (f3:Fighter{name: "Neil Magny", weight: 170}),
  (f4:Fighter{name: "Jon Jones", weight: 205}),
  (f5:Fighter{name: "Daniel Cormier", weight: 205}),
  (f6:Fighter{name: "Michael Bisping", weight: 185}),
  (f7:Fighter{name: "Matt Hamill", weight: 185}),
  (f8:Fighter{name: "Brandon Vera", weight: 205}),
  (f9:Fighter{name: "Frank Mir", weight: 230}),
  (f10:Fighter{name: "Brock Lesnar", weight: 230}),
  (f11:Fighter{name: "Kelvin Gastelum", weight: 185}),

  (f1)-[:beats]->(f2),
  (f2)-[:beats]->(f3),
  (f4)-[:beats]->(f5),
  (f6)-[:beats]->(f7),
  (f4)-[:beats]->(f8),
  (f8)-[:beats]->(f9),
  (f9)-[:beats]->(f10),
  (f3)-[:beats]->(f11),
  (f11)-[:beats]->(f6),
  (f6)-[:beats]->(f7),
  (f6)-[:beats]->(f11),
  (f7)-[:beats]->(f4);

-- Return all middle/Walter/lightweight fighters (155,170,185) who at least have one win.
-- see screenshot1.png
MATCH (f:Fighter)-[:beats]->(other:Fighter)
WHERE f.weight IN [155, 170, 185]
RETURN f

-- Return fighters who had 1-1 record with each other. Use Countfrom the aggregation functions.
-- see screenshot2.png
MATCH
  (f1:Fighter)-[:beats]->(f2:Fighter),
  (f2:Fighter)-[:beats]->(f1:Fighter)
WITH f1, f2, count([f1, f2]) as count1
WHERE count1 = 1
RETURN f1, f2

-- Return all fighter that can “KhabibNurmagomedov” beat them and he didn’t have a fight with them yet.
-- see screenshot3.png
MATCH (f1:Fighter)-[r*]->(f2:Fighter)
WHERE f1.name = "Khabib Nurmagomedov"
  AND NOT (f1)-[:beats]->(f2)
RETURN f2

-- Return undefeated Fighters(0 loss), defeated fighter (0 wins).
-- see screenshot4.png
MATCH (undefeated:Fighter), (defeated:Fighter)
WHERE NOT (:Fighter)-[:beats]->(undefeated)
  AND NOT (defeated)-[:beats]->(:Fighter)
RETURN undefeated, defeated

-- Return all fighters MMA records and create query to enter the record as a property for a fighter {name, weight, record}.
-- see screenshot5.png
MATCH (f:Fighter)
WITH f, count((f)-[:beats]->(:Fighter)) AS wins
WITH f, wins, count((:Fighter)-[:beats]->(f)) AS defeats
SET f.record = [wins, defeats]
