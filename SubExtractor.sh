#!/bin/bash

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Banner
echo -e "${CYAN}"
echo "     .-."
echo "    (o.o)"
echo "     |=|"
echo "    __|__"
echo "  //.=|=.\\\\"
echo " // .=|=. \\\\"
echo " \\\\ .=|=. //"
echo "  \\\\(_=_)//"
echo "   (:| |:)"
echo "    || ||"
echo "    () ()"
echo "    || ||"
echo "    || ||"
echo "   ==' '=="
echo -e "   subextractor by k4r7h1kn\n${RESET}"

# Function to check and install required tools
check_install() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${YELLOW}[-] Installing $1...${RESET}"
        if [[ "$1" == "findomain" ]]; then
            wget -q https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -O findomain
            chmod +x findomain
            sudo mv findomain /usr/local/bin/
        elif [[ "$1" == "jq" ]]; then
            sudo apt install -y jq
        else
            sudo apt install -y "$1" || sudo snap install "$1" || go install github.com/projectdiscovery/"$1"@latest
        fi
    else
        echo -e "${GREEN}[+] $1 is already installed.${RESET}"
    fi
}

# Checking dependencies
echo -e "${CYAN}[*] Checking dependencies...${RESET}"
check_install subfinder
check_install assetfinder
check_install findomain
check_install httpx
check_install jq
check_install curl

# Ask for the domain
read -p $'\e[36m[*] Enter the domain: \e[0m' domain

# Check if domain is empty
if [[ -z "$domain" ]]; then
    echo -e "${RED}[!] Domain cannot be empty! Exiting...${RESET}"
    exit 1
fi

echo -e "${CYAN}[*] Enumerating subdomains for: ${domain}${RESET}"

# Run enumeration tools
echo -e "${GREEN}[+] Running subfinder...${RESET}"
subfinder -d "$domain" | tee subfinder.txt

echo -e "${GREEN}[+] Running assetfinder...${RESET}"
assetfinder --subs-only "$domain" | tee assetfinder.txt

echo -e "${GREEN}[+] Running findomain...${RESET}"
findomain -t "$domain" | tee findomain.txt

# Fetch subdomains from crt.sh with error handling
echo -e "${GREEN}[+] Fetching subdomains from crt.sh...${RESET}"

# Fetch data from crt.sh
crtsh_data=$(curl -s "https://crt.sh/?q=%.$domain&output=json")

# Validate JSON response before processing
if echo "$crtsh_data" | jq empty 2>/dev/null; then
    echo "$crtsh_data" | jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' | sort -u > crtsh.txt
    if [[ -s crtsh.txt ]]; then
        echo -e "${GREEN}[+] Subdomains from crt.sh saved.${RESET}"
    else
        echo -e "${YELLOW}[-] No valid subdomains found from crt.sh.${RESET}"
        rm -f crtsh.txt
    fi
else
    echo -e "${RED}[!] Invalid JSON received from crt.sh. Skipping...${RESET}"
fi

# Combine and sort unique subdomains
cat subfinder.txt assetfinder.txt findomain.txt crtsh.txt 2>/dev/null | sort -u > subdomains.txt
rm -f subfinder.txt assetfinder.txt findomain.txt crtsh.txt  # Cleanup

echo -e "${CYAN}[*] Subdomains saved to subdomains.txt${RESET}"

# Check for live subdomains
echo -e "${GREEN}[+] Checking for live subdomains using httpx...${RESET}"
httpx -l subdomains.txt -o alive.txt -silent

echo -e "${CYAN}[*] Live subdomains saved to alive.txt${RESET}"

echo -e "${GREEN}[✔] Enumeration completed successfully!${RESET}"
