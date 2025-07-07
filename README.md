# 🔎 recon-automator

A modular, extensible, and efficient **Offensive Recon Automation Toolkit** written in Bash for Kali Linux. Perfect for penetration testers, red teamers, and bug bounty hunters looking to automate and customize their recon workflow.

---

## 🛠 Features

- ⚡ Quick, Full TCP, and UDP scans using `nmap`
- 🧬 Vulnerability scanning with `nmap` scripts
- 🌐 Subdomain & service probing using `httpx`
- 🚪 Directory fuzzing with `gobuster` (custom wordlist support)
- 🧱 Template-based scanning using `nuclei`
- 🗂 Output saved in structured folders: `output/<target>/`
- 🧩 Modular design – run all or specific tools via flags
- 📄 Logging and graceful error handling for every module

---

## 📦 Requirements

Ensure the following tools are installed (automatically checked/installed via `setup.sh`):

- `nmap`
- `nuclei`
- `httpx`
- `gobuster`
- `whatweb`

---

## 🚀 Usage

### 🔧 Initial Setup

```bash
chmod +x setup.sh main.sh
./setup.sh
