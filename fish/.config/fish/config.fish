function ensure_fisher_installed
    if not functions -q fisher
        echo "Fisher not found, installing..."
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    end
end

function set_proxy
    set -x http_proxy http://127.0.0.1:7897
    set -x https_proxy http://127.0.0.1:7897
end

# 获取当前用户名并存入变量
set -l USERNAME (whoami)

if status is-interactive
    # 检查并安装fisher
    ensure_fisher_installed

    # Interactive greeting
    set -U fish_greeting "Hello $USERNAME!
    (=^･ω･^=)"

    set_proxy

    set -gx PATH /opt/homebrew/bin $PATH
    set -gx PATH /home/$USERNAME/.cargo/bin $PATH

    alias gcl="git clone"
    alias gpl="git pull --rebase"
    alias gp="git push"
    alias gcm="git commit -m"
    alias gc="git commit"
    alias gco="git checkout"
    alias gbr="git branch"
    alias gm="git merge --rebase"
    alias gcp="git cherry-pick"
    alias gst="git status"
    alias gds="git diff --staged"
    alias gdc="git diff"

    zoxide init fish | source
end

# pnpm
set -gx PNPM_HOME "/Users/$USERNAME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
