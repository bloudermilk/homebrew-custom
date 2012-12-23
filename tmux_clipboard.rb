require "formula"

class TmuxClipboard < Formula
  homepage "https://gist.github.com/4020666"
  version "1.0"
  url "git://gist.github.com/4020666.git"

  def install
    bin.install("tmux_clipboard")
  end

  def caveats
    <<-CAVEATS
# Start/stop tmux_clipboard

If this is your first install, automatically load on login with:
  mkdir -p ~/Library/LaunchAgents
  cp #{plist_path} ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}

If this is an upgrade and you already have the #{plist_path.basename} loaded:
  launchctl unload -w ~/Library/LaunchAgents/#{plist_path.basename}
  cp #{plist_path} ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}
    CAVEATS
  end

  def plist
    user = `whoami`.chomp

    <<-PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>#{plist_name}</string>
  <key>ProgramArguments</key>
  <array>
    <string>#{bin}/tmux_clipboard</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
  <key>UserName</key>
  <string>#{user}</string>
  <key>WorkingDirectory</key>
  <string>#{HOMEBREW_PREFIX}</string>
  <key>StandardOutPath</key>
  <string>#{var}/log/tmux_clipboard.log</string>
  <key>StandardErrorPath</key>
  <string>#{var}/log/tmux_clipboard.log</string>
</dict>
</plist>
    PLIST
  end
end
