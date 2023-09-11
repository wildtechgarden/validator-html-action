# GitHub action to validate HTML and CSS of site

Description: GitHub action using W3C's validator to validate the HTML and CSS of
a website  
Repository URL: <https://github.com/wildtechgarden/validator-html-action>  
Site: <https://www.validator-html-action.wtg-demos.ca>  
CI Status: [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/wildtechgarden/validator-html-action/main.svg)](https://results.pre-commit.ci/latest/github/wildtechgarden/validator-html-action/main)
[![build-audit](https://github.com/wildtechgarden/validator-html-action/actions/workflows/build-audit.yml/badge.svg)](https://github.com/wildtechgarden/validator-html-action/actions/workflows/build-audit.yml)

## Contents

1. [Contents](#contents)
2. [Configuration and usage](#configuration-and-usage)
   1. [Actions inputs variables](#actions-inputs-variables)
   2. [Sample usage](#sample-usage)
3. [Development](#development)
4. [Colophon](#colophon)

## Configuration and usage

### Actions inputs variables

| Input | Required | Default | Meaning |
|-------|-------|---------|---------|
| action-workspace | yes | _(none)_ | Workspace of caller |
| download-site-as | yes | unminified-site | GitHub Artifact containing a tarball with the site |
| download-site-filename | yes | hugo-site.tar | Name of tarball containing the site |
| output-directory | yes | public | subdirectory (in tarball) containing the site to validate |
| use-existing-workspace | no | false | Use an existing checkout and built site instead of artifact |

The tarball (default ``hugo-site.tar``) in the artifact (default
``unminified-site``) pointed at by ``download-site-as`` must contain the
following:

* A subdirectory tree containing the site (default: _public_, optionally
defined by ``output-directory``).

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
    - name: "Build site with Hugo and audit"
      uses: wildtechgarden/audit-build-action-hugo-dfd@main
      with:
        base-url: "https://www.example.com/"
        build-for-downstream: "true"
        source-directory: exampleSite
        use-lfs: false
    - uses: actions/checkout@v3
      with:
        path: validate-html-action
    - name: "Validate HTML of statically generated website"
      uses: wildtechgarden/validator-html-action@main
      with:
        action-workspace: ${{ github.workspace }}/validate-html-action
        use-existing-workspace: "true"
```

## Development

TBD

-------

## Colophon

Copyright © 2023 Wild Tech 'Garden'  
[Released under an MIT License](LICENSE)
