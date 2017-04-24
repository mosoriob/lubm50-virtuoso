--
--  $Id$
--
--  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
--  project.
--
--  Copyright (C) 1998-2017 OpenLink Software
--
--  This project is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; only version 2 of the License, dated June 1991.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
--

set timeout 120;

create procedure load_lubm (in dir any)
{
  declare arr, src, stat any;
  result_names (src, stat);
  arr := sys_dirlist (dir, 1);
--  arr := vector ('u0000_00.rdf');
  foreach (any f in arr) do
    {
      declare str any;
      if (f[0] <> '.'[0])
	{
	  str := file_to_string (dir||f);
	  DB.DBA.RDF_LOAD_RDFXML (str, 'file:///'||dir, 'lubm');
	  result (f, 'Loaded');
	}
    }
};

--cl_text_index (1);
rdf_obj_ft_rule_add (null, null, 'lubm');


sparql clear graph <lubm>;
sparql clear graph <inf>;

load_lubm ('/opt/virtuoso-7.1.0/bin/lubm_50/');

vt_inc_index_db_dba_rdf_obj ();

sparql select count(*) from <lubm> where { ?x ?y ?z } ;
sparql prefix ub: <http://swat.cse.lehigh.edu/onto/univ-bench.owl#>
insert into graph <lubm> { ?x ub:subOrganizationOf ?z  } from <lubm> where { ?x ub:subOrganizationOf ?y . ?y ub:subOrganizationOf ?z . };

DB.DBA.TTLP (file_to_string ('inf2.nt'), 'http://swat.cse.lehigh.edu/onto/univ-bench.owl', 'inf');
rdfs_rule_set ('inft', 'inf');
checkpoint;
