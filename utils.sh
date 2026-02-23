#!/bin/bash

# Function to handle registration
handle_register() {
    # Read the request body
    read -r body

    # Parse the request body
    username=$(echo "$body" | cut -d '&' -f 1 | cut -d '=' -f 2)
    password=$(echo "$body" | cut -d '&' -f 2 | cut -d '=' -f 2)

    # Check if the username and password are valid
    if [ -n "$username" ] && [ -n "$password" ]; then
        # Generate a JWT token
        token=$(jwt_encode "$username" "$password")

        # Return a success message with the JWT token
        echo "HTTP/1.1 200 OK"
        echo ""
        echo "token=$token"
    else
        # Return a 400 error
        echo "HTTP/1.1 400 Bad Request"
        echo ""
    fi
}

# Function to handle login
handle_login() {
    # Read the request body
    read -r body

    # Parse the request body
    username=$(echo "$body" | cut -d '&' -f 1 | cut -d '=' -f 2)
    password=$(echo "$body" | cut -d '&' -f 2 | cut -d '=' -f 2)

    # Check if the username and password are valid
    if [ -n "$username" ] && [ -n "$password" ]; then
        # Generate a JWT token
        token=$(jwt_encode "$username" "$password")

        # Return a success message with the JWT token
        echo "HTTP/1.1 200 OK"
        echo ""
        echo "token=$token"
    else
        # Return a 400 error
        echo "HTTP/1.1 400 Bad Request"
        echo ""
    fi
}

# Function to check if a JWT token is valid
check_token() {
    # Read the request headers
    read -r headers

    # Parse the request headers
    token=$(echo "$headers" | grep -oP '(?<=Authorization: Bearer )\S+')

    # Check if the JWT token is valid
    if [ -n "$token" ] && jwt_decode "$token"; then
        return 0
    else
        return 1
    fi
}

# Function to encode a JWT token
jwt_encode() {
    # Use a tool like `jwt-cli` to encode the JWT token
    token=$(jwt-cli --secret "$SECRET_KEY" --alg HS256 --exp 3600 encode username=$1 password=$2)
    echo "$token"
}

# Function to decode a JWT token
jwt_decode() {
    # Use a tool like `jwt-cli` to decode the JWT token
    decoded=$(jwt-cli --secret "$SECRET_KEY" --alg HS256 decode $1)
    if [ -n "$decoded" ]; then
        return 0
    else
        return 1
    fi
}