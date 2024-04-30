<h1> <br>Windows PowerShell File Integrity Monitor <br></h1>
<h2>Overview</h2>
This is a simple file integrity monitor (FIM) written in Windows PowerShell. File integrity monitoring is a crucial aspect of cybersecurity used to detect unauthorized changes to critical files and directories. It helps ensure the security and integrity of systems and data by monitoring for any alterations or modifications made to files, which could indicate malicious activity or unauthorized access.

One common method used in file integrity monitoring is the calculation of checksums, such as SHA256 hashes, to verify the integrity of files. SHA256 is a cryptographic hash function that generates a fixed-size output (256 bits) regardless of the input size. It is widely used in security applications, including file integrity monitoring, to ensure data integrity and authenticity.

<h2>Baseline Setup</h2>
Before monitoring begins, it's essential to establish a baseline of known good files. This baseline represents the initial state of the system, with checksums calculated for all files. To set up a baseline, run the script and choose option A. This will calculate and store the SHA256 hashes of all files in the specified directories, establishing a reference point for future comparisons.

<h2>Monitoring Mode</h2>
Once the baseline is established, the script can be switched to monitoring mode. In monitoring mode, the script continuously checks the files and directories against their baseline checksums to detect any changes. To activate monitoring mode, run the script and choose option B.

<h2>Detection of Changes</h2>
If the contents of a file are edited, a warning message will be displayed in yellow text to indicate a potential modification.
If any file is deleted, a warning message will be displayed in red text to indicate a potential security issue.
<h2>Usage</h2>
Clone or download the repository to your local machine.
Run the script FIM.ps1.
Follow the prompts to choose between setting up a baseline (option A) or entering monitoring mode (option B).
If in monitoring mode, keep the script running in the background to continuously monitor file integrity.
<h2>Disclaimer</h2>
This script is provided for educational purposes and should be used with caution. It may require modifications to suit specific environments or security requirements. Always ensure proper permissions and security measures are in place when implementing file integrity monitoring solutions.

Feel free to contribute to the project by submitting bug fixes, enhancements, or feature requests through GitHub pull requests and issues.

Happy monitoring!


