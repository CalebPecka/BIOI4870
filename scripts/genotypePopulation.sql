-- This code consists of DDL and DML statements to facilitate the
-- creation of A Database for Metabolite Contributions in Bacterial 
-- Dysbiosis.
--
-- This script will populate the Genotype table.
-- Data for this table was manually identified from the experimental
-- protocols. In the experiment, mice were identified by four
-- possible transgenic modifications. Checks for these modification
-- types are included in the Genotype table.

-- DDL to create a table that stores genotype information
CREATE TABLE genotype (
	genotype_id varchar(15) NOT NULL,
	gene varchar(15),
	transgenic_modification_type varchar(15),
	description varchar(255),
	PRIMARY KEY (genotype_id),
	CHECK (
		gene = "Claudin 1" OR
		gene = "Claudin 2" OR
		gene = "Claudin 3" OR
		gene = NULL
	),
	CHECK (
		transgenic_modification_type = "TG" OR
		transgenic_modification_type = "KO" OR
		transgenic_modiciation_type = NULL
	)
);

-- DML to populate table values. These were manually created, as
-- they are experimental protocols, and the list of genes is quite
-- small.
INSERT INTO genotype VALUES (
  'CLDN1',
  'Claudin 1',
  'TG',
  'Mice with transgenically introduced Claudin 1.'
);
INSERT INTO genotype VALUES (
  'CLDN2',
  'Claudin 2',
  'TG',
  'Mice with transgenically introduced Claudin 2.'
);
INSERT INTO genotype VALUES (
  'CL3KO',
  'Claudin 3',
  'KO',
  'Mice with knockout of Claudin 3 expression.'
);
INSERT INTO genotype VALUES (
  'WT',
  NULL,
  NULL,
  'Wild type mice used as a microbiome control comparison.'
);