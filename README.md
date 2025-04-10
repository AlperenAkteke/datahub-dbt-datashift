# Demo-dbt-Datashift

# Datahub dbt Postgres Tutorial with Poetry

This tutorial helps you install and run the DataHub CLI using [Poetry](https://python-poetry.org/).

## Prerequisites

- Python 3.10 or later
- Git
- Bash shell (Linux/macOS or WSL on Windows)
- Docker

## Setup

1. **Clone this repository**

```bash
git clone git@github.com:AlperenAkteke/datahub-dbt-datashift.git
or
git clone https://github.com/AlperenAkteke/datahub-dbt-datashift.git
```

2. **Run the setup script**

```bash
chmod +x ./datahub-tutorial/setup_datahub.sh
./datahub-tutorial/setup_datahub.sh
```
3. **Verify the installation**

You should see the version of the DataHub CLI printed:

```bash
DataHub CLI version x.y.z
```

You should see the version of dbt printed:

```bash
dbt-postgres version: 
Core:
  - installed: 1.9.3
  - latest:    1.9.3 - Up to date!

Plugins:
  - postgres: 1.9.0 - Up to date!
```

4. **Start DataHub**

```bash
datahub docker quickstart
```


If things go well, you should see messages like the ones below:

```bash

Fetching docker-compose file https://raw.githubusercontent.com/datahub-project/datahub/master/docker/quickstart/docker-compose-without-neo4j-m1.quickstart.yml from GitHub
Pulling docker images...
Finished pulling docker images!

[+] Running 11/11
⠿ Container zookeeper                  Running                                                                                                                                                         0.0s
⠿ Container elasticsearch              Running                                                                                                                                                         0.0s
⠿ Container broker                     Running                                                                                                                                                         0.0s
⠿ Container schema-registry            Running                                                                                                                                                         0.0s
⠿ Container elasticsearch-setup        Started                                                                                                                                                         0.7s
⠿ Container kafka-setup                Started                                                                                                                                                         0.7s
⠿ Container mysql                      Running                                                                                                                                                         0.0s
⠿ Container datahub-gms                Running                                                                                                                                                         0.0s
⠿ Container mysql-setup                Started                                                                                                                                                         0.7s
⠿ Container datahub-datahub-actions-1  Running                                                                                                                                                         0.0s
⠿ Container datahub-frontend-react     Running                                                                                                                                                         0.0s
.......
✔ DataHub is now running
Ingest some demo data using `datahub docker ingest-sample-data`,
or head to http://localhost:9002 (username: datahub, password: datahub) to play around with the frontend.
Need support? Get in touch on Slack: https://slack.datahubproject.io/
```

5. **Initialize your dbt project**

```bash
export DBT_PROFILES_DIR=$(pwd)/profiles
mkdir -p "$DBT_PROFILES_DIR"

dbt init demo_dbt_datashift
```

```bash
Used parameters:
Database=postgres(enter the corresponding number)
host=postgres
port=5432
user=username
pass=password
dbname=logistics_db
schema=public
```

6. **Start Docker services**

```bash
docker-compose up -d
```
7. **Test the dbt Container Setup**

Access the dbt container:

```bash
docker exec -it dbt bash
```
Inside the container, run:

```bash
dbt debug
```

If everything is configured properly, all checks should pass.
To exit the container, press Ctrl + D.

Use the commands above to enter and exit the container.

8. **Load Seed Data into the Database**

Copy or Move Delivery_Data.csv to demo_dbt_datashift/seeds

Then, inside the dbt container, run:

```bash
dbt seed
```
The dbt seed command is used to load CSV files into your data warehouse as database tables

9. **Run Models & Tests**

In demo_dbt_datashift/models we can create or own models(feel free to remove the examples, when doing the setup yourself).

In our case, we have two models with a not_null test as you can see in the schema file.

```bash
dbt run
```

```bash
dbt test
```
These command should give a succesfull output.


10. **Generate docs**

In our example we changed the last part in dbt_project.yml to

```bash
models:
      +materialized: view
```
to generate docs
```bash
dbt docs generate
```
```bash
dbt docs serve
``` 
to check docs, in our case it will be 8090 instead of 8080, since that port is already used by Datahub.

11. **Ingest Metadata into in Datahub**

Create your dbt_recipe.yaml file with the appropriate paths:

```bash
datahub ingest -c dbt_recipe.yaml
```
Now you can explore your dbt metadata in DataHub at:

http://localhost:9002
(Default credentials: datahub / datahub)




📚 Additional Resources
🔎 DataHub Documentation
Getting Started:
https://datahubproject.io/docs/quickstart/

dbt Ingestion Guide for DataHub:
https://docs.datahubproject.io/docs/generated/ingestion/sources/dbt/

DataHub Slack Community (for help & discussion):
https://slack.datahubproject.io/


📘 dbt Documentation
dbt Core Docs:
https://docs.getdbt.com/docs/introduction

dbt seed command:
https://docs.getdbt.com/reference/commands/seed

dbt docs command:
https://docs.getdbt.com/docs/building-a-dbt-project/documentation

dbt Profiles Configuration:
https://docs.getdbt.com/docs/core/connect-data-platform/profiles.yml
