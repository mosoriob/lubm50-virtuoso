sparql
define input:inference "inft"
prefix ub: <http://swat.cse.lehigh.edu/onto/univ-bench.owl#>
select * from <lubm>
where { ?x rdf:type ub:Publication };
