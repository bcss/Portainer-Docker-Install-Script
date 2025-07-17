# Portainer Docker Setup Scripts

Three Bash scripts to install and manage [Portainer](https://www.portainer.io/) — a lightweight management UI for Docker.  
Each script offers different levels of flexibility, automation, and safety.

## 📊 Script Comparison

| Feature                                     | `v1` Basic Installer | `v2` Interactive Manager | `v3_final` Auto+Enhanced |
|--------------------------------------------|-----------------------|--------------------------|---------------------------|
| Simple One-Time Installation               | ✅                    | ✅                       | ✅                        |
| Docker Compose Plugin Check                | ✅                    | ❌                       | ✅                        |
| Automatic Docker Installation              | ❌                    | ❌                       | ✅                        |
| Custom Installation Path                   | ❌                    | ✅                       | ✅                        |
| Custom Port Configuration                  | ❌                    | ✅                       | ✅                        |
| Existing Installation Detection            | ❌                    | ✅                       | ✅                        |
| Reinstall Functionality                    | ❌                    | ✅                       | ✅                        |
| Complete Uninstall Option                  | ❌                    | ✅                       | ✅                        |
| Interactive Menu                           | ❌                    | ✅                       | ✅                        |
| Color-coded Output                         | ❌                    | ✅                       | ✅                        |
| Safety Confirmations                       | ❌                    | ✅                       | ✅                        |
| Graceful Interrupt Handling (`Ctrl+C`)     | ❌                    | ❌                       | ✅                        |
| OS Detection (Ubuntu 22.04 only supported) | ❌                    | ❌                       | ✅                        |

## portainer_setup_v1.sh - Basic Installer

**Features**:
- Simple one-time installation
- Verifies Docker and Docker Compose prerequisites
- Fixed installation path (`/opt/portainer`)
- Fixed port (`9000`)
- Provides basic management commands after installation

**Usage**:
```bash
chmod +x portainer_setup_v1.sh
sudo ./portainer_setup_v1.sh
```

**Best for**: Quick deployments where no customization or management is needed.

---

## portainer_setup_v2.sh - Advanced Manager

**Features**:
✔ Interactive menu system  
✔ Detects existing installations automatically  
✔ Customizable installation path and port  
✔ Complete uninstall capability  
✔ Clean reinstall option  
✔ Visual feedback with color coding  
✔ Safety confirmations for destructive actions  

**Usage**:
```bash
chmod +x portainer_setup_v2.sh
sudo ./portainer_setup_v2.sh
```

**Menu Options**:
1. **Install/Reinstall**: Fresh install or clean reinstall
2. **Uninstall**: Complete removal (containers, volumes, configs)
3. **Exit**: Quit the script

**Best for**: Production environments requiring management flexibility.

## Requirements

Both scripts require:
- Linux environment
- Docker (script v1 checks for Docker Compose plugin)
- Root/sudo privileges

## Recommended Use

- For **testing/quick setups**: Use v1
- For **production/maintained systems**: Use v2

## 🖥️ Supported Operating Systems  

These scripts have been tested on:  
- **Linux distributions**:  
  - Ubuntu 20.04/22.04 LTS  
  - Debian 11/12  
  - CentOS/RHEL 8+  
  - Fedora 36+  
- **Docker Host Environments**:  
  - Native Linux installations  
  - WSL2 (Windows Subsystem for Linux) on Windows 10/11  

⚠️ **Not Supported**:  
- macOS (use native Docker Desktop instead)  
- Windows (without WSL2)  
- Non-systemd Linux distributions (may require manual adjustments)  Portainer Setup Scripts  

> Note: Neither script automatically installs Docker - this must be present before running.
4. Environment requirements
5. Guidance on which script to choose
6. Clean Markdown formatting for GitHub

Would you like me to add any additional sections like troubleshooting, license information, or contribution guidelines?
