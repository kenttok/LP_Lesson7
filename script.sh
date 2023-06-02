#!/bin/bash
yum install redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc openssl-devel zlib-devel pcre-devel -y
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm
rpm -i nginx-1.20.2-1.el8.ngx.src.rpm 
yum-builddep /root/rpmbuild/SPECS/nginx.spec
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el7.ngx.x86_64.rpm
systemctl start nginx
mkdir /usr/share/nginx/html/repo
createrepo /usr/share/nginx/html/repo/
cp /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo/nginx-1.20.2-1.el7.ngx.x86_64.rpm
cd /etc/nginx/conf.d/
sed '/index  index.html index.htm;/a autoindex on;' default.conf>default.tmp
mv default.tmp default.conf
nginx -s reload
createrepo /usr/share/nginx/html/repo/
