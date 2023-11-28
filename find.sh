#!/bin/bash

# Function to clear the terminal
clear_terminal() {
  clear
}

# Welcome message
echo "----------------------------------------"
echo "      UniqueSubdomainFinder    "
echo "      Created by frozzipies               "
echo "----------------------------------------"

# Prompt the user to enter a domain
read -p "Enter the domain you want to check: " domain

# Save the domain as a variable
domain_to_check="$domain"

# Display the domain to verify it was saved correctly
echo "You entered the domain: $domain_to_check"

# Run subfinder with the domain variable and save the results to subdomains.txt
subfinder -d "$domain_to_check" -o subdomains.txt

# Run httpx with the subdomains.txt file and save the results to httpx.txt
httpx -l subdomains.txt -sc -title -cl -wc -td | tee httpx.txt

# Add a separation line
echo "---------------------------------------------------------------------------------"
echo "Results :"

# Use cat to read the httpx.txt file and awk to filter and remove duplicate lines
cat httpx.txt | awk -F"[" '!seen[$2, $3, $4, $5]++'
