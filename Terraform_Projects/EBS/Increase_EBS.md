# EBS Volume Size Increase

This guide demonstrates how to increase the size of an existing Amazon Elastic Block Store (EBS) volume from 8GB to 10GB.

## Steps to Resize EBS Volume

### 1. **Log in to AWS Management Console**
   - Go to the [AWS Console](https://aws.amazon.com/console/) and log in to your account.

### 2. **Navigate to EC2 Console**
   - In the AWS Management Console, navigate to **EC2**.

### 3. **Locate the EBS Volume**
   - In the left sidebar, select **Volumes** under the **Elastic Block Store** section.
   - Find the volume you want to resize (in this case, the 8GB volume).

### 4. **Modify the Volume**
   - Select the volume and click on the **Actions** dropdown.
   - Choose **Modify Volume**.
   - In the **Size** field, change the size from **8GB** to **10GB**.
   - Click **Modify** and confirm the action.

### 5. **Resize the File System on the Instance**
   - Once the volume size has been modified, connect to your EC2 instance via SSH.
   - Run the following command to check the current file system:

     ```bash
     lsblk
     ```

   - Find the EBS volume (e.g., `/dev/xvdf` or `/dev/nvme1n1`).

   - Use the `xfs_growfs` command to resize the file system:

     ```bash
     sudo xfs_growfs -d /myebsvol
     ```

     Replace `/myebsvol` with the appropriate mount point of your volume.

### 6. **Verify the New Size**
   - To confirm the new size, run the following:

     ```bash
     df -h
     ```

   - You should see the new volume size of 10GB.

## Notes:
- Ensure you have backups of important data before resizing.
- The steps are for Linux-based instances. If you're using a different OS, follow the appropriate procedure.
- It may take a few minutes for the volume resize to complete in AWS.

## Troubleshooting:
- If the disk does not show the increased size, ensure the file system was correctly resized using `xfs_growfs`.
- If issues persist, consult the [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html).

---

Happy Resizing!
