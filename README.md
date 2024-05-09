# Bulk_Alignment
Nathan Kochhar's Bulk RNA-seq alignment program for final project
### Overview
The web application will take in 2 fastq files, a R1 and R2 read, and will preform: a fastqc check, adapter trimming, and a STAR alignment with gene counts. This app will work with only paired-end human sequencing data and requires that you know the path to the fastq files you want to align that are on the Google Cloud Machine. The app will then preform the analysis and show you the paths to the relavent files and will print out the head of the counts matrix. 
### Google Cloud Virtual Machine
The application uses a google cloud virtual machine instead of the bfx server due to the cost of both computation and space of rna-seq alignment. The virtual machine was made and configured using Ubuntu, 24 cores, 12 vCPUs, 64GB RAM and 450GB of storage. 
### Workflow
Using this application is as simple as uploading your data to the GCP, knowing the path, and inputting the paths.
The application can be found here: http://34.69.206.230/aligner_FE.html

Test fastqs are located here for trials of the app:
* /home/nathankochhar/test_fastqs/test_R1.fastq
* /home/nathankochhar/test_fastqs/test_R2.fastq

After submitting the program will take a while to run, this is because alignment is a computational expensive task, and will output:
* an echo of your inputs
* the fastqc folder path
* the trimmed fastq paths
* the aligned bam file path
* the counts matrix path
* the head of the counts matrix



### Future ideas
This project is a good start and foundation for a platform to run rna-seq alignments. This web app has plenty of room for improvements and the list could go on forever, some ideas are:
* more species for alignment
* ability to change strandedness of sequencing
* file upload/download via frontend
* mutliqc report
* much more

This has been a very difficult and time consuming project for me and I have learned a lot thoughout the process. Starting with my first time using GCM which was a pain in my opinion, having ssh issue to running out of resources and having to create a new machine. I also had to set of a VM for the first time from installing all dependencies and apache to get my code to work. It has been a long process but I hope you like the end result!

This machine will only be active for a short time due to the cost of keeping it up and running. 
