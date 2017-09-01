CRYPTO_PROMPT_COLOR="yellow"
CRYPTO_BADSTATUS_COLOR="red"
CRYPTO_SUDO_COLOR="yellow"
CRYPTO_JOB_COLOR="cyan"
CRYPTO_USER_COLOR="red"
CRYPTO_DIR_COLOR="green"
CRYPTO_RUST_COLOR="red"
CRYPTO_DOCKER_COLOR="blue"
CRYPTO_PYENV_COLOR="yellow"
CRYPTO_AWS_COLOR="208"

CRYPTO_PROMPT_SYMBOL="λ"
CRYPTO_BADSTATUS_SYMBOL="✘"
CRYPTO_SUDO_SYMBOL="⚡"
CRYPTO_JOB_SYMBOL="⚙"
CRYPTO_RUST_SYMBOL="𝗥"
CRYPTO_DOCKER_SYMBOL="🐳"
CRYPTO_PYENV_SYMBOL="🐍"
CRYPTO_AWS_SYMBOL="☁"

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

# NODE
CRYPTO_NODE_SHOW="true"
CRYPTO_NODE_COLOR="magenta"
CRYPTO_NODE_SYMBOL="⬢"
CRYPTO_NODE_DEFAULT_VERSION=""

# Check if command exists in $PATH
_exists() {
    command -v $1 > /dev/null 2>&1
}

# Check if the current directory is in a Git repository.
_is_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null
}

_prompt_segment() {
    local color content
    [[ -n $1 ]] && color="%F{$1}" || color="%f"
    [[ -n $2 ]] && content="$2" || content=""
    echo -n "%{%B$color%}"  # set color
    echo -n "$content"  # section content
    echo -n "%{%b%f%}"  # unset color
}

prompt_status() {
    if [[ $RETVAL -ne 0 ]]; then
        _prompt_segment $CRYPTO_BADSTATUS_COLOR "$CRYPTO_BADSTATUS_SYMBOL "
    elif [[ $UID -eq 0 ]]; then
        _prompt_segment $CRYPTO_SUDO_COLOR "$CRYPTO_SUDO_SYMBOL "
    elif [[ $(jobs -l | wc -l) -gt 0 ]]; then
        _prompt_segment $CRYPTO_JOB_COLOR "$CRYPTO_JOB_SYMBOL "
    else
        _prompt_segment $CRYPTO_PROMPT_COLOR "$CRYPTO_PROMPT_SYMBOL "
    fi
}

prompt_user() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        _prompt_segment $CRYPTO_USER_COLOR "$USER@%m "
    fi
}

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

prompt_git() {
    [[ $CRYPTO_GIT_SHOW == false ]] && return

    local git_branch="$(crypto_git_branch)" git_status="$(crypto_git_status)"
    [[ -z $git_branch ]] && return

    _prompt_segment \
        'white' \
        "${git_branch}${git_status} "
}

prompt_node() {
    [[ $CRYPTO_NODE_SHOW == false ]] && return

    # Show NODE status only for JS-specific folders
    [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

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
        "via ${SPACESHIP_NODE_SYMBOL} ${node_version} "
}

prompt_virtualenv() {
    local virtualenv_path="$VIRTUAL_ENV"
    if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        _prompt_segment \
            $CRYPTO_PYENV_COLOR \
            "($CRYPTO_PYENV_SYMBOL `basename $virtualenv_path`)"
    fi
}

build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_user
    prompt_dir
    echo -n "%{$fg[yellow]%}➜ "
    prompt_git
    prompt_node
    prompt_virtualenv
}

PROMPT='$(build_prompt) %{$reset_color%}'