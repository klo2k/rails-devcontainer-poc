FROM ruby:3.0-bullseye

LABEL org.opencontainers.image.revision="-"
LABEL org.opencontainers.image.source="https://bitbucket.org/klo2k/rails-devcontainer/"

# Create "rails" app user (so we don't run as root)
# User has static uid+gid (help extensions) and cannot login via shell (security)
RUN \
    mkdir /srv/rails/ && \
    groupadd --gid 10001 rails && \
    useradd \
        --uid 10001 --gid rails \
        --home-dir /srv/rails --no-create-home \
        --shell /usr/sbin/nologin \
        rails && \
    usermod --lock rails && \
    chown rails:rails /srv/rails

# Install Rails
RUN \
    apt update && \
    apt install --assume-yes --no-install-recommends \
        # sqlite
        sqlite3 \
        # Node.js
        npm nodejs && \
    # Yarn
    npm install --global yarn && \
    # Rails
    gem install rails && \
    # Clean-up
    apt clean

# Install app dependencies
COPY src/blog/Gemfile /root/Gemfile
RUN bundle install --gemfile=/root/Gemfile

# Install quality-of-life debug tools
RUN apt install --assume-yes \
        less \
        vim && \
    apt clean

# Install debugger
RUN gem install debase ruby-debug-ide

# Copy src into image
#COPY src/blog /srv/rails/blog

# Run as rails user (non-root)
USER rails

# HTTP server port
EXPOSE 3000
# Debug port
EXPOSE 1234

# Start app, using code from /srv/rails/blog
WORKDIR /srv/rails/blog

USER root
CMD \
    # Change uid and gid to match host's
    groupmod --gid ${DEBUG_HOST_GID} rails && \
    usermod --uid ${DEBUG_HOST_UID} --gid ${DEBUG_HOST_GID} rails && \
    # Startup rails in debug mode, under the "rails" account (same as normal app image)
    su --shell /bin/sh rails --command 'rm -f /tmp/server.pid && \
        /usr/local/bundle/bin/rdebug-ide \
        --skip_wait_for_start \
        --host 0.0.0.0 --port 1234 \
        -- /srv/rails/blog/bin/rails server \
        --pid /tmp/server.pid \
        --environment=development \
        --binding=0.0.0.0 --port=3000'
