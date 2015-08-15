FROM phusion/passenger-ruby21:0.9.17
MAINTAINER Adrian Norberto Marino "adrianmarino@gmail.com"
#==============================================================================
#
#
#
#==============================================================================
# Linux
#==============================================================================
# Install prerequisites
RUN \
	apt-get update && \
 	apt-get install -y nodejs && \
 	apt-get install -y vim && \
 	apt-get install -y nmap && \
 	apt-get install -y mysql-client && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
#
#
#==============================================================================
# Nginx
#==============================================================================
# Start Nginx
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add config
ADD docker/nginx-app.conf /etc/nginx/sites-enabled/app.conf
ADD docker/nginx-env.conf /etc/nginx/main.d/env.conf
#==============================================================================
#
#
#
#==============================================================================
# Aplication
#==============================================================================
# Prepare folders
RUN mkdir -p /home/app
WORKDIR /home/app

# Install required gems
ADD Gemfile /home/app/
ADD Gemfile.lock /home/app/
RUN bundle install --jobs 8 --deployment --without development test

# Add app files
ADD . /home/app

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

RUN echo "SECRET_KEY_BASE='$(RAILS_ENV=production rake secret)'" >> /etc/environment

# Set permissions for tmp and log directories
RUN mkdir -p /home/app/tmp /home/app/log && chown -R app:app /home/app/tmp /home/app/log
#==============================================================================

EXPOSE 80
