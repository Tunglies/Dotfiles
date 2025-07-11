# 引入 cpv 和 rmv 函数
for f in ~/.config/fish/functions/fn_cpv.fish ~/.config/fish/functions/fn_rmv.fish
    if test -f $f
        source $f
    end
end

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

if status is-interactive
    ensure_fisher_installed

    # Commands to run in interactive sessions can go here
    set -U fish_greeting "Hello Tunglies!
    (=^･ω･^=)"

    set_proxy
    
    set -gx PATH /opt/homebrew/bin $PATH
    set -gx PATH ~/.cargo/bin $PATH

    alias gcl="git clone"
    alias gpl="git pull --rebase"
    alias gpu="git push"
    alias ga="git add"
    alias gcm="git commit -m"
    alias gc="git commit"
    alias gca="git commit --amend"
    alias gco="git checkout"
    alias gbr="git branch"
    alias gm="git merge --rebase"
    alias gcp="git cherry-pick"
    alias gst="git status"
    alias gds="git diff --staged"
    alias gdc="git diff"
    alias glg="git log --graph --oneline --decorate --all"

    zoxide init fish | source

    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH

    set -gx PNPM_HOME "$HOME/Library/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
      set -gx PATH "$PNPM_HOME" $PATH
    end
end
