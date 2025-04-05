#!/bin/sh

### requires pnpm and go

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# list node packages to install
node_packages=("yaml-language-server" "svelte-language-server" "@tailwindcss/language-server" "typescript-language-server" "vscode-langservers-extracted" "@fsouza/prettierd")

pnpm self-update
for p in ${node_packages[@]}; do
	echo -e "    ${GREEN}Updating $p ${NC}"
	pnpm i -g $p
	echo ""
done

go_packages=("golang.org/x/tools/gopls@latest" "github.com/go-delve/delve/cmd/dlv@latest" "github.com/nametake/golangci-lint-langserver@latest")

for p in ${go_packages[@]}; do
	echo -e "    ${GREEN}Updating $p ${NC}"
	GO111MODULE=on go install $p
done

# TODO : add rust???
cargo_crates=("https://github.com/estin/simple-completion-language-server.git")

for c in ${cargo_crates[@]}; do
	echo -e "    ${GREEN}Updating $c ${NC}"
	cargo install --git $c
done
