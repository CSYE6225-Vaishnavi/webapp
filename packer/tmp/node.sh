sudo yum update -y



sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum install -y nodejs



sudo yum install unzip
unzip /home/ec2-user/webapp.zip
sudo chmod 755 webapp/
cd webapp/ 
sudo npm install
sudo npm install bcrypt

