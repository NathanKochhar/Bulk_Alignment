#!/usr/bin/python3

import subprocess
import cgi
import jinja2
import re
import mysql.connector
import html

form = cgi.FieldStorage()

r1_path = form.getvalue('r1_fastq')
r2_path = form.getvalue('r2_fastq')

templateLoader = jinja2.FileSystemLoader( searchpath="./templates" )

env = jinja2.Environment(loader=templateLoader)
template = env.get_template('final.html')


# Execute FastQC

subprocess.Popen(["/home/nathankochhar/FastQC/fastqc", r1_path, r2_path, "-o", "/home/nathankochhar/fastqc/"])
fastqc_path = "/home/nathankochhar/fastqc/"
#/home/nathankochhar/FastQC/fastqc /home/nathankochhar/test_fastqs/test_R1.fastq /home/nathankochhar/test_fastqs/test_R2.fastq -o /home/nathankochhar/fastqc/

# Execute Trimmomatic
trimmed_base_dir = "/home/nathankochhar/trimmed_fastqs"

r1_file_name = r1_path.split("/")[-1]
r2_file_name = r2_path.split("/")[-1]

trimmed_r1 = trimmed_base_dir + "/" + r1_file_name
trimmed_r2 = trimmed_base_dir + "/" + r2_file_name

subprocess.Popen([
    "java", "-jar","/home/nathankochhar/Trimmomatic-0.39/trimmomatic-0.39.jar", 
    "PE", "-phred33", r1_path, r2_path, trimmed_r1, trimmed_r2, 
    "LEADING:3", "TRAILING:3", "SLIDINGWINDOW:4:15", "MINLEN:36"
])


star_index = "/home/nathankochhar/genome/STAR_index"
file_name = r1_file_name.split("_")[0]
out_path = "/home/nathankochhar/STAR_outs/" + file_name


subprocess.Popen([
    "/home/nathankochhar/STAR/source/STAR", "--runThreadN","8", "--genomeDir", star_index,
    "--readFilesIn", r1_path, r2_path, "--outFileNamePrefix", out_path,
    "--outSAMtype", "BAM", "SortedByCoordinate", "--quantMode", "GeneCounts"
])


star_bam = out_path + "Aligned.sortedByCoord.out.bam"
star_counts = out_path + "ReadsPerGene.out.tab"

lines = []
with open(star_counts, 'r') as file:
    for _ in range(10):
        line = file.readline().strip()
        if line:
            
            parts = line.split('\t')
            lines.append((parts[0], parts[1]))
        else:
            break

# Render the template with form data
output_html = template.render(
    r1_path=r1_path,
    r2_path=r2_path,
    fastqc_path = fastqc_path,
    trimmed_r1 = trimmed_r1,
    trimmed_r2 = trimmed_r2,
    star_bam = star_bam,
    star_counts = star_counts,
    lines = lines
)

print("Content-Type: text/html\n\n")

print(output_html)
