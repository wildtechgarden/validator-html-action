# Actionne GitHub ce-qui vérifier le HTML et CSS d'une site

Décrit: Actionne GitHub ce-qui utiliser W3C `validator` a vérifier le HTML et CSS
d'une site  
URL du référentiel: <https://github.com/wildtechgarden/validator-html-action>\
Site: <https://www.validator-html-action.wtg-demos.ca>  
Statut IC: [![pre-commit.ci statut](https://results.pre-commit.ci/badge/github/wildtechgarden/validator-html-action/main.svg)](https://results.pre-commit.ci/latest/github/wildtechgarden/validator-html-action/main)
[![build-audit](https://github.com/wildtechgarden/validator-html-action/actions/workflows/build-audit.yml/badge.svg)](https://github.com/wildtechgarden/validator-html-action/actions/workflows/build-audit.yml)

## Matières

1. [Matières](#matières)
2. [Configuration and utilisation](#configuration-and-utilisation)
   1. [Actions inputs variables](#actions-inputs-variables)
   2. [Sample usage](#sample-usage)
3. [Développement](#développement)
4. [Colophon](#colophon)

## Configuration and utilisation

### Actions inputs variables

| Input | Required | Default | Dit-on |
|-------|-------|---------|---------|
| download-site-as | non | unminified-site | GitHub Artifact qui contenu le tarball avec le site |
| download-site-filename | non | hugo-site.tar | Nom de tarball qui contenu le site |
| output-directory | no | public | subdirectory (en tarball) contenu le site a vérifier |
| repo-token | oui | _(none)_ | GITHUB_TOKEN |
| use-existing-workspace | non | false | Utiliser un workspace existent et le site créer vers un artefact |

Le tarball (défaut ``hugo-site.tar``) en l'artefact (défaut
``unminified-site``) avec le nom en ``download-site-as`` et contenu:

* Un subdirectory contenu le site (défaut: _public_, ou option
á ``output-directory``).

### Sample usage

```yaml
name: test-html-validate
on:
  pull_request:
    types:
    - assigned
    - opened
    - synchronize
    - reopened
  push:
    branches:
    - main
jobs:
  build-unminified-site:
    runs-on: ubuntu-20.04
    steps:
    - name: "Créer site avec Hugo et auditer"
      uses: wildtechgarden/audit-build-action-hugo-dfd@main
      with:
        base-url: "https://www.example.com/"
        build-for-downstream: "true"
        source-directory: échantillon
        use-lfs: false
    - uses: actions/checkout@v3
      with:
        path: validate-html-action
    - name: "Vérifier HTML de site"
      uses: wildtechgarden/validator-html-action@main
      with:
        action-workspace: ${{ github.workspace }}/validate-html-action
        use-existing-workspace: "true"
```

## Développement

TBD

-------

## Colophon

Copyright © 2023 Wild Tech 'Garden'  
[Publié sous license MIT](LICENSE)
