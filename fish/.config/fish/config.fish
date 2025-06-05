function set_proxy
    set -x http_proxy http://127.0.0.1:7897
    set -x https_proxy http://127.0.0.1:7897
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting "Hello Tunglies!
    (=^･ω･^=)"

    set_proxy
    
    set -gx PATH /opt/homebrew/bin $PATH
    set -gx PATH ~/.cargo/bin $PATH

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
set -gx PNPM_HOME "/Users/tunglies/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
