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

    zoxide init fish | source
end
