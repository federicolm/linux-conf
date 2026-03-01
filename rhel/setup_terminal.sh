#!/bin/bash
# Colori e messaggi in una sola funzione
_c() { case $1 in info) c="\033[0;34m"; p="[INFO]";; ok) c="\033[0;32m"; p="[✅ SUCCESS]";; warn) c="\033[0;33m"; p="[⚠️ WARNING]";; err) c="\033[0;31m"; p="[❌ ERROR]";; ask) c="\033[0;36m"; p="[🤔 ASK]";; esac; shift; echo -e "${c}${p}\033[0m $*"; }
print_msg()     { _c info "$@"; }
print_success() { _c ok "$@"; }
print_warn()    { _c warn "$@"; }
print_error()   { _c err "$@"; }
print_ask()     { _c ask "$@"; }
command_exists() { command -v "$1" &>/dev/null; }

# Installazione pacchetti multipli se mancanti
install_if_missing() {
    local pkgs=()
    for pkg; do command_exists "$pkg" || pkgs+=("$pkg"); done
    [ ${#pkgs[@]} -gt 0 ] && sudo dnf install -y "${pkgs[@]}"
}

# Installazione pip3 e aggiunta PATH
install_pip3() {
    print_msg "nstallazione di pip3"
    sudo dnf install -y python3-pip

    print_msg "Aggiunta di ~/.local/bin al PATH se non già presente"
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
        source ~/.bashrc
    fi
}

# Installazione MyBash, font, Starship, FZF, Zoxide
install_mybash() {
    print_msg "Installazione e configurazione MyBash..."
    USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
    gitpath="$USER_HOME/.mybash"
    install_if_missing git curl wget unzip fontconfig
    [ -d "$gitpath" ] && { print_warn "Rimozione MyBash esistente..."; rm -rf "$gitpath"; }
    mkdir -p "$USER_HOME/.local/share"
    sudo -u "${SUDO_USER:-$USER}" git clone https://github.com/ChrisTitusTech/mybash.git "$gitpath"

    # Font Nerd Font
    FONT_NAME="MesloLGS Nerd Font Mono"
    if ! fc-list :family | grep -iq "$FONT_NAME"; then
        print_msg "Installazione font '$FONT_NAME'..."
        FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip"
        FONT_DIR="$USER_HOME/.local/share/fonts/$FONT_NAME"
        TEMP_DIR=$(mktemp -d)
        curl -sSLo "$TEMP_DIR/meslo.zip" "$FONT_URL"
        unzip "$TEMP_DIR/meslo.zip" -d "$TEMP_DIR"
        mkdir -p "$FONT_DIR"
        mv "$TEMP_DIR"/*.ttf "$FONT_DIR" 2>/dev/null
        fc-cache -fv
        rm -rf "$TEMP_DIR"
        print_success "Font '$FONT_NAME' installato."
    else
        print_warn "Font '$FONT_NAME' già installato."
    fi

    # Starship
    print_msg "Installazione Starship..."
    curl -sSL https://starship.rs/install.sh | sh -s -- -y || { print_error "Errore Starship!"; exit 1; }

    # FZF
    if ! command_exists fzf; then
        sudo dnf install -y fzf || { print_warn "FZF non trovato, installazione da git..."; sudo -u "${SUDO_USER:-$USER}" git clone --depth 1 https://github.com/junegunn/fzf.git "$USER_HOME/.fzf"; sudo -u "${SUDO_USER:-$USER}" "$USER_HOME/.fzf/install" --all; }
    else
        print_warn "FZF già installato."
    fi

    # Zoxide
    if ! command_exists zoxide; then
        . /etc/os-release
        if [[ "$VERSION_ID=" == "8" ]]; then
            sudo dnf copr enable -y atim/zoxide && sudo dnf install -y zoxide || curl -sSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || { print_error "Errore Zoxide!"; exit 1; }
        else
            print_warn "Versione OS : $VERSION_ID attualmente non compatibile con zoxide"
    else
        print_warn "Zoxide già installato."
    fi

     # Link configurazioni
    print_msg "Collegamento file configurazione..."
    [ -e "$USER_HOME/.bashrc" ] && [ ! -e "$USER_HOME/.bashrc.bak" ] && mv "$USER_HOME/.bashrc" "$USER_HOME/.bashrc.bak"
    ln -svf "$gitpath/.bashrc" "$USER_HOME/.bashrc"
    mkdir -p "$USER_HOME/.config"
    ln -svf "$gitpath/starship.toml" "$USER_HOME/.config/starship.toml"
    print_success "MyBash installato con successo!"
}

# Fastfetch
setup_fastfetch() {
    print_msg "Installazione Fastfetch"
    sudo dnf -y install fastfetch

    print_msg "Copia file configurazione Fastfetch..."
    mkdir -p "$HOME/.config/fastfetch"
    curl -sSLo "$HOME/.config/fastfetch/config.jsonc" https://raw.githubusercontent.com/ChrisTitusTech/mybash/main/config.jsonc
    print_success "File di configurazione Fastfetch copiato."

    print_msg "Aggiunta Fastfetch alla shell..."
    if grep -q "fastfetch" "$HOME/.bashrc"; then
        print_warn "Fastfetch è già configurato in .bashrc"
    else
        echo -e "\n# Avvia Fastfetch all'avvio della shell\nfastfetch" >>"$HOME/.bashrc"
        print_success "Fastfetch aggiunto a .bashrc"
    fi
}

# Installazione Font Addizionali (Terminus)
install_additional_fonts() {
    print_msg "Installazione font addizionali (Terminus)..."

    FONT_PACKAGE="terminus-fonts"

    sudo rpmquery -qa | grep -qi $FONT_PACKAGE
    if ! $? ; then
        . /etc/os-release
        if [[ "$VERSION_ID=" == "8" ||  "$VERSION_ID=" == "9" ]]; then
            print_msg "Installazione del font Terminus in corso..."
            sudo dnf install -y epel-release && sudo dnf install -y zoxide || { print_error "Errore Zoxide!"; exit 1; }
        else
            print_warn "Versione OS : $VERSION_ID attualmente non compatibile con $FONT_PACKAGE"
    else
        print_warn "$FONT_PACKAGE già installato."
    fi

    print_msg "Configurazione del font Terminus per la TTY..."
    if [ -f "/etc/vconsole.conf" ]; then
        sed -i 's/^FONT=.*/FONT="ter-v22b"/' /etc/vconsole.conf
        update-initramfs -u
        print_success "Font Terminus configurato per TTY."
    else
        print_warn "File /etc/vconsole.conf non trovato, salto configurazione TTY."
    fi
}

# Installazione e configurazione alias utili

install_alias() {
    print_msg "Configurazione alias utili per il sistema..."

    BASHRC_FILE="$HOME/.bashrc"
    ALIASES_FILE="$HOME/.bash_aliases"

    # Verifica se .bashrc carica già .bash_aliases
    if ! grep -q "\.bash_aliases" "$BASHRC_FILE" 2>/dev/null; then
        print_msg "Configurazione di .bashrc per caricare .bash_aliases..."

        # Aggiungi il caricamento di .bash_aliases in .bashrc
        cat >>"$BASHRC_FILE" <<'EOL'

# Carica alias personalizzati se il file esiste
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOL
    fi

    # Crea il file .bash_aliases se non esiste
    if [ ! -f "$ALIASES_FILE" ]; then
        touch "$ALIASES_FILE"
        print_msg "Creato file .bash_aliases"
    fi

    # Verifica se gli alias esistono già per evitare duplicati
    if ! grep -q "alias upd=" "$ALIASES_FILE" 2>/dev/null; then
        print_msg "Aggiunta alias per aggiornamento sistema..."
        cat >>"$ALIASES_FILE" <<'EOL'

# Alias per aggiornamento completo sistema
alias upd='flatpak update -y && sudo yum -y update '
EOL
    fi

    if ! grep -q "alias clean=" "$ALIASES_FILE" 2>/dev/null; then
        print_msg "Aggiunta alias per pulizia sistema..."
        cat >>"$ALIASES_FILE" <<'EOL'

# Alias per pulizia pacchetti inutilizzati
alias clean='flatpak remove --unused -y && sudo yum -y clean all'
EOL
    fi

    # Assicurati che il file abbia i permessi corretti
    chmod 644 "$ALIASES_FILE"

    # Ricarica gli alias nel processo corrente
    if [ -f "$ALIASES_FILE" ]; then
        source "$ALIASES_FILE" 2>/dev/null || true
    fi

    print_success "Alias configurati con successo."
}

# Funzione per ritornare allo script principale
return_to_main() {
    print_msg "Ritornando allo script principale..."
    exit 0
}

main() {
    install_pip3
    install_mybash
    setup_fastfetch
    install_additional_fonts
    install_alias

}
# Avvio dello script
main
sleep 2
print_warn "Riavvia la shell alla fine dello script per vedere i cambiamenti."
sleep 5
return_to_main