#create db
CREATE DATABASE IF NOT EXISTS rnaseq_analysis;
USE rnaseq_analysis;

#genomes
CREATE TABLE IF NOT EXISTS genomes (
    species VARCHAR(50) PRIMARY KEY,
    genome_path VARCHAR(255) NOT NULL
);

#populate genomes
INSERT INTO genomes (species, genome_path) VALUES
('human', '/home/nathankochhar/genome/STAR_index');

#run_info
CREATE TABLE IF NOT EXISTS run_info (
    run_id INT AUTO_INCREMENT PRIMARY KEY,
    r1_fastq_path VARCHAR(255) NOT NULL,
    r2_fastq_path VARCHAR(255),
    genome VARCHAR(50) NOT NULL,
    sequencing_type ENUM('single', 'paired') NOT NULL,
    FOREIGN KEY (genome) REFERENCES genomes(species)
);

#outputs
CREATE TABLE IF NOT EXISTS outputs (
    output_id INT AUTO_INCREMENT PRIMARY KEY,
    run_id INT NOT NULL,
    fastqc_R1_path VARCHAR(255),
    fastqc_R2_path VARCHAR(255),
    trimmed_R1_path VARCHAR(255),
    trimmed_R2_path VARCHAR(255),
    aligned_bam_path VARCHAR(255),
    ReadsPerGene_path VARCHAR(255),
    FOREIGN KEY (run_id) REFERENCES run_info(run_id)
);

