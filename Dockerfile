FROM node:22-alpine

WORKDIR /usr/src/app

# Installer scrabble-solver avec logs détaillés et sortie d'erreurs complète
RUN npx scrabble-solver@latest --yes --verbose || exit 1

EXPOSE 3333

CMD ["npx", "scrabble-solver@latest"]