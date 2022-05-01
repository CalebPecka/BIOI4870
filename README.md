# A Database for Microbial Contributions to Metabolites (MCM)

**Abstract**

Dysbiosis in the bacterial gut microbiome leads to both positive and negative health impacts on the host organism. Changes in host health can in part be attributed to the altered ability of the microbiome to participate in various metabolic pathways. The purpose of this project is to curate and organize predicted bacterial contributions to metabolites in transgenic claudin phenotypes of Mus musculus. The public facing webpage for this project visualizes ~100 metabolic pathways and how effectively individual differentially abundant bacteria can contribute to the pathway. These results are of interest to biologists exploring how changes in claudin gene expression negatively impacts host health via mechanisms of bacterial dysbiosis.

**Project Specifications**

This project was created on the Linux IS&T Odin environment. Each user was limited to 1GB on Odin. Default software installation include Apache, Biopython, emacs, Flex, Git, GNU C, GNU C++, LaTeX, MySQL, MySQL Python, NLTK, Tkinter, numpy, Matplotlib, OpenJDK, Perl, PHP, php-mysql, Python, R, sqlite3, tcsh, and vim. 

**Usage**

Replication of this project requires R and SQL coding workspaces. Data can be replicated using documentation found in the 'scripts' subdirectory if the user is interested in updated the data to the latest available information. SQL scripts were populated in the Odin environment. Connection variables to the SQL tables must be modified in each SQL file in the 'scripts' subdirectory, as well as all connections in the 'public_html' subdirectory. All files in the 'public_html' directory must be accessible with chmod 755 permissions and enabled with PHP.
