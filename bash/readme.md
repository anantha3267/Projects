# Command History Breakdown

This document contains a list of unique shell commands used during a session, categorized and explained for reference.

---

## **Shell Basics**

- `sh`  
  Starts a shell session using the `sh` shell (Bourne shell).

- `bash`  
  Starts a shell session using the `bash` shell (Bourne Again Shell), the default shell on most Linux systems.

- `clear`  
  Clears the terminal screen for better readability.

- `history`  
  Displays the history of commands executed in the current shell session.

---

## **File and Directory Operations**

- `ls`  
  Lists the contents of the current directory.

- `ls -l`  
  Lists directory contents in long format (detailed view).

- `ls -lt`  
  Lists directory contents sorted by modification time, newest first.

- `ls -ltr`  
  Lists directory contents sorted by modification time, newest last.

- `rm New\ Text\ Document.txt`  
  Deletes a file named `New Text Document.txt`.

- `rm -rf New\ folder/`  
  Forcefully removes a directory named `New folder` and its contents.

- `rmdir New\ folder/`  
  Removes an empty directory named `New folder`.

---

## **Script Execution**

- `cat first.sh`  
  Displays the contents of the file `first.sh`.

- `sh first.sh`  
  Executes the shell script `first.sh` using the `sh` shell.

- `./first.sh`  
  Executes the shell script `first.sh` directly if it has execute permissions.

- `vi first.sh`  
  Opens the file `first.sh` in the `vi` editor for editing.

- `./nodeHealth.sh`  
  Executes the shell script `nodeHealth.sh` directly if it has execute permissions.

---

## **System Monitoring**

- `free`  
  Displays system memory usage.

- `free -g`  
  Displays system memory usage in gigabytes.

- `nproc`  
  Displays the number of available CPU cores.

- `df -h`  
  Displays disk space usage in human-readable format.

- `top`  
  Displays real-time system processes and resource usage.

- `htop`  
  Interactive and visually improved version of `top`.

- `ps -ef`  
  Displays all running processes in a detailed format.

- `ps -f | grep wsl`  
  Filters the running processes to show only those containing `wsl`.

- `ps -ef | grep wsl | awk -F" " '{print $2}'`  
  Extracts the Process IDs (PIDs) of processes related to `wsl`.

---

## **Text Search**

- `grep set nodeHealth.sh`  
  Searches for the word "set" in the file `nodeHealth.sh`.

- `curl https://github.com/iam-veeramalla/sandbox/blob/main/log/dummylog01122022.log | grep error`  
  Fetches the file from the provided URL and filters lines containing the word "error".

- `cat dummylog01122022.log | grep error`  
  Searches for the word "error" in the file `dummylog01122022.log`.

---

## **Networking**

- `curl https://github.com/iam-veeramalla/sandbox/blob/main/log/dummylog01122022.log`  
  Fetches the file from the provided URL using the `curl` command.

- `wget https://github.com/iam-veeramalla/sandbox/blob/main/log/dummylog01122022.log`  
  Downloads the file from the provided URL using the `wget` command.

- `curl -X GET https://google.com`  
  Sends a `GET` request to `https://google.com` explicitly using `curl`.

---

## **File Search**

- `sudo find /usr -name pam`  
  Searches for a file or directory named `pam` in the `/usr` directory with `sudo` privileges.

- `sudo find / -name pam`  
   Searches all directores

---

## **Date and Time**

- `date`  
  Displays the current date and time.

---

Let me know if you want additional modifications or enhancements!
