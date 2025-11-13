# Downloadmanager 

A Windows batch-based launcher that allows you to install and uninstall applications via winget from a categorized menu. The script is designed to be simple to distribute: just double-click the .bat file, and it handles the rest.

This type of tool can be crucial during deployments to streamline and optimize software installations across multiple systems.
---

## ✨ Features

* 📂 **Categorized apps menu** (Browsers, Games, Tools, Media, Development, etc.).
* 🔢 **Automatic numbering** of applications — no manual tracking required.
* ✅ **Selectable install/uninstall** options directly from the console.
* 🎨 **Clear and colored menu layout** for better readability.
* 🔄 **Self-updating mechanism** at launch:

  * Checks if a new version of the script is available on GitHub.
  * Compares the **local version** with the **remote version** defined inside the script.
  * If different → automatically updates the script and relaunches it.
  * If identical → continues directly to the apps menu.

---

## ⚙️ How It Works

1. **Startup & Update Check**

   * The script defines its version at the top:

     ```bat
     set "localversion=25.10.0"
     ```
   * On launch, it downloads the latest version of itself and "Version.txt" from GitHub to a temporary file.
   * It extracts the `remoteVersion` variable from the downloaded file.
   * If `remoteVersion` ≠ `localVersion`, the script updates itself and restarts.

2. **App Menu**

   * Applications are grouped into categories (e.g., *Browsers*, *Games*, *Media*).
   * Each app has:

     * A **name** (for display).
     * An **ID** (used by `winget`).
     * A **category**.
     * An **IDWeb** (used to get package via url)
   * Example entry:

     ```bat
     set /a total+=1 & set "app[%total%]=[ ] Chrome" & set "id[%total%]=Google.Chrome" & set "cat[%total%]=Browser"
     set /a total+=1 & set "app[%total%]=[ ] Zywall SecuExtender" & set "idweb[%total%]=powershell -Command "Invoke-WebRequest -Uri 'https://www.zyxel.com/SecuExtender_Windows.zip' -OutFile $env:USERPROFILE\Desktop\SecuExtender.zip"" & set "cat[%total%]=Admin & Dev"
     ```

3. **Interaction**

   * Type the number of an app to **select/deselect** it.
   * Use:

     * `I` → install selected apps.
     * `U` → uninstall selected apps.
     * `Q` → quit the launcher.
     * `C` → Check Script Update.

---

## 🚀 Usage

1. Download the latest `Downloadmanager.bat` from the repository.
2. Double-click the batch file.
3. On startup:

   * If a new version exists, the script ask you to update it. If your answer is "Y" the script launch update and restarts.
   * If not, the app menu is displayed directly.
4. Select apps and choose whether to install or uninstall them.

---

## 🔄 Updating

* The update process is **automatic** — no manual action is required.
* The script uses its internal version variable for comparison.
* Updates are pulled directly from the **GitHub raw file**:

  ```
  **https://raw.githubusercontent.com/<username>/<repo>/main/Downloadmanager.bat**
  ```

---

## 🛠️ Requirements

* Windows 10 or 11.
* `winget` package manager installed and available in PATH.
* Internet connection (for both updates and app installation).

---

## ⚠️ Notes

* The script requests **administrator rights** when necessary for installing/uninstalling apps.
* Apps from the **Microsoft Store** can also be managed through `winget` using their Store IDs.
* If the update check fails (e.g., no internet), the script will continue with the local version.

---

## 📌 Example Workflow

1. User runs `Downloadmanager.bat`.
2. Script checks GitHub for updates:

   * If found → Updates → relaunches.
   * If not → continues.
3. Menu appears:

   ```
   --- Browsers ---
   [ ] 1. Chrome
   [ ] 2. Firefox
   ...
   ```
4. User selects apps with associate numbers → presses `I`.
5. `winget` installs the chosen apps automatically.
6. Confirmation message is shown after completion.

---

## 📄 License

This project is free to use and modify for personal purposes.
Contributions and improvements are welcome.

---

## 👨‍💻 Developer Notes

To add new apps to the menu:

. Add the app line with name, winget ID, and category:

   ```bat
   set /a total+=1 & set "app[%total%]=[ ] AppName" & set "id[%total%]=Publisher.AppID" & set "cat[%total%]=Category"
   ```
3. The menu numbering and categories update automatically.

This ensures the launcher menu always reflects the latest app list without manual renumbering.
