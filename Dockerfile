#===========
#Build Stage
#===========
FROM bitwalker/alpine-elixir:1.5 as build

# Copy the source folder into the Docker image
COPY . .

# Install dependencies, digest, and build Release
ENV MIX_ENV=prod

RUN rm -Rf _build && \
    mix do deps.get, deps.compile, phx.digest

RUN mix release

# Extract Release archive to /rel for copying in next stage
RUN APP_NAME="refuel" && \
    RELEASE_DIR=`ls -d _build/prod/rel/$APP_NAME/releases/*/` && \
    mkdir /export && \
    tar -xf "$RELEASE_DIR/$APP_NAME.tar.gz" -C /export

#================
# Deployment Stage
#================
FROM pentacent/alpine-erlang-base:latest

# Set environment variables and expose port
EXPOSE 4000
ENV REPLACE_OS_VARS=true \
    PORT=4000

# Copy and extract .tar.gz Release file from the previous stage
COPY --from=build /export/ .

# Change user
USER default

# Set default entrypoint and command
ENTRYPOINT ["/opt/app/bin/refuel"]
CMD ["foreground"]
