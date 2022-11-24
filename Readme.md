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
    rails-debugger["rails debugger"]
    debugger -- attach : 1234 --> rails-debugger
    rails-debugger -- debugs --> rails-server
  end
```

- Rails app and debugger runs inside Docker container
- VSCode debugs into it with remote debugging
- Rails app access via HTTP

## Why?

- Setup development environment quickly and consistently - minimal setup on host
- Ensure dev environment closely match production (same / almost same image)

## Rails Versions in Demo

Each version of rails has its own way of doing this.

Please see individual READMEs to get going:

- [Rails 6](rails_6/Readme.md)
- [Rails 7](rails_6/Readme.md)
