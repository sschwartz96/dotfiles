#!/bin/sh

# requires pnpm and go

pnpm i -g @tailwindcss/language-server
pnpm i -g typescript-language-server
pnpm i -g vscode-langservers-extracted

GO111MODULE=on go install golang.org/x/tools/gopls@latest
