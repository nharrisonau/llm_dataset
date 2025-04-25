# Firmware Component Sample Dataset

This repository builds and collects sample binaries from open-source projects commonly found in firmware images.  
It organizes, builds, and exports both **original** and **stripped** versions of these binaries to support reverse engineering, function tagging, and large-language-model (LLM) research.

---

## Structure

```
projects/
  ├── encryption/      # e.g., OpenSSL, wolfSSL, mbedTLS
  ├── authentication/  # e.g., Dropbear SSH, OpenSSH
  ├── wireless/         # e.g., hostapd, BlueZ
  ├── networking/       # e.g., lwIP, dnsmasq
  ├── system/           # e.g., BusyBox, Samba
  ├── vpn/              # e.g., OpenVPN, strongSwan

build-scripts/
  └── *.sh              # One script per project to build and export binaries

samples/
  ├── original/         # Unstripped compiled binaries
  └── stripped/         # Same binaries, after `strip --strip-unneeded`
```

---

## Usage

### 1. Clone the repository **with submodules**

```bash
git clone --recurse-submodules <repo-url>
cd <repo-dir>
```

> If you already cloned, initialize submodules manually:
> ```bash
> git submodule update --init --recursive
> ```

---

### 2. Build all components

```bash
./build_all_projects.sh
```

This script will:
- Build each project using its corresponding script under `build-scripts/`
- Collect important binaries into `samples/original/`
- Create a `samples/stripped/` copy where all binaries are stripped

---

## List of Components

| Category         | Project        |
|------------------|----------------|
| Encryption       | OpenSSL, wolfSSL, mbedTLS, GnuTLS |
| Authentication   | Dropbear SSH, OpenSSH |
| Wireless         | hostapd, BlueZ |
| Networking       | lwIP, dnsmasq, pppd |
| System           | BusyBox, Samba, Mosquitto |
| VPN              | OpenVPN, strongSwan |

> Only open-source projects are included. Firmware-agnostic.

---

## Purpose

This dataset supports:
- **Reverse engineering** workflows
- **Function tagging** and **component labeling** experiments
- **Foreign material exploitation (FME)** automation research
- **LLM training** on real-world embedded software artifacts

---

## Notes

- Some components (e.g., FreeRTOS, Zephyr, OpenThread) were excluded for now due to requiring external SDKs or complex environment setups.
- Stripping failures (e.g., on non-ELF binaries) are non-fatal and logged.

---

## Requirements

- Linux environment (tested on Ubuntu 22.04+)
- Basic build tools:
  ```bash
  sudo apt install build-essential git cmake autoconf automake libtool pkg-config
  ```
- `strip` from GNU binutils for binary size reduction

---

## Future Extensions

- Add missing embedded targets with special toolchains
- Generate full `manifest.json` of all samples with metadata (original size, stripped size, source project, etc.)
- Optional static analysis integration (symbol counts, instruction mix, etc.)

---

# Quickstart

```bash
git clone --recurse-submodules <repo-url>
cd <repo-dir>
chmod +x build_all_projects.sh build-scripts/*.sh
./build_all_projects.sh
ls samples/original/  # See compiled binaries
ls samples/stripped/  # See stripped binaries
```