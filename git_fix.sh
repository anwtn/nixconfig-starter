# Run this after a nixos build to fix the ssh socket for git.
export SSH_AUTH_SOCK=$(find /tmp -name "agent.*" -type s 2>/dev/null | head -n 1)
ssh-add ~/.ssh/id_ed25519_personal