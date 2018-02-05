#!/usr/bin/env zsh

CRYPTO_PROMPT_COLOR="yellow"
CRYPTO_BADSTATUS_COLOR="red"
CRYPTO_SUDO_COLOR="yellow"
CRYPTO_JOB_COLOR="cyan"
CRYPTO_USER_COLOR="red"
CRYPTO_DIR_COLOR="green"

CRYPTO_PROMPT_SYMBOLS=(π λ Δ Π Σ Φ Ψ Ω ω μ ∀ ∂ ∮)
CRYPTO_BADSTATUS_SYMBOL="✘"
CRYPTO_SUDO_SYMBOL="⚡"
CRYPTO_JOB_SYMBOL="⚙"

# GIT
CRYPTO_GIT_SHOW="true"
CRYPTO_GIT_SYMBOL=""
CRYPTO_GIT_BRANCH_SYMBOL="$CRYPTO_GIT_SYMBOL"
CRYPTO_GIT_BRANCH_COLOR="166"  # orange
CRYPTO_GIT_STATUS_PREFIX=" ["
CRYPTO_GIT_STATUS_SUFFIX="]"
CRYPTO_GIT_STATUS_COLOR="red"
CRYPTO_GIT_STATUS_UNTRACKED="?"
CRYPTO_GIT_STATUS_ADDED="+"
CRYPTO_GIT_STATUS_MODIFIED="!"
CRYPTO_GIT_STATUS_RENAMED="»"
CRYPTO_GIT_STATUS_DELETED="✘"
CRYPTO_GIT_STATUS_STASHED="$"
CRYPTO_GIT_STATUS_UNMERGED="="
CRYPTO_GIT_STATUS_AHEAD="⇡"
CRYPTO_GIT_STATUS_BEHIND="⇣"
CRYPTO_GIT_STATUS_DIVERGED="⇕"

# RUST
CRYPTO_RUST_SHOW="true"
CRYPTO_RUST_SHOW_VERSION="true"
CRYPTO_RUST_SHOW_TOOLCHAIN="true"
CRYPTO_RUST_COLOR="red"
CRYPTO_RUST_SYMBOL="𝗥"

# NODE
CRYPTO_NODE_SHOW="true"
CRYPTO_NODE_COLOR="magenta"
CRYPTO_NODE_SYMBOL="⬢"
CRYPTO_NODE_DEFAULT_VERSION=""

# VIRTUAL ENV
CRYPTO_VENV_SHOW="true"
CRYPTO_VENV_COLOR="blue"
CRYPTO_VENV_SYMBOL=""


# Check if command exists in $PATH
_exists() {
    command -v $1 > /dev/null 2>&1
}

# Check if the current directory is a Git repository.
_is_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null
}

# Builds a 'segment' of the prompt, given a color and content/symbol.
_prompt_segment() {
    local color content
    [[ -n $1 ]] && color="%F{$1}" || color="%f"
    [[ -n $2 ]] && content="$2" || content=""
    echo -n "%{%B$color%}"  # set color
    echo -n "$content"  # section content
    echo -n "%{%b%f%}"  # unset color
}

# Builds the status segment. Displays the prompt symbol by default unless:
#   1) the last process returned a non-zero status
#   2) the UID is root
#   3) there are background jobs
prompt_status() {
    if [[ $RETVAL -ne 0 ]]; then
        _prompt_segment $CRYPTO_BADSTATUS_COLOR "$CRYPTO_BADSTATUS_SYMBOL "
    elif [[ $UID -eq 0 ]]; then
        _prompt_segment $CRYPTO_SUDO_COLOR "$CRYPTO_SUDO_SYMBOL "
    elif [[ $(jobs -l | wc -l) -gt 0 ]]; then
        _prompt_segment $CRYPTO_JOB_COLOR "$CRYPTO_JOB_SYMBOL "
    else
        # Randomly select a prompt symbol every time a new line is started
        local rand
        if _exists shuf; then
            rand=`shuf -i 0-12 -n 1`
        # If on a Mac, jot should work
        elif _exists jot; then
            rand=`jot -r 1 1 13`
        else
            rand=0
        fi

        _prompt_segment \
            $CRYPTO_PROMPT_COLOR \
            "${CRYPTO_PROMPT_SYMBOLS[$rand]} "
    fi
}

# Builds the user segment. Only displayed if the user has su'ed to
# another user or is using ssh.
prompt_user() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        _prompt_segment $CRYPTO_USER_COLOR "$USER@%m "
    fi
}

# Builds the directory display segment.
prompt_dir() {
    _prompt_segment $CRYPTO_DIR_COLOR "%~ "
}

crypto_git_branch() {
    _is_git || return
    _prompt_segment $CRYPTO_GIT_BRANCH_COLOR "$CRYPTO_GIT_BRANCH_SYMBOL $(git_current_branch)"
}

crypto_git_status() {
    _is_git || return

    ZSH_THEME_GIT_PROMPT_UNTRACKED=$CRYPTO_GIT_STATUS_UNTRACKED
    ZSH_THEME_GIT_PROMPT_ADDED=$CRYPTO_GIT_STATUS_ADDED
    ZSH_THEME_GIT_PROMPT_MODIFIED=$CRYPTO_GIT_STATUS_MODIFIED
    ZSH_THEME_GIT_PROMPT_RENAMED=$CRYPTO_GIT_STATUS_RENAMED
    ZSH_THEME_GIT_PROMPT_DELETED=$CRYPTO_GIT_STATUS_DELETED
    ZSH_THEME_GIT_PROMPT_STASHED=$CRYPTO_GIT_STATUS_STASHED
    ZSH_THEME_GIT_PROMPT_UNMERGED=$CRYPTO_GIT_STATUS_UNMERGED
    ZSH_THEME_GIT_PROMPT_AHEAD=$CRYPTO_GIT_STATUS_AHEAD
    ZSH_THEME_GIT_PROMPT_BEHIND=$CRYPTO_GIT_STATUS_BEHIND
    ZSH_THEME_GIT_PROMPT_DIVERGED=$CRYPTO_GIT_STATUS_DIVERGED

    local git_status="$(git_prompt_status)"
    if [[ -n $git_status ]]; then
        _prompt_segment \
            "$CRYPTO_GIT_STATUS_COLOR" \
            "$CRYPTO_GIT_STATUS_PREFIX$git_status$CRYPTO_GIT_STATUS_SUFFIX"
    fi
}

# Shows git information if in a git repository.
prompt_git() {
    [[ $CRYPTO_GIT_SHOW == false ]] && return

    local git_branch="$(crypto_git_branch)" git_status="$(crypto_git_status)"
    [[ -z $git_branch ]] && return

    _prompt_segment \
        'white' \
        "${git_branch}${git_status} "
}

# Displays the current Rust version if working on a Rust project.
prompt_rust() {
    [[ $CRYPTO_RUST_SHOW == false ]] && return

    [[ -f Cargo.toml ]] || return
    #[[ -f Cargo.toml || -n *.rs(#qN) ]] || return
    _exists rustc || return

    local -a rust_version
    [[ $CRYPTO_RUST_SHOW_VERSION == false ]] || rust_version+="v$(rustc --version | grep --colour=never -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]')"
    [[ $CRYPTO_RUST_SHOW_TOOLCHAIN == false ]] || rust_version+=$(rustc --version | grep --colour=never -oE '(stable|beta|nightly)' || echo stable)

    _prompt_segment \
        "$CRYPTO_RUST_COLOR" \
        "${CRYPTO_RUST_SYMBOL} ${rust_version}"
}

# Displays the current Node version if working on a Node project.
prompt_node() {
    [[ $CRYPTO_NODE_SHOW == false ]] && return

    # Show NODE status only for JS-specific folders
    [[ -f package.json || -d node_modules ]] || return
    #ls *.js &>/dev/null || return

    local node_version
    if _exists nvm; then
        node_version=$(nvm current 2>/dev/null)
        [[ $node_version == "system" || $node_version == "node" ]] && return
    elif _exists nodenv; then
        node_version=$(nodenv version-name)
        [[ $node_version == "system" || $node_version == "node" ]] && return
    elif _exists node; then
        node_version=$(node -v 2>/dev/null)
        [[ $node_version == $CRYPTO_NODE_DEFAULT_VERSION ]] && return
    else
        return
    fi

    _prompt_segment \
        $CRYPTO_NODE_COLOR \
        "via ${CRYPTO_NODE_SYMBOL} ${node_version} "
}

# Displays if a virtual env is running.
prompt_virtualenv() {
    [[ $CRYPTO_VENV_SHOW == false ]] && return

    [ -n "$VIRTUAL_ENV" ] && _exists deactivate || return

    _prompt_segment \
        $CRYPTO_VENV_COLOR \
        "$VIRTUAL_ENV $CRYPTO_VENV_SYMBOL"
}

build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_user
    prompt_dir
    echo -n "%{$fg[yellow]%}➜ "
    prompt_git
    prompt_node
    prompt_rust
    prompt_virtualenv
}

PROMPT='$(build_prompt) %{$reset_color%}'
