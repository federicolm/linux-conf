<p align="center">
	<img src="https://raw.githubusercontent.com/Magnetarman/linux-conf/refs/heads/main/Banner.png" alt="linx-conf-banner" width="800">
</p>
<p align="center">
	<em><code>Script di configurazione automatica per sistemi basati su Ubuntu (come Linux Mint, Kubuntu ecc.) ed Arch Linux (come Endeavouros). Questo script installa e configura una selezione di applicazioni e strumenti comunemente utilizzati, ottimizza le impostazioni di sistema e configura i mirror per prestazioni ottimali.</code></em>
</p>
<p align="center">
<img src="https://img.shields.io/badge/version-2.2.0-blue.svg" alt="versione">
<img src="https://img.shields.io/github/last-commit/Magnetarman/linux-conf?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/Magnetarman/linux-conf?style=default&color=0080ff" alt="repo-top-language">
  <img src="https://img.shields.io/github/languages/count/Magnetarman/linux-conf?style=default&color=0080ff" alt="repo-language-count">
	<img src="https://img.shields.io/github/license/Magnetarman/linux-conf?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
</p>
<p align="center"><!-- default option, no dependency badges. -->
</p>
<p align="center">
	<!-- default option, no dependency badges. -->
</p>
<br>

## 👾 Features

**ATTENZIONE** - Lo script rileva automaticamente la tua distro linux e si configura automaticamente.

> [!Note]
> La versione 2.0 è in **sviluppo attivo**.
>
> Lo script per Linux Mint è in fase **RELEASE**.
>
> Lo script per Arch linux è in fase **Alpha**.

---

## 📁 Struttura Cartelle

```sh
└── linux-conf/
    ├── LICENSE
    ├── README.md
    ├── mint
    │   ├── MediaHuman Audio Converter.desktop
    │   ├── install_apt.sh
    │   ├── install_external.sh
    │   ├── install_flatpack.sh
    │   ├── makeresolvedeb.sh
    │   ├── setup.sh
    │   ├── setup_games.sh
    │   ├── setup_mh.sh
    │   └── setup_terminal.sh
    ├── arch
    └── run.sh
```

### 📂 Index Progetto

<details open>
	<summary><b><code>LINUX-CONF/</code></b></summary>
	<details> <!-- __root__ Submodule -->
		<summary><b>__root__</b></summary>
		<blockquote>
			<table>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/run.sh'>run.sh</a></b></td>
				<td><code>❯ Script di avvio generale. Analizza il sistema (Debian Based o Arch Based) ed avvia in cascata lo script corrispondente al sistema operativo rilevato.</code></td>
			</tr>
			</table>
		</blockquote>
	</details>
	<details> <!-- mint Submodule -->
		<summary><b>mint</b></summary>
		<blockquote>
			<table>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/install_apt.sh'>install_apt.sh</a></b></td>
				<td><code>❯ Installazione delle app che utilizzano il gestiore pacchetti predefinito di debian APT</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/install_flatpack.sh'>install_flatpack.sh</a></b></td>
				<td><code>❯ Installazione delle app nativamente non supportate da APT tramite il gestore Flatpack</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/makeresolvedeb.sh'>makeresolvedeb.sh</a></b></td>
				<td><code>❯ Script per la corretta conversione di Da Vinci Resolve (free Version) Thanks with ❤️ to Daniel Tufvesson su Debian</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/setup_mh.sh'>setup_mh.sh</a></b></td>
				<td><code>❯ Installazione delle app Mediahuman tramite Wine o metodi custom per avere l'istallazione completa.</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/install_external.sh'>install_external.sh</a></b></td>
				<td><code>❯ Installazione delle app tramite App image ed installazione diretta del pacchetto .deb non incluso nelle repositori ufficiali.</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/setup_terminal.sh'>setup_terminal.sh</a></b></td>
				<td><code>❯ Installazione personalizzazioni del terminale linux dall'idea di Chris Tech Titus.</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/setup.sh'>setup.sh</a></b></td>
				<td><code>❯ Script avviato da 'run.sh' in caso di OS debian Based. Orchestra l'ordine e la corretta installazione delle app inserite negli altri script.</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/MediaHuman Audio Converter.desktop'>MediaHuman Audio Converter.desktop</a></b></td>
				<td><code>❯ Scorciatoia del desktop per Media Human converter. Verrà copiata sul desktop dallo script realtivo in quanto l'installazione base alcune volte fallisce nella sua creazione.</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/Magnetarman/linux-conf/blob/master/mint/setup_games.sh'>setup_games.sh</a></b></td>
				<td><code>❯ Installazione dei laucher di Steam, gestione giochi Epic Store e delle librerie necessarie per avere tutto il necessario per giocare senza problemi di dipendenze.</code></td>
			</tr>
			</table>
		</blockquote>
	</details>
</details>

---

## 🚀 Getting Started

### ☑️ Prerequisiti

Prima di iniziare con linux-conf, assicurati che il tuo ambiente di runtime soddisfi i seguenti requisiti:

- **Programming Language:** Shell
- **Richiesta Connessione ad internet durante l'esecuzione dello script**
- Richiesto intervento manuale minimo. **ATTENZIONE** a quando lo script visualizzerà la linea [🤔 ASK]
- **Spazio su disco necessario**: 50GB/80GB Liberi (l'installazione di Da Vinci Resolve richiede molto spazio in quanto verrà effettuata una coversione totale del pacchetto di installazione)

### ⚙️ Installatione

Installa linux-conf utilizzando il seguente metodo:

1. Clona la repository linux-conf:

```sh
❯ git clone https://github.com/Magnetarman/linux-conf
```

2. Utilizza il terminale per Navigare fino alla cartella:

```sh
❯ cd linux-conf
```

3. Lancia lo script di run:

```sh
❯ sudo bash run.sh
```

---

## 📌 Project Roadmap

- [x] **`V1.0`**: <strike>Release Pubblica</strike>
- [x] **`V1.1.0`**: <strike>Refactor Struttura in forma modulare.</strike>
- [x] **`V2.0.0`**: <strike>Refator totale progetto per future implementazioni. Versione linux Mint utilizzabile.</strike>
- [x] **`V2.1.0`**: <strike>Aggiornamento App.</strike>
- [x] **`V2.2.0`**: <strike>Refacor ed ottimizzazione codice vari script, test totale sulla funzionalità. Fix Warning. Aggiornamento script installazione Da Vinci con supporto alla versione 20.</strike>
- [x] **`V2.9.9`**: Inizio supporto alle versione rhel based (AlmaLinux, RockyLinux, OracleLinux nelle versioni 8.*,9.*,10.*)
- [ ] **`V3.0.0`**: Supporto per Arch Linux
- [ ] **`V4.0.0`**: Scelta interattiva al primo avvio su quali App/Funzioni installare.

---

## 🔰 Come Contribuire

- **💬 [Partecipa alle Discussioni](https://t.me/GlitchTalkGroup)**: Condividi le tue idee, fornisci feedback o fai domande.
- **🐛 [Segnala Problemi](https://github.com/Magnetarman/linux-conf/issues)**: Segnala i bug trovati o richiedi nuove funzionalità per il progetto \Python-Script`.
- **💡 [ Invia Pull Request](https://github.com/Magnetarman/linux-conf/issues)**: Revisiona le Pull Request (PR) aperte e invia le tue.

<details closed>
<summary>Linee Guida</summary>

1. **Esegui il Fork della Repository**: Inizia facendo il "fork" della repository del progetto sul tuo account GitHub.
2. **Clona in Locale**: Clona la repository di cui hai fatto il fork sulla tua macchina locale usando un client Git.
   ```sh
   git clone https://github.com/Magnetarman/linux-conf
   ```

````
3. **Crea un Nuovo Branch**: Lavora sempre su un nuovo "branch", dandogli un nome descrittivo.
 ```sh
 git checkout -b new-feature-x
````

4. **Apporta le Tue Modifiche**: Sviluppa e testa le tue modifiche in locale.
5. **Esegui il Commit delle Tue Modifiche**: Fai il "commit" con un messaggio chiaro che descriva i tuoi aggiornamenti.
   ```sh
   git commit -m 'Implementata nuova funzionalità x.'
   ```
6. **Esegui il Push su GitHub**: Fai il "push" delle modifiche sulla tua repository "fork".
   ```sh
   git push origin nuova-funzionalita-x
   ```
7. **Invia una Pull Request**: Crea una "Pull Request" (PR) verso la repository originale del progetto. Descrivi chiaramente le modifiche e le loro motivazioni.
8. **Revisione**: Una volta che la tua PR sarà revisionata e approvata, verrà unita ("merged") nel branch principale. Congratulazioni per il tuo contributo!
</details>

---

## 🎗 Licenza

Creato con ❤️ da [Magnetarman](https://magnetarman.com/). Licenza MIT. Se trovi questo progetto utile, considera di lasciare una ⭐

---

## 🙌 Personalizzazioni

**Lo script può essere personalizzato**:

- Aprire il file `run.sh` presente nella cartella:

  - **`mint/`** se si utilizza una distribuzione **Debian-based (Ubuntu, Linux Mint, ecc.)**
  - **`arch/`** se si utilizza una distribuzione **Arch-based**

- Per **evitare l’installazione di un singolo software**:

  - Individuare all’interno della sezione corrispondente le righe di codice che installano quel software.
  - Cancellare tali righe **oppure** aggiungere `#` all’inizio di ciascuna riga per **commentarle**.

- Per **disattivare l’intera sezione di installazione** (es. “Editor”, “Browser”, “Tool di sviluppo”):

  - Commentare tutte le righe della sezione aggiungendo `#` davanti ad ognuna, **oppure**
  - Commentare direttamente il richiamo della sezione dentro `run.sh`.

- lo script ovviamente **salterà automaticamente** tutte le parti commentate e installerà solo i pacchetti lasciati attivi.
