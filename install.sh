#!/bin/bash

# Install dependencies
apt-get update
apt-get install -y jwt-cli

# Create a new `.env` file if it does not exist
if [ ! -f .env ]; then
    cp .env.example .env
fi