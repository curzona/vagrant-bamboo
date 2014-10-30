apt-get -y update
apt-get -y install vim curl nmap tree zip htop upstart 
apt-get -y install openjdk-7-jre-headless

wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.6.2.tar.gz
tar -zxf atlassian-bamboo-5.6.2.tar.gz
mv atlassian-bamboo-5.6.2 /opt/bamboo-server
chown -R www-data /opt/bamboo-server

mkdir /vagrant/bamboo-server
chown -R www-data /vagrant/bamboo-server
cp /opt/bamboo-server/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties /opt/bamboo-server/atlassian-bamboo/WEB-INF/classes/bamboo-init.dist.properties
sed -e "s/#bamboo.home=C:\/bamboo\/bamboo-home/bamboo.home=\/vagrant\/bamboo-server/g" \
    -i /opt/bamboo-server/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties

cp /vagrant/bamboo-server.init /etc/init.d/bamboo-server
chmod +x /etc/init.d/bamboo-server
update-rc.d bamboo-server defaults
/etc/init.d/bamboo-server start