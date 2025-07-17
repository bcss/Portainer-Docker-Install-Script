# 🚀 Portainer Docker Setup Scripts

Three Bash scripts to install and manage [Portainer](https://www.portainer.io/) — a lightweight management UI for Docker.  
Each script offers different levels of flexibility, automation, and safety.

---

## 📊 Script Comparison

| Feature | `v1` Basic Installer | `v2` Interactive Manager | `v3` Auto+Enhanced |
| --- | --- | --- | --- |
| Simple One-Time Installation | ✅   | ✅   | ✅   |
| Docker Compose Plugin Check | ✅   | ❌   | ✅   |
| Automatic Docker Installation | ❌   | ❌   | ✅   |
| Custom Installation Path | ❌   | ✅   | ✅   |
| Custom Port Configuration | ❌   | ✅   | ✅   |
| Existing Installation Detection | ❌   | ✅   | ✅   |
| Reinstall Functionality | ❌   | ✅   | ✅   |
| Complete Uninstall Option | ❌   | ✅   | ✅   |
| Interactive Menu | ❌   | ✅   | ✅   |
| Color-coded Output | ❌   | ✅   | ✅   |
| Safety Confirmations | ❌   | ✅   | ✅   |
| Graceful Interrupt Handling (`Ctrl+C`) | ❌   | ❌   | ✅   |
| OS Detection (Ubuntu 22.04 only supported) | ❌   | ❌   | ✅   |

---

## 🔹 `portainer_setup_v1.sh` – Basic Installer

**Features**:

- Simple one-time installation
- Verifies Docker and Compose plugin
- Fixed path `/opt/portainer` and port `9000`

**Usage**:

```bash
chmod +x portainer_setup_v1.sh
sudo ./portainer_setup_v1.sh
```

**Best for**: Quick, non-customized deployments or throwaway containers.

---

## 🔸 `portainer_setup_v2.sh` – Advanced Manager

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

**Best for**: Production environments with manual Docker installations.

---

## 🟢 `portainer_setup_v3_final.sh` – Full Auto + Enhanced (Ubuntu 22.04+)

**Features**:
✔ Everything from `v2`, plus:  
✔ Automatic Docker + Compose plugin installation  
✔ Strict check for Ubuntu 22.04 only  
✔ Graceful `Ctrl+C` interruption handling  
✔ Cleaner validation of input (port/path)

**Usage**:

```bash
chmod +x portainer_setup_v3_final.sh
sudo ./portainer_setup_v3_final.sh
```

**Best for**: Fresh VMs, VPS, or server automation setups where Portainer isn’t yet installed.

---

## 🧱 Requirements

| Component | Required? | Notes |
| --- | --- | --- |
| OS  | Ubuntu 22.04 only | v3 requires this |
| Docker | Installed+Running | v1/v2 require pre-installation |
| Compose Plugin | ✅ Required | v3 installs if missing |
| Root Privileges | ✅ Required | `sudo` is mandatory |

---

## 💡 Recommended Use

| Purpose | Script to Use |
| --- | --- |
| Quick one-off installs | `portainer_setup_v1.sh` |
| Semi-custom setups | `portainer_setup_v2.sh` |
| Automated/managed VM | `portainer_setup_v3_final.sh` ✅ |

---

## 🛠️ Troubleshooting

| Problem | Solution |
| --- | --- |
| Docker not installed | Use `v3` or install it manually |
| Permission denied on script | Run `chmod +x script.sh` and use `sudo` |
| Portainer not loading on browser | Check if chosen port is open |
| Running wrong OS | v3 supports only Ubuntu 22.04 |

---

## 📂 Files

| File Name | Description |
| --- | --- |
| `portainer_setup_v1.sh` | Simple legacy installer |
| `portainer_setup_v2.sh` | Interactive setup manager |
| `portainer_setup_v3_final.sh` | Full automated installer (Ubuntu 22.04 only) |

---

## 📜 License

This project is licensed under the [GNU GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.en.html).
---

Happy containerizing! 🐳
