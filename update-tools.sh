#!/bin/sh

# requires pnpm and go

# list node packages to install

GREEN='\033[0;32m'
NC='\033[0m' # No Color

node_packages=("pnpm" "yaml-language-server" "svelte-language-server" "@tailwindcss/language-server" "typescript-language-server" "vscode-langservers-extracted")

for p in ${node_packages[@]}; do
	echo -e "    ${GREEN}Updating $p ${NC}"
	pnpm i -g $p
	echo ""
done

go_packages=("golang.org/x/tools/gopls@latest" "github.com/go-delve/delve/cmd/dlv@latest")

for p in ${go_packages[@]}; do
	echo -e "    ${GREEN}Updating $p ${NC}"
	GO111MODULE=on go install $p
done
