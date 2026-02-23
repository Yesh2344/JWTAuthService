#!/bin/bash

# Load configuration
source config.sh

# Start the service
echo "Starting JWT authentication service..."
echo "Listening on port $PORT"

# Handle requests
while true
do
    # Read the request
    read -r request

    # Parse the request
    method=$(echo "$request" | cut -d ' ' -f 1)
    path=$(echo "$request" | cut -d ' ' -f 2)

    # Handle the request
    case $method in
        POST)
            case $path in
                /register)
                    # Register a new user
                    handle_register
                    ;;
                /login)
                    # Login an existing user
                    handle_login
                    ;;
                *)
                    # Return a 404 error
                    echo "HTTP/1.1 404 Not Found"
                    echo ""
                    ;;
            esac
            ;;
        GET)
            case $path in
                /protected)
                    # Check if the request has a valid JWT token
                    if check_token; then
                        # Return a success message
                        echo "HTTP/1.1 200 OK"
                        echo ""
                        echo "Hello, authenticated user!"
                    else
                        # Return a 401 error
                        echo "HTTP/1.1 401 Unauthorized"
                        echo ""
                    fi
                    ;;
                *)
                    # Return a 404 error
                    echo "HTTP/1.1 404 Not Found"
                    echo ""
                    ;;
            esac
            ;;
        *)
            # Return a 405 error
            echo "HTTP/1.1 405 Method Not Allowed"
            echo ""
            ;;
    esac
done