# Kong

Spins up and runs a kong/redis/postgres environment with an example

It will setup an example API with API keys and rate limiting


## Prerequisites

0. Install [Docker](https://docs.docker.com/engine/installation/)
1. Install [tfenv](https://github.com/kamatama41/tfenv)


## Setting Up

```
tfenv install `cat .terraform-version`
```

## Running

```
terraform plan
terraform apply -var myip=<IP_ADDRESS_OF_YOUR_LAPTOP>
./setup.sh
```

