//[1] Quantos nós tem o grafo?
MATCH (n) RETURN COUNT(n);

//[2] Mostrar os 10 primeiros nós
MATCH (n) RETURN n LIMIT 10;

//[3] Quais são os labels disponíveis?
MATCH (n) RETURN LABELS(n), COUNT(n);

//[4] Quais são os relacionamentos disponíveis?
MATCH (n)-[r]-(m) RETURN TYPE(r), COUNT(r);

//[5] Como tudo está relacionado (esquema)?
MATCH (n)-[r]-(m)
RETURN LABELS(n),TYPE(r),LABELS(m),COUNT(*);

//[6] Ou
MATCH (n)-[r]->(m)
RETURN LABELS(n),TYPE(r),LABELS(m),COUNT(*);

//[7] Quais comportamentos Susan está buscando?
MATCH (target:Person {name:"Susan"})
     ,(target)-[:wants]->(behavior)
RETURN behavior.name;

//[8] Quem tem o que Susan está buscando?
MATCH
  (target:Person {name:"Susan"})
 ,(target)-[:wants]->(behavior)
 ,(proposed)-[:has]->(behavior)
RETURN
  proposed.name AS proposed
 ,behavior.name AS behavior
ORDER BY proposed
LIMIT 50;

//[9] Dá pra melhorar o resultado?
MATCH
  (target:Person {name:"Susan"})
 ,(target)-[:wants]->(behavior)
 ,(proposed)-[:has]->(behavior)
RETURN
  proposed.name          AS proposed
 ,COUNT(behavior)        AS behavior_count
 ,COLLECT(behavior.name) AS behavior_list
ORDER BY behavior_count DESC, proposed;

//[10] Melhor pretendente para Sacha
MATCH
  (target:Person {name:"Sacha"})
 ,(target)-[:wants]->(behavior)
 ,(proposed)-[:has]->(behavior)
RETURN
  proposed.name          AS proposed
 ,COUNT(behavior)        AS behavior_count
 ,COLLECT(behavior.name) AS behavior_list
ORDER BY behavior_count DESC, proposed;
