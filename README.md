# File Integrity Monitor

A PowerShell script for monitoring and maintaining the integrity of files in a specified folder or directory.

## Overview

File integrity monitoring is a process of ensuring that files within a system remain unchanged, uncorrupted, and authentic. This script uses hashing to verify file integrity.

## Features

- Creates a baseline of file hashes for a specified directory.
- Continuously monitors the directory for any changes, with the current monitoring interval set to 5 seconds (modifiable).
- Detects newly created, modified, and deleted files.

## Usage

1. Run the script and provide the folder path to be monitored.
2. The script calculates file hashes and maintains a baseline configuration file in a "baseline.txt" file in the parent directory.
3. It then checks for file integrity changes, such as file creation, modification, or deletion using hashing.

## Outputs

![powershell](https://github.com/cs-vansh/FileIntegrityMonitor/assets/104628209/6f6c7cf3-6dee-44bd-a07a-e9e92fed73ca)

## Future Scope

- Separate logic for creation of baseline and monitoring
- Enable hash algorithm selection (SHA256, MD5,etc.)
- Implement Recursive checking for all levels 


