https://github.com/safak/youtube/tree/mern-deployment

rsync -av -e "ssh -i /mnt/c/Users/nikhi/OneDrive/Desktop/FT/ec2.pem" /mnt/c/Users/nikhi/OneDrive/Desktop/FT/Projects/MERN_Nginx/frontend/build/ ec2-user@18.207.120.63:/home/ec2-user

scp -i /mnt/c/Users/nikhi/OneDrive/Desktop/FT/ec2.pem /mnt/c/Users/nikhi/OneDrive/Desktop/FT/Projects/MERN_Nginx/frontend/build/manifest.json ec2-user@18.207.120.63:/home/ec2-user
