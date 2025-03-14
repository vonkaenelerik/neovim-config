
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/vonk809/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/vonk809/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/vonk809/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/vonk809/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias vim="nvim"
alias vi="nvim"

# find directory in documents, cd to it and open in neovim
fvd() {
  local dir
  dir=$(fd -t d . ~/Documents | fzf) && cd "$dir" && nvim .
}

# fuzzy find file and open in neovim
# includes hidden files and files ignored by .gitignore
fvf() {
  local file
  file=$(fd -t f --hidden --no-ignore . ~ --exclude .cache --exclude node_modules | fzf) && cd "$(dirname "$file")" && nvim "$(basename "$file")"
}

# fuzzy find directory and open in vscode
fvsd() {
  local dir
  dir=$(fd -t d . ~/Documents | fzf) && code "$dir"
}

# fuzzy find directory and open in rstudio. if a .Rproj file exists in the target directory, open that enstead
frd() {
  local dir rproj
  dir=$(fd -t d . ~/Documents | fzf) || return
  rproj=$(find "$dir" -maxdepth 1 -type f -name "*.Rproj" | head -n 1)

  if [[ -n "$rproj" ]]; then
    open -a RStudio "$rproj"
  else
    open -a RStudio "$dir"
  fi
}

# Create a new project from the template repository
# Usage: new_project [--name project-name] [--python version] [--dir directory]
function npp() {
  # Default values
  local TEMPLATE_REPO="git@github.com:vonkaenelerik/slim_python_project.git"
  local PROJECT_NAME=""
  local PYTHON_VERSION=""
  local TARGET_DIR=""

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -n|--name)
        PROJECT_NAME="$2"
        shift 2
        ;;
      -p|--python)
        PYTHON_VERSION="$2"
        shift 2
        ;;
      -d|--dir)
        TARGET_DIR="$2"
        shift 2
        ;;
      -h|--help)
        echo "Usage: new_project [options]"
        echo "Options:"
        echo "  -n, --name NAME      Set project name"
        echo "  -p, --python X.Y     Set Python version (e.g., 3.12)"
        echo "  -d, --dir PATH       Set target directory (default: project name)"
        echo "  -h, --help           Show this help message"
        return 0
        ;;
      *)
        echo "Unknown option: $1"
        return 1
        ;;
    esac
  done

  # Prompt for project name if not provided
  if [[ -z "$PROJECT_NAME" ]]; then
    echo -n "Enter project name: "
    read PROJECT_NAME
    if [[ -z "$PROJECT_NAME" ]]; then
      echo "Project name is required"
      return 1
    fi
  fi

  # Set target directory if not specified
  if [[ -z "$TARGET_DIR" ]]; then
    TARGET_DIR="$PROJECT_NAME"
  fi

  # Check if target directory already exists
  if [[ -d "$TARGET_DIR" ]]; then
    echo -n "Directory $TARGET_DIR already exists. Overwrite? [y/N] "
    read confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
      echo "Aborted"
      return 1
    fi
    rm -rf "$TARGET_DIR"
  fi

  echo "Creating new project '$PROJECT_NAME' in directory '$TARGET_DIR'..."

  # Clone the template repository
  git clone "$TEMPLATE_REPO" "$TARGET_DIR"
  if [[ $? -ne 0 ]]; then
    echo "Failed to clone template repository"
    return 1
  fi

  # Change to the project directory
  cd "$TARGET_DIR"

  # Remove the original git history and initialize a new repository
  rm -rf .git
  git init

  # Build arguments for init_project.sh
  local INIT_ARGS=""
  if [[ -n "$PROJECT_NAME" ]]; then
    INIT_ARGS="$INIT_ARGS --name $PROJECT_NAME"
  fi
  if [[ -n "$PYTHON_VERSION" ]]; then
    INIT_ARGS="$INIT_ARGS --python $PYTHON_VERSION"
  fi

  # Run the initialization script
  chmod +x init_project.sh
  ./init_project.sh $INIT_ARGS

  # Initial commit
  git add .
  git commit -m "Initial commit: Project created from template"

  echo "Project setup complete! 🚀"
  echo "Project directory: $(pwd)"
  echo "To build the Docker image, run: make image"
}
