# URL Opener Script

> **Note:** This script (fully) and README (mostly) are AI-generated. Although *I* have tested this for my own use cases, please understand that *you* will be using this at *your own* risk.

A bash script that opens URLs from a text file sequentially with optional URL updating functionality.

## Features

- Opens URLs from `Links.txt` one by one in the user's default browser
- Shows a popup dialog between each URL for optional URL updates
- Updates URLs in Links.txt if user provides updated ones
- Silent operation with no terminal output

## Requirements

- Linux system with X11
- `yad` (Yet Another Dialog) - for popup dialogs
- `xdg-open` - for opening URLs in default browser

### Install Dependencies

**Ubuntu/Debian:**
```bash
sudo apt install yad
```

**Fedora/RHEL:**
```bash
sudo dnf install yad
```

## Setup

1. Create a `Links.txt` file in the same directory as the script
2. Add one URL per line in `Links.txt`
3. Make the script executable:
   ```bash
   chmod +x url_opener.sh
   ```

## Usage

```bash
./url_opener.sh
```

The script will:
1. Open the first URL in your default browser
2. Show a popup with "Next" button and optional URL update field
3. Continue to the next URL when you click "Next"
4. Show "Finish" button for the last URL
5. Update `Links.txt` if you enter new URLs in the popup

## Use Cases

- **Forum tracking**: Keep up with multiple web forums and update URLs to the last page you read, so you can pick up where you left off next time
- **Social media rounds**: Browse through your regular social platforms and bookmark specific posts or threads for later reference
- **News aggregation**: Go through various news sites and update URLs to specific articles or sections you want to revisit
- **Project monitoring**: Check multiple project dashboards, issue trackers, or repositories and bookmark specific pages or commits
- **Content curation**: Browse through blogs, articles, or resources and update URLs to specific posts or sections for future reference

## File Structure

Links.txt must be in the same directory as the script itself. (You can always modify this, but like... why?)

```
Parent Directory/
├── url_opener.sh       # Main script
└── Links.txt           # URL list (one per line)
```

## Example Links.txt

```
https://github.com
https://stackoverflow.com
https://google.com
```

## Notes

- Popup appears at fixed position (top-right corner)
- Leaving the URL field empty in the popup will do nothing to Links.txt
- Script exits if popup is closed
- All terminal output is suppressed for clean operation

## Support

To anyone unlucky enough to find this, if this is giving you trouble, create an issue and I *might* be able to fix it. I don't have the most experience with bash scripts, only what I've learned while being on a Linux system for a few years.

---

*This project was generated using AI assistance.*
