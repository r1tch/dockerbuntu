# Dockerbuntu - Ubuntu in A Docker Container

An isolated, but still very much usable Ubuntu Linux environment for your daily Linux needs (automated backups, etc).

All files should be self-explanatory. :)

## Setup

- ensure to have a volume defined for your home directory (`/home/your_username` in the container)
- define username and its password via `USERNAME` and `PASSWORD` environment variables

See `testrun.sh` for an example run.

## Custom System Configuration

If `.dockerbuntu_startup` exists in your home directory, it will be sourced at
container startup. This is a good place to install custom packages, etc.
