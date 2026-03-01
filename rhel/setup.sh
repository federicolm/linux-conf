#!/bin/bash
## Wrapper generale per l'installazione automatica di RHEL Based
# Verifica permessi di root
if [ "$(id -u)" != "0" ]; then
    echo "⚠️  Questo script richiede i permessi di amministratore."
    echo "Riavvio con sudo..."
    sudo "$0" "$@"
    exit $?
fi

# Mantieni sudo attivo per tutta la durata dello script
sudo -v
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Colori e messaggi in una sola funzione
_c() { case $1 in info) c="\033[0;34m"; p="[INFO]";; ok) c="\033[0;32m"; p="[✅ SUCCESS]";; warn) c="\033[0;33m"; p="[⚠️ WARNING]";; err) c="\033[0;31m"; p="[❌ ERROR]";; ask) c="\033[0;36m"; p="[🤔 ASK]";; esac; shift; echo -e "${c}${p}\033[0m $*"; }
print_msg()     { _c info "$@"; }
print_success() { _c ok "$@"; }
print_warn()    { _c warn "$@"; }
print_error()   { _c err "$@"; }
print_ask()     { _c ask "$@"; }
command_exists() { command -v "$1" &>/dev/null; }

show_title() {
    clear
    cat <<"EOF"
┌───────────────────────────────────────────────────────────────────┐
│                  Auto Install - RHEL Based Version                │
│                  v0.0.1 -- By MagnetarMan and FedericoLM          │
└───────────────────────────────────────────────────────────────────┘

EOF

    print_success "Benvenuto nel programma di installazione!"
    print_warn "Inizializzazione script in corso... Attendere 3 secondi."
    sleep 3
}

create_log() {
    # Salva tutto l'output dello script in un file di log nella stessa cartella
    local log_file="$SCRIPT_DIR/auto_install_rhel_$(date +%Y%m%d_%H%M%S).log"
    print_warn "Tutto l'output verrà salvato in: $log_file"
    print_warn "Se riscontri errori, invia questo file di log per investigare la problematica."
    for i in 5 4 3 2 1; do
        echo -ne "${YELLOW}Continuo tra $i...${RESET}\r"
        sleep 1
    done
    echo
    # Rilancia lo script reindirizzando stdout e stderr su tee
    if [ -z "$LOGGING_ACTIVE" ]; then
        export LOGGING_ACTIVE=1
        exec &> >(tee "$log_file")
    fi
}

# Utilità
command_exists() { command -v "$1" >/dev/null 2>&1; }

# Directory dello script corrente
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

setup_system() {
    print_msg "Aggiornamento del sistema..."
    if dnf -y update ; then
        print_success "Sistema aggiornato con successo."
    else
        print_error "Errore durante l'aggiornamento del sistema. Controlla la connessione o i repository."
    fi
    print_msg "Controllo installazione di wget..."
    if command_exists wget; then
        print_msg "WGet già installato."
    else
    if dnf -y install wget ; then
            print_success "WGet installato con successo."
        else
            print_error "Errore nell'installazione di wget."
        fi
    fi
}

# Wrapper generico per chiamare script di installazione
call_script() {  # $1=nome_script $2=descrizione $3=success_msg
    print_msg "$2"
    bash "$SCRIPT_DIR/$1"
    print_success "$3"
}

install_flatpak()   { call_script install_flatpak.sh   "Installazione di flatpak e flathub in corso..." "Flatpak e Flathub installati con successo."; }
setup_terminal()     { call_script setup_terminal.sh     "Installazione di MyBash, Starship, FZF, Zoxide, Fastfetch in corso..." "MyBash, Starship, FZF, Zoxide, Fastfetch installati con successo."; }
install_dnf()        { call_script install_dnf.sh        "Installazione pacchetti in corso..." "Pacchetti installati con successo."; }
