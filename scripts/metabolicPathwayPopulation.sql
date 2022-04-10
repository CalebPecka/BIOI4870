-- This code consists of DDL and DML statements to facilitate the
-- creation of A Database for Metabolite Contributions in Bacterial 
-- Dysbiosis.
--
-- This script will populate the Metabolic Pathways table.
-- Data for this table was manually curated from KEGG Metabolic
-- pathways: https://www.genome.jp/kegg/pathway.html#metabolism

-- DDL to create a table that stores metabolic pathway information
CREATE TABLE metabolic_pathways (
	map_id varchar(15) NOT NULL,
	pathway_name varchar(63) NOT NULL,
	PRIMARY KEY (map_id)
);

-- DML to populate table values. These were generated using
-- DMLconversions.R. Running that script creates a text file with
-- automated formatting.
INSERT INTO metabolic_pathways VALUES (
  'map00010',
  'Glycolysis / Gluconeogenesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00020',
  'Citrate cycle (TCA cycle)'
);
INSERT INTO metabolic_pathways VALUES (
  'map00030',
  'Pentose phosphate pathway'
);
INSERT INTO metabolic_pathways VALUES (
  'map00040',
  'Pentose and glucuronate interconversions'
);
INSERT INTO metabolic_pathways VALUES (
  'map00051',
  'Fructose and mannose metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00052',
  'Galactose metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00053',
  'Ascorbate and aldarate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00061',
  'Fatty acid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00062',
  'Fatty acid elongation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00071',
  'Fatty acid degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00073',
  'Cutin suberine and wax biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00100',
  'Steroid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00120',
  'Primary bile acid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00121',
  'Secondary bile acid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00130',
  'Ubiquinone and other terpenoid-quinone biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00140',
  'Steroid hormone biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00220',
  'Arginine biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00230',
  'Purine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00232',
  'Caffeine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00240',
  'Pyrimidine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00250',
  'Alanine aspartate and glutamate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00253',
  'Tetracycline biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00254',
  'Aflatoxin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00260',
  'Glycine serine and threonine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00261',
  'Monobactam biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00270',
  'Cysteine and methionine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00280',
  'Valine leucine and isoleucine degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00281',
  'Geraniol degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00290',
  'Valine leucine and isoleucine biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00300',
  'Lysine biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00310',
  'Lysine degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00311',
  'Penicillin and cephalosporin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00330',
  'Arginine and proline metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00331',
  'Clavulanic acid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00332',
  'Carbapenem biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00333',
  'Prodigiosin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00340',
  'Histidine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00350',
  'Tyrosine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00360',
  'Phenylalanine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00361',
  'Chlorocyclohexane and chlorobenzene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00362',
  'Benzoate degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00363',
  'Bisphenol degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00364',
  'Fluorobenzoate degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00365',
  'Furfural degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00380',
  'Tryptophan metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00400',
  'Phenylalanine tyrosine and tryptophan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00401',
  'Novobiocin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00402',
  'Benzoxazinoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00403',
  'Indole diterpene alkaloid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00404',
  'Staurosporine biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00405',
  'Phenazine biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00410',
  'beta-Alanine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00430',
  'Taurine and hypotaurine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00440',
  'Phosphonate and phosphinate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00450',
  'Selenocompound metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00460',
  'Cyanoamino acid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00480',
  'Glutathione metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00500',
  'Starch and sucrose metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00510',
  'N-Glycan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00511',
  'Other glycan degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00512',
  'Mucin type O-glycan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00513',
  'Various types of N-glycan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00514',
  'Other types of O-glycan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00515',
  'Mannose type O-glycan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00520',
  'Amino sugar and nucleotide sugar metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00521',
  'Streptomycin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00522',
  'Biosynthesis of 12- 14- and 16-membered macrolides'
);
INSERT INTO metabolic_pathways VALUES (
  'map00523',
  'Polyketide sugar unit biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00524',
  'Neomycin kanamycin and gentamicin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00525',
  'Acarbose and validamycin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00531',
  'Glycosaminoglycan degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00532',
  'Glycosaminoglycan biosynthesis - chondroitin sulfate / dermatan sulfate'
);
INSERT INTO metabolic_pathways VALUES (
  'map00533',
  'Glycosaminoglycan biosynthesis - keratan sulfate'
);
INSERT INTO metabolic_pathways VALUES (
  'map00534',
  'Glycosaminoglycan biosynthesis - heparan sulfate / heparin'
);
INSERT INTO metabolic_pathways VALUES (
  'map00540',
  'Lipopolysaccharide biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00541',
  'O-Antigen nucleotide sugar biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00542',
  'O-Antigen repeat unit biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00550',
  'Peptidoglycan biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00561',
  'Glycerolipid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00562',
  'Inositol phosphate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00563',
  'Glycosylphosphatidylinositol (GPI)-anchor biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00564',
  'Glycerophospholipid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00565',
  'Ether lipid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00571',
  'Lipoarabinomannan (LAM) biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00572',
  'Arabinogalactan biosynthesis - Mycobacterium'
);
INSERT INTO metabolic_pathways VALUES (
  'map00590',
  'Arachidonic acid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00591',
  'Linoleic acid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00592',
  'alpha-Linolenic acid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00600',
  'Sphingolipid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00601',
  'Glycosphingolipid biosynthesis - lacto and neolacto series'
);
INSERT INTO metabolic_pathways VALUES (
  'map00603',
  'Glycosphingolipid biosynthesis - globo and isoglobo series'
);
INSERT INTO metabolic_pathways VALUES (
  'map00604',
  'Glycosphingolipid biosynthesis - ganglio series'
);
INSERT INTO metabolic_pathways VALUES (
  'map00620',
  'Pyruvate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00621',
  'Dioxin degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00622',
  'Xylene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00623',
  'Toluene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00624',
  'Polycyclic aromatic hydrocarbon degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00625',
  'Chloroalkane and chloroalkene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00626',
  'Naphthalene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00627',
  'Aminobenzoate degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00630',
  'Glyoxylate and dicarboxylate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00633',
  'Nitrotoluene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00640',
  'Propanoate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00642',
  'Ethylbenzene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00643',
  'Styrene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00650',
  'Butanoate metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00660',
  'C5-Branched dibasic acid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00670',
  'One carbon pool by folate'
);
INSERT INTO metabolic_pathways VALUES (
  'map00730',
  'Thiamine metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00740',
  'Riboflavin metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00750',
  'Vitamin B6 metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00760',
  'Nicotinate and nicotinamide metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00770',
  'Pantothenate and CoA biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00780',
  'Biotin metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00785',
  'Lipoic acid metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00790',
  'Folate biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00791',
  'Atrazine degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00830',
  'Retinol metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00860',
  'Porphyrin and chlorophyll metabolism'
);
INSERT INTO metabolic_pathways VALUES (
  'map00900',
  'Terpenoid backbone biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00901',
  'Indole alkaloid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00902',
  'Monoterpenoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00903',
  'Limonene and pinene degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00904',
  'Diterpenoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00905',
  'Brassinosteroid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00906',
  'Carotenoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00908',
  'Zeatin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00909',
  'Sesquiterpenoid and triterpenoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00930',
  'Caprolactam degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map00940',
  'Phenylpropanoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00941',
  'Flavonoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00942',
  'Anthocyanin biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00943',
  'Isoflavonoid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00944',
  'Flavone and flavonol biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00945',
  'Stilbenoid diarylheptanoid and gingerol biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00950',
  'Isoquinoline alkaloid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00960',
  'Tropane piperidine and pyridine alkaloid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00965',
  'Betalain biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00966',
  'Glucosinolate biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00980',
  'Metabolism of xenobiotics by cytochrome P450'
);
INSERT INTO metabolic_pathways VALUES (
  'map00981',
  'Insect hormone biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map00982',
  'Drug metabolism - cytochrome P450'
);
INSERT INTO metabolic_pathways VALUES (
  'map00983',
  'Drug metabolism - other enzymes'
);
INSERT INTO metabolic_pathways VALUES (
  'map00984',
  'Steroid degradation'
);
INSERT INTO metabolic_pathways VALUES (
  'map01040',
  'Biosynthesis of unsaturated fatty acids'
);
INSERT INTO metabolic_pathways VALUES (
  'map01051',
  'Biosynthesis of ansamycins'
);
INSERT INTO metabolic_pathways VALUES (
  'map01052',
  'Type I polyketide structures'
);
INSERT INTO metabolic_pathways VALUES (
  'map01053',
  'Biosynthesis of siderophore group nonribosomal peptides'
);
INSERT INTO metabolic_pathways VALUES (
  'map01054',
  'Nonribosomal peptide structures'
);
INSERT INTO metabolic_pathways VALUES (
  'map01055',
  'Biosynthesis of vancomycin group antibiotics'
);
INSERT INTO metabolic_pathways VALUES (
  'map01056',
  'Biosynthesis of type II polyketide backbone'
);
INSERT INTO metabolic_pathways VALUES (
  'map01057',
  'Biosynthesis of type II polyketide products'
);
INSERT INTO metabolic_pathways VALUES (
  'map01058',
  'Acridone alkaloid biosynthesis'
);
INSERT INTO metabolic_pathways VALUES (
  'map01059',
  'Biosynthesis of enediyne antibiotics'
);
