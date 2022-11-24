FROM ruby:3.1.2

LABEL org.opencontainers.image.revision="-"
LABEL org.opencontainers.image.source="https://bitbucket.org/klo2k/rails-devcontainer/"

# Create "rails" app user (so we don't run as root), and directory for site's code
# Override IDs via `--build-arg` / "docker-compose.override.yml" as necessary
ARG APP_UID=10001
ARG APP_GID=10001
RUN \
    groupadd --gid ${APP_UID} rails && \
    useradd \
        --uid ${APP_UID} --gid rails \
        --home-dir /home/rails --create-home \
        --shell /usr/sbin/nologin \
        rails && \
    usermod --lock rails && \
    chown rails:rails /home/rails && \
    # Path for site's code
    mkdir /site && chown rails:rails /site

# Install Rails
RUN \
    apt update && \
    apt install --assume-yes --no-install-recommends \
        sqlite3 && \
    apt clean
USER rails
ENV GEM_HOME=/home/rails/.gems
# So we can create the app using this image - for a prod. app we'd only use Gemfile
RUN gem install rails --version '7.0.4'
# Add app's bin, user installed gem binaries to PATH
ENV PATH="/site/bin:/home/rails/.gems/bin:${PATH}"

# Install app dependencies
COPY blog/Gemfile blog/Gemfile.lock /home/rails/
RUN bundle install --gemfile=/home/rails/Gemfile

# Copy src into image
#COPY --chown=rails:rails ./blog /site

# Start app, using code from /site
WORKDIR /site
# Runtime variables
ENV RAILS_ENV=production
# HTTP server port
EXPOSE 3000

# CMD [\
#     "rails", "server", \
#     "--environment=${RAILS_ENV}", \
#     "--binding=0.0.0.0", \
#     "--port=3000" \
# ]




# Debug additions below (in a real app these will be a seperate "debug" image)


USER root
# Install quality-of-life debug tools
RUN apt install --assume-yes \
        less \
        vim && \
    apt clean
# Install debugger
RUN gem install debug --version '1.6.3'
## To edit Rails encrypted credential file `config/credentials.yml.enc`
ENV EDITOR='/usr/bin/vim'
# Create a mountpoint for source code
RUN mkdir --parents /site && chown -R rails:rails /site
VOLUME "/site"
USER rails



# Debug port
EXPOSE 1234

ENV RAILS_ENV=development

# Start debug server - HTTP:3000, Debug:1234
CMD \
    rm --force /tmp/server.pid && \
    # Startup rails in debug mode, under the "rails" account (same as normal app image)
    exec /home/rails/.gems/bin/rdbg \
        --nonstop \
        --open --host 0.0.0.0 --port 1234 \
        -- \
        /site/bin/rails server \
            --environment=${RAILS_ENV} \
            --pid=/tmp/server.pid \
            --binding=0.0.0.0 --port=3000
