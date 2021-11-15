# PoC Dev container Rails app

Develop and debug using Docker containers.

## Aim
- No / minimal setup in local dev environment
- Same versions and environment as production, without hacks

## MVP
- Run app insider dev container
- Debug app inside dev container (connect debugger into)




# To run
```
./debug-app.sh
```

App is at http://localhost:3000/




# Debug with VSCode
1. Start-up development container
```
./debug-app.sh
```
2. Press F5 to attach VSCode debugger to dev container
3. Debug away 🙂




# Get shell into container
```
./bash-shell-rails_debug.sh
```




# Clean-up
```
./clean-up-debug-rails.sh
```




# Optional VSCode setups
To get the most out of VSCode, install these on host:
```
# Install ruby language support
vscode --install-extension rebornix.Ruby

# Enable code completion, navigation ("intellisense")
sudo gem install solargraph
vscode --install-extension castwide.solargraph
```
