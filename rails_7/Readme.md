# PoC Dev container Rails app

Develop and debug Rails app using Docker container.

## How it works

```mermaid
graph LR

  Browser -- http : 3000 --> rails-server

  subgraph VSCode
    debugger
  end

  subgraph "Dev Container"
    direction TB
    rails-server["rails server (Puma)"]
    debugger -- attach : 1234 --> rdbg
    rdbg -- debugs --> rails-server
  end
```

- Rails app and debugger runs inside Docker container
- VSCode debugs into it with remote debugging
- Rails app access via HTTP


## Why?

- Setup development environment quickly and consistently - minimal setup on host
- Ensure dev environment closely match production (same / almost same image)




## Running and debugging with VSCode

1. Install VSCode debug extension

    ```shell
    code --install-extension KoichiSasada.vscode-rdbg
    ```

2. Start-up dev container (may take a while to build on first run)

    ```shell
    ./start-debug-app.sh
    ```

3. Press F5 to attach VSCode debugger to dev container
4. Add a breakpoint (e.g. to [debugtest_controller.rb](src/blog/app/controllers/debugtest_controller.rb) line 5)
5. Debug away 🙂 (e.g. go to http://localhost:3000/debugtest)




## Get shell into container

To get a shell into container (e.g. to run `irb` / `rails console`):

```shell
./bash-shell-rails_7_debug.sh
```

Then run whatever command you want.

Tip: For advanced needs, use `docker exec` - see [bash-shell-rails_7_debug.sh](bash-shell-rails_7_debug.sh) for example.




## Clean-up

To stop and remove container:

```shell
./clean-up-start-debug-app.sh
```




## Optional VSCode setups

To get things like code completion, navigation ("intellisense") for VSCode, install these on host:

```shell
# Install ruby language support
code --install-extension rebornix.Ruby

# Enable code completion, navigation ("intellisense")
sudo gem install solargraph
code --install-extension castwide.solargraph
```


## Bootstrap

```bash
mkdir blog
# Create dummy Gemfile so image builds
touch blog/Gemfile blog/Gemfile.lock
docker-compose build --pull \
  --build-arg "APP_UID=$(id --user)" \
  --build-arg "APP_GID=$(id --group)" \
  rails_7_debug
docker run --volume="$(pwd)/blog:/site" --rm -it klo2k/rails_7:debug \
  rails new blog
```
