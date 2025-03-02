# SubExtractor

### A Powerful Subdomain Enumeration Tool by k4r7h1kn

## 🚀 About SubExtractor

SubExtractor is an automated subdomain enumeration tool that leverages multiple open-source tools to discover subdomains, check their availability, and filter live hosts. It is designed to streamline reconnaissance for security researchers, penetration testers, and bug hunters.

## 🎯 Features

- Automatically installs missing dependencies.
- Uses multiple sources for subdomain enumeration:
  - subfinder
  - assetfinder
  - findomain
  - crt.sh (Certificate Transparency Logs)
- Removes duplicate subdomains and saves them to `subdomains.txt`.
- Checks for live subdomains using `httpx` and saves them to `alive.txt`.
- Colorful and clean output.

## 📌 Prerequisites

Ensure you have the following dependencies installed before running SubExtractor:

- `subfinder`
- `assetfinder`
- `findomain`
- `httpx`
- `jq`
- `curl`

If any of these are missing, the script will automatically install them.

## 🔧 Installation & Usage

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/yourgithubusername/SubExtractor.git
cd SubExtractor
```

### 2️⃣ Give Execution Permission

```bash
chmod +x SubExtractor.sh
```

### 3️⃣ Run the Tool

```bash
./SubExtractor.sh
```

### 4️⃣ Enter the Target Domain

The tool will prompt you to enter a domain for enumeration:

```bash
[*] Enter the domain: example.com
```

## 📂 Output Files

- `subdomains.txt` → Contains all discovered subdomains.
- `alive.txt` → Contains only live subdomains.

## 🖥 Example Output

```bash
     .-.
    (o.o)
     |=|
    __|__
  //.=|=.\\
 // .=|=. \\
 \\ .=|=. //
  \\(_=_)//
   (:| |:)
    || ||
    () ()
    || ||
    || ||
   ==' '==
   subextractor by k4r7h1kn

[*] Checking dependencies...
[+] subfinder is already installed.
[+] assetfinder is already installed.
[+] findomain is already installed.
[+] httpx is already installed.
[+] jq is already installed.
[+] curl is already installed.

[*] Enter the domain: example.com

[*] Enumerating subdomains for: example.com
[+] Running subfinder...
[+] Running assetfinder...
[+] Running findomain...
[+] Fetching subdomains from crt.sh...
[+] Subdomains from crt.sh saved.
[*] Subdomains saved to subdomains.txt

[+] Checking for live subdomains using httpx...
[*] Live subdomains saved to alive.txt

[✔] Enumeration completed successfully!
```

## 🤝 Contributing

Feel free to submit pull requests or report issues to improve this tool.

## 📬 Contact

For queries or suggestions, reach out to me on:

- GitHub: [k4r7h1kn](https://github.com/k4r7h1kn)
- Twitter: [k4r7h1kn](https://twitter.com/k4r7h1kn)

---

### 🔥 Happy Hacking & Stay Secure! 🔥
