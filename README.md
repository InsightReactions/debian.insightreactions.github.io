# debian.insightreactions.github.io
InsightReactions Official Debian Repository

## Getting Started

```bash
# Install the InsightReactions GPG key
curl -s --compressed "https://debian.insightreactions.com/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/insightreactions.gpg >/dev/null

# Download the InsightReactions apt sources list
sudo curl -s --compressed -o /etc/apt/sources.list.d/insightreactions.list "https://debian.insightreactions.com/insightreactions.list"

# Update apt to make the packages available on your system
sudo apt update
```
