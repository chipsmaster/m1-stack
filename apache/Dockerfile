FROM debian:stretch-slim
ARG MAGENTO_USER_ID
ARG MAGENTO_USER_GROUP_ID

# Base packages
RUN apt update && apt install -y \
	apache2 php7.0 libapache2-mod-php7.0 php-xdebug \
	php-xdebug php-xml php-mysql php-curl php-gd php-soap php-mbstring 

# Other packages (utils)
RUN apt install -y wget curl less vim nano net-tools tcpdump \
	mysql-client

# Mailhog's sendmail
RUN wget 'https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64' -O /usr/local/bin/mhsendmail \
	&& chmod a+x /usr/local/bin/mhsendmail

# Create Magento user
RUN groupadd --gid $MAGENTO_USER_GROUP_ID magento \
	&& useradd --uid $MAGENTO_USER_ID --gid $MAGENTO_USER_GROUP_ID --create-home magento \
	&& echo "cd /var/www/magento" >> /home/magento/.bashrc

# Some special config
RUN a2enmod rewrite \
	&& echo "export APACHE_RUN_USER=magento" >> /etc/apache2/envvars \
	&& echo "export APACHE_RUN_GROUP=magento" >> /etc/apache2/envvars

# Add/overwrite etc contents to /etc
COPY etc /etc/

RUN ln -s /etc/php/7.0/common/*.ini /etc/php/7.0/apache2/conf.d/ \
	&& ln -s /etc/php/7.0/common/*.ini /etc/php/7.0/cli/conf.d/

CMD [ "/usr/sbin/apache2ctl", "-DFOREGROUND" ]
