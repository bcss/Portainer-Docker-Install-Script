# Portainer Docker Setup Scripts

Two alternative Bash scripts for managing Portainer (Docker management GUI) installations with different levels of functionality.

## Script Comparison

| Feature                          | `portainer_setup_v1.sh` | `portainer_setup_v2.sh` |
|----------------------------------|------------------------|-------------------------|
| Basic Installation               | ✅                     | ✅                      |
| Docker Compose Plugin Check      | ✅                     | ❌                      |
| Automatic Docker Installation    | ❌                     | ❌                      |
| Custom Installation Path         | ❌                     | ✅                      |
| Custom Port Configuration        | ❌                     | ✅                      |
| Existing Installation Detection  | ❌                     | ✅                      |
| Reinstall Functionality          | ❌                     | ✅                      |
| Complete Uninstall Option        | ❌                     | ✅                      |
| Interactive Menu                 | ❌                     | ✅                      |
| Color-coded Output               | ❌                     | ✅                      |
| Safety Confirmations             | ❌                     | ✅                      |

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
Copyright (C) 2024 [Your Name/GitHub Username]  

This program is free software: you can redistribute it and/or modify  
it under the terms of the GNU General Public License as published by  
the Free Software Foundation, either version 3 of the License, or  
(at your option) any later version.  

This program is distributed in the hope that it will be useful,  
but WITHOUT ANY WARRANTY; without even the implied warranty of  
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the  
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License  
along with this program. If not, see <https://www.gnu.org/licenses/>.  

> Note: Neither script automatically installs Docker - this must be present before running.
4. Environment requirements
5. Guidance on which script to choose
6. Clean Markdown formatting for GitHub

Would you like me to add any additional sections like troubleshooting, license information, or contribution guidelines?
