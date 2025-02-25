# Setting Up and Mounting a New EBS Volume on EC2

This guide walks through the process of creating and attaching a new Amazon EBS volume to an EC2 instance.

## Prerequisites
- An existing EC2 instance running Linux.
- A new EBS volume created and attached to the EC2 instance.

## Steps

1. **Check Available Block Devices**
   ```sh
   lsblk
   ```
   This command lists available block devices and their mount points.

2. **Check Disk Space Usage**
   ```sh
   df -h
   ```
   Displays disk space usage in human-readable format.

3. **List Disk Partitions**
   ```sh
   sudo fdisk -l
   ```
   Shows the disk partitions and confirms the newly attached EBS volume.

4. **Check Filesystem Type**
   ```sh
   sudo file -s /dev/xvdk
   ```
   This checks if the device has a filesystem. If it returns `data`, the disk is unformatted.

5. **Format the EBS Volume**
   ```sh
   sudo mkfs -t xfs /dev/xvdk
   ```
   Formats the volume with the XFS filesystem.

6. **Verify Filesystem Creation**
   ```sh
   sudo file -s /dev/xvdk
   ```
   Ensures the volume has been formatted properly.

7. **Create a Mount Directory**
   ```sh
   sudo mkdir /myebsvol
   ```
   Creates a directory to mount the EBS volume.

8. **Mount the EBS Volume**
   ```sh
   sudo mount /dev/xvdk /myebsvol
   ```
   Mounts the formatted EBS volume to the directory.

9. **Verify Mounting**
   ```sh
   df -h
   ```
   Confirms that the volume is mounted and accessible.

## Persistence Across Reboots
To ensure the EBS volume is automatically mounted on reboot, add an entry to `/etc/fstab`:

```sh
sudo blkid /dev/xvdk
```
Copy the UUID and add the following line to `/etc/fstab`:
```
UUID=<your-uuid>  /myebsvol  xfs  defaults,nofail  0  2
```

## Conclusion
You have successfully attached and mounted an EBS volume to your EC2 instance. Ensure to update `/etc/fstab` to maintain persistence across reboots.
