#create db
CREATE DATABASE nkochha1_final;
USE nkochha1_final;

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

#populate run_info
INSERT INTO run_info (r1_fastq_path, r2_fastq_path, genome, sequencing_type) VALUES
('/home/nathankochhar/test_fastqs/test_r1.fastq', '/home/nathankochhar/test_fastqs/test_r1.fastq', 'human', 'single');

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

#populate outputs
INSERT INTO outputs (run_id, fastqc_R1_path, fastqc_R2_path, trimmed_R1_path, trimmed_R2_path, aligned_bam_path, ReadsPerGene_path) VALUES
(1, '/home/nathankochhar/fastqc/test_r1_fastqc.html', '/home/nathankochhar/fastqc/test_r1_fastqc.html', '/home/nathankochhar/test_fastqs/trimmed_r1.fastq', '/home/nathankochhar/trimmed_fastqs/test_r1.fastq', '/home/nathankochhar/STAR_outs/testAligned.sortedByCoord.out.bam', '/home/nathankochhar/STAR_outs/testReadsPerGene.out.tab');

SELECT * FROM genomes;
SELECT * FROM run_info;
SELECT * FROM outputs;
