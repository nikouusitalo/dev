
#!/usr/bin/env bash
set -euo pipefail
sudo apt install nodejs npm

PREFIX="$HOME/.local/npm"

echo "Käytetään PREFIX: $PREFIX"

# 1) Kansio olemassa?
if [ ! -d "$PREFIX" ]; then
  echo "Luodaan $PREFIX"
  mkdir -p "$PREFIX"
fi

# 2) Onko kirjoitusoikeus?
if [ ! -w "$PREFIX" ]; then
  echo "Virhe: Ei kirjoitusoikeutta kansioon $PREFIX"
  echo "Korjaa oikeudet esim: chmod -R u+rwX '$PREFIX' (tarvittaessa)"
  exit 1
fi

# 3) npm globaalit -> sama prefix
npm config set prefix "$PREFIX" --location=user

# 4) n:n Node-asennukset -> sama prefix (tämä korjaa /usr/local/n -ongelman)
export N_PREFIX="$PREFIX"

# 5) PATH kuntoon TÄSSÄ skriptissä (ei luoteta .bashrc:hen)
export PATH="$PREFIX/bin:$PATH"

# 6) Asenna n ja sitten Node LTS
npm install -g n
n lts

# 7) Näytä mitä saatiin
echo "Valmis. Polut:"
echo "  npm prefix: $(npm prefix -g)"
echo "  n prefix:   ${N_PREFIX}"
echo "  node:       $(command -v node || true)"
echo "  node -v:    $(node -v || true)"
echo "  npm -v:     $(npm -v || true)"


sudo apt purge -y nodejs npm
sudo apt autoremove -y


