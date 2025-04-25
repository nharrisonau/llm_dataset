# Firmware Component Sample Dataset

This repository builds and collects sample binaries from open-source projects commonly found in firmware images.  
It organizes, builds, and exports both **original** and **stripped** versions of these binaries to support reverse engineering, function tagging, and large-language-model (LLM) research.

---

## 📁 Directory Structure

```
projects/
  ├── encryption/      # e.g., OpenSSL, wolfSSL, mbedTLS
  ├── authentication/  # e.g., Dropbear SSH, OpenSSH
  ├── wireless/         # e.g., hostapd, BlueZ
  ├── networking/       # e.g., lwIP, dnsmasq
  ├── system/           # e.g., Mosquitto

build-scripts/
  └── *.sh              # One script per project to build and export binaries

samples/
  ├── original/         # Unstripped compiled binaries
  └── stripped/         # Same binaries, after `strip --strip-unneeded`
```

---

## 🚀 Usage

### 1. Clone the repository with submodules

```bash
git clone --recurse-submodules <repo-url>
cd <repo-dir>
```

> If you already cloned without `--recurse-submodules`, run:
> ```bash
> git submodule update --init --recursive
> ```

---

### 2. Build all components

```bash
./build_all_projects.sh
```

This will:
- Build each project using its matching script in `build-scripts/`
- Export the key binary artifacts to `samples/original/`
- Strip them and place copies into `samples/stripped/`

---

## ✅ Currently Included Projects

| Category         | Projects                          |
|------------------|-----------------------------------|
| **Encryption**   | OpenSSL, wolfSSL, mbedTLS         |
| **Authentication** | Dropbear, OpenSSH               |
| **Wireless**     | hostapd, BlueZ                    |
| **Networking**   | lwIP, dnsmasq                     |
| **System**       | Mosquitto                         |

> All projects are open-source and selected based on common appearance in embedded firmware.

---

## ⚙️ Requirements

Tested on **Ubuntu 22.04+**. You’ll need:

```bash
sudo apt install build-essential git cmake autoconf automake libtool pkg-config
```

Some projects may require additional packages (e.g., `libnl-3-dev`, `libdbus-1-dev`, etc.), which are checked during build. Errors will indicate missing dependencies with guidance.

---

## 🔧 Quickstart

```bash
git clone --recurse-submodules <repo-url>
cd <repo-dir>
chmod +x build_all_projects.sh build-scripts/*.sh
./build-scripts/build_all_projects.sh

ls samples/original/   # See compiled binaries
ls samples/stripped/   # See stripped binaries
```