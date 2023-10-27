# File Integrity Monitor

A PowerShell script for monitoring and maintaining the integrity of files in a specified folder or directory.

## Overview

File integrity monitoring is a process of ensuring that files within a system remain unchanged, uncorrupted, and authentic. This script uses hashing to verify file integrity.

## Features

- Creates a baseline of file hashes for a specified directory.
- Continuously monitors the directory for any changes.
- Detects newly created, modified, and deleted files.

## Usage

1. Run the script and choose to create a new baseline or start monitoring using an existing baseline.
2. Provide the folder path to monitor.
3. The script calculates file hashes and maintains a baseline configuration file in a "baseline.txt" file.
4. It then checks for file integrity changes, such as file creation, modification, or deletion using Hashing.




