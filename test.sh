#!/bin/bash

# Test the registration endpoint
echo "Testing registration endpoint..."
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=user&password=pass" http://localhost:$PORT/register
echo ""

# Test the login endpoint
echo "Testing login endpoint..."
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=user&password=pass" http://localhost:$PORT/login
echo ""

# Test the protected endpoint with a valid JWT token
echo "Testing protected endpoint with valid JWT token..."
token=$(curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "username=user&password=pass" http://localhost:$PORT/login | grep -oP '(?<=token=)\S+')
curl -X GET -H "Authorization: Bearer $token" http://localhost:$PORT/protected
echo ""

# Test the protected endpoint with an invalid JWT token
echo "Testing protected endpoint with invalid JWT token..."
curl -X GET -H "Authorization: Bearer invalid_token" http://localhost:$PORT/protected
echo ""