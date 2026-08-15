if status is-interactive
    if not set -q SSH_AUTH_SOCK
        ssh-agent -c | source >/dev/null
    end

    ssh-add -l >/dev/null 2>&1
    or ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
    starship init fish | source
end
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
