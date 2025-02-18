####

Before to use the ansible script execute the below steps to configure python, oci cli SDK, ansible,and ansible colletions to your Linux station


these steps have been tested for oracle linux 8

the scripts will install configure an oracle linux 8 user, put him to sudoers and run the installation as oracle


yum install -y oracle-database-preinstall-19c

echo "opc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "oracle ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

mkdir -p /home/oracle/.ssh
cp /home/opc/.ssh/authorized_keys /home/oracle/.ssh/authorized_keys
chown -R oracle.oinstall /home/oracle/.ssh/authorized_keys

sudo dnf install -y python3 python3-pip git zip unzip
sudo dnf install -y oracle-epel-release-el8
sudo dnf config-manager --enable ol8_developer_EPEL

sudo dnf install python3.11
sudo su - oracle
sudo alternatives --set python3 /usr/bin/python3.11
python --version

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user

export PATH=/home/oracle/.local/bin:$PATH
pip install --user ansible
pip3 install oci
python3 -c "import oci; print(oci.__version__)"

oci --version

pip install jmespath
ansible-galaxy collection install community.general --force
ansible-galaxy collection install oracle.oci
ansible-galaxy collection list | grep oracle.oci

At this stage the oracle user is configured to run the ansible collections, use the oci cli.  
  
You have to create an API key in Oracle OCI infrastructure and create the config file to use during your calls 
