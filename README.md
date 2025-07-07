# 🛠️ Scan & Repair Windows Image

![sample](https://github.com/abdullah-erturk/scan_repair_windows/blob/main/scan-repair.jpg)

Windows 10 ve 11 sistemlerinde DISM ve SFC komutlarıyla sistem bütünlüğünü tarayan, otomatik olarak onaran ve kullanıcıyı çok dilli (TR/EN) renkli mesajlarla bilgilendiren gelişmiş bir `batch` betiği. 


An advanced batch script that scans system integrity with DISM and SFC commands on Windows 10 and 11 systems, automatically repairs them, and informs the user with multilingual (TR/EN) colored messages.

---

<details>
<summary>Tanıtım (Türkçe)</summary>

### 🧩 Özellikler
- Yönetici izni kontrolü ve **otomatik yükseltme**
- DISM `CheckHealth`, `ScanHealth`, `RestoreHealth` desteği  
- `sfc /scannow` entegrasyonu  
- Türkçe ve İngilizce **otomatik dil algılama**
- Duruma göre **renkli bilgilendirme mesajları**
- Geçici log dosyalarının otomatik temizliği

### 🖥️ Desteklenen Sistemler
- Windows 10 (1809 ve sonrası)
- Windows 11 (tüm sürümler)

### 🚀 Kullanım
Script çalıştırıldığında sistemin sağlık durumu kontrol edilir. Onarılabilir bir sorun varsa otomatik olarak DISM ve SFC devreye girer. Kullanıcının hiçbir müdahalede bulunmasına gerek yoktur.

### 💬 Geri Bildirim
Her türlü öneri ve geri bildirim için lütfen GitHub üzerinden katkıda bulunun.

### ⚠️ Uyarı
Bu betik sistem dosyalarında değişiklik yapar. Kullanım tamamen sizin sorumluluğunuzdadır. Kritik verilerinizi yedeklemeniz önerilir.

</details>

---

<details>
<summary>Introduction (English)</summary>

### 🧩 Features
- Admin rights check and **auto elevation**
- Supports DISM `CheckHealth`, `ScanHealth`, and `RestoreHealth`
- Includes `sfc /scannow`
- **Auto language detection** (Turkish / English)
- Color-coded status messages
- Cleans up temporary log files after execution

### 🖥️ Supported Systems
- Windows 10 (1809 or later)
- Windows 11 (all versions)

### 🚀 Usage
Just run the script. It will check the health status of your system. If a repairable issue is found, it will automatically trigger DISM and SFC. No user interaction is required.

### 💬 Feedback
Please contribute via GitHub for any suggestions or feedback.

### ⚠️ Disclaimer
This script makes changes to your system files. Use at your own risk. It is highly recommended to back up your important data before use.

</details>
