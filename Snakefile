# Cocentration Bias in Intertemporal Choice
# Replication
#
# Authors:
# Lachlan Deer (@lachlandeer)
# Sigmund Ellingsrud  
# Felix Heuer
# Amund Kordt

# --- Variable Declarations ---# 
runR = "Rscript --no-save --no-restore --verbose"
logAll = "2>&1"

# --- Rules --- # 

rule all:
    input:
        table2 = "out_models/table2.Rds", 
        table3 = "out_models/table3.Rds" ,
        money  = "out_models/money_experiment.Rds",
        fig1 = "out_figs/d_rel_tab2.pdf",
        fig2 = "out_figs/d_rel_tab3_col1.pdf",
        fig3 = "out_figs/d_rel_tab3_col2.pdf",
        fig4 = "out_figs/d_rel_tab3_col3.pdf",
        fig5 = "out_figs/d_rel_tab3_col4.pdf"

rule moneyexperiment:
    input:
        script = "code/money_experiment.R",
        data = "data/Money_Experiment.csv",
    output:
        data = "out_models/money_experiment.Rds",
    log:
        "logs/money_experiment.txt"
    shell:
        "{runR} {input.script} > {log} {logAll}"

rule table3:
    input:
        script = "code/table_3.R",
        data = "out_data/consumption_experiment.csv",
    output:
        data = "out_models/table3.Rds",
    log:
        "logs/table3.txt"
    shell:
        "{runR} {input.script} > {log} {logAll}"

rule table2:
    input:
        script = "code/table_2.R",
        data = "out_data/consumption_experiment.csv",
    output:
        data = "out_models/table2.Rds",
    log:
        "logs/table2.txt"
    shell:
        "{runR} {input.script} > {log} {logAll}"

rule plot_drel:
    input:
        script = "code/plot_drel.R",
        data = "out_data/consumption_experiment.csv",
    output:
        fig1 = "out_figs/d_rel_tab2.pdf",
        fig2 = "out_figs/d_rel_tab3_col1.pdf",
        fig3 = "out_figs/d_rel_tab3_col2.pdf",
        fig4 = "out_figs/d_rel_tab3_col3.pdf",
        fig5 = "out_figs/d_rel_tab3_col4.pdf"
    log:
        "logs/plot_drel.txt"
    shell:
        "{runR} {input.script} > {log} {logAll}"

rule compute_drel:
    input:
        script = "code/compute_drel.R",
        data = "data/Consumption_Experiment.csv",
    output:
        data = "out_data/consumption_experiment.csv",
    log:
        "logs/compute_drel.txt"
    shell:
        "{runR} {input.script} > {log} {logAll}"

# --- Clean --- #
# removes all outputs, so can re-run workflow

## clean_output   : delete all built files in project's output and ROOT directory
rule clean_output:
    shell:
        "rm -rf out*"

# --- Confugure renv --- #
# Include all other Snakefiles that contain rules that are part of the project
include: "renv.smk"

# --- Workflow --- # 
## dag                : create the DAG as a pdf from the Snakefile
rule dag:
    input:
        "Snakefile"
    output:
        "dag.pdf"
    shell:
        "snakemake --dag | dot -Tpdf > {output}"

## filegraph          : create the file graph as pdf from the Snakefile 
##                     (i.e what files are used and produced per rule)
rule filegraph:
    input:
        "Snakefile"
    output:
        "filegraph.pdf"
    shell:
        "snakemake --filegraph | dot -Tpdf > {output}"

## rulegraph          : create the graph of how rules piece together 
rule rulegraph:
    input:
        "Snakefile"
    output:
        "rulegraph.pdf"
    shell:
        "snakemake --rulegraph | dot -Tpdf > {output}"

## rulegraph_to_png
rule rulegraph_to_png:
    input:
        "rulegraph.pdf"
    output:
        "assets/rulegraph.png"
    shell:
        "pdftoppm -png {input} > {output}"

# installers for Ubuntu
## install_graphviz   : install necessary packages to visualize Snakemake workflow 
rule graphviz:
    shell:
        "sudo apt-get install graphviz"

## install_graphviz_mac : install necessary packages to visualize Snakemake workflow on a mac 
rule graphviz_mac:
    shell:
        "brew install graphviz"

## install_poppler: install poppler-utils on ubuntu
rule install_poppler:
    shell:
        "sudo apt-get install -y poppler-utils"
