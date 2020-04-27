# Download base image Ubuntu 16.04.
FROM ubuntu:16.04

# Update Ubuntu Software repository. This is required to install packages.
# Install the following packages:
RUN apt-get update && apt-get install -y postgresql iputils-ping net-tools \
	netcat vim

# Create the folder for data directory
RUN mkdir -p /home/postgres/data/postgres && \
	mkdir -p /home/postgres/data/logs && \
	mkdir -p /usr/local/bin/cluster/postgresql && \
	chown -R postgres:staff /home/postgres/ && \
	chmod 700 /home/postgres/data/postgres

# Switch to postgresql user
USER postgres

# Copy deploy scripts in /usr/local/bin/cluster container folder.
COPY ./postgresql /usr/local/bin/cluster/postgresql
	
# Expose the PostgreSQL default port
EXPOSE 5432

# Use bash as extry point.
ENTRYPOINT /usr/local/bin/cluster/postgresql/entrypoint.sh
