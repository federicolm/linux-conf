#!/bin/bash
# Colori e messaggi in una sola funzione
_c() { case $1 in info) c="\033[0;34m"; p="[INFO]";; ok) c="\033[0;32m"; p="[✅ SUCCESS]";; warn) c="\033[0;33m"; p="[⚠️ WARNING]";; err) c="\033[0;31m"; p="[❌ ERROR]";; ask) c="\033[0;36m"; p="[🤔 ASK]";; esac; shift; echo -e "${c}${p}\033[0m $*"; }
print_msg()     { _c info "$@"; }
print_success() { _c ok "$@"; }
print_warn()    { _c warn "$@"; }
print_error()   { _c err "$@"; }
print_ask()     { _c ask "$@"; }

main() {
    cat <<"EOF"
┌───────────────────────────────────────────────────────────────────┐
│                   Auto Install Linux Script                       │
│                   v2.3.0 -- By Magnetarman                        │
└───────────────────────────────────────────────────────────────────┘

EOF
    print_success "Benvenuto nel programma di installazione!"
    print_warn "Rilevamento del sistema operativo... Attendere 3 secondi."
    sleep 3

    if [ -f /etc/os-release ]; then
        . /etc/os-release

        if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
            print_success "Sistema Arch-based rilevato. Avvio di arch.sh..."
            # Ottieni la directory dove si trova lo script originale
            SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

            # Richiama lo script nella sottocartella 'arch'
            bash "$SCRIPT_DIR/arch/setup.sh"

        elif [[ "$ID" == "ubuntu" || "$ID" == "debian" || "$ID_LIKE" == *"debian"* ]]; then
            print_success "Sistema Debian/Ubuntu-based rilevato. Avvio di mint.sh..."
            # Ottieni la directory dove si trova lo script originale
            SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

            # Richiama lo script nella sottocartella 'mint'
            bash "$SCRIPT_DIR/mint/setup.sh"
        elif [[ "$ID" == "rocky" || "$ID" == "almalinux" ]]; then
            print_success "Sistema RHEL-based rilevato. Avvio di rhel.sh..."
            # Ottieni la directory dove si trova lo script originale
            SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

            # Richiama lo script nella sottocartella 'mint'
            bash "$SCRIPT_DIR/rhel/setup.sh"
        else
            print_error "Distribuzione non supportata: $ID"
        fi
    else
        print_error "Impossibile determinare il sistema operativo. File /etc/os-release mancante."
    fi
}

main
