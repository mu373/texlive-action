![Test TeXLive Action](https://github.com/mu373/texlive/workflows/Test%20TeXLive%20Action/badge.svg)
---

# TeXLive Action

This action compiles LaTeX docs to PDF using latexmk with a minimal texlive image.
- Diff from original repoository ([repaction/texlive](https://github.com/repaction/texlive)): MS fonts included (i.e., Times New Roman)

## Example
In your tex document repository:
```yaml
name: Build LaTeX document
on:
  workflow_dispatch:

jobs:
  build_latex:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v3
      - name: Login to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.repository_owner }}
          password: ${{ secrets.container_registory_pat }} # You need to have your Personal Access Token set to environment secrets `$container_registory_pat` 
      - name: Pull LaTeX Docker image
        run: docker pull ghcr.io/mu373/texlive-action:latest
      - name: Compile LaTeX document
        run: |
          docker run --rm \
            -v ${{ github.workspace }}:/files \
            -w /files/ \
            ghcr.io/mu373/texlive-action:latest \
            main.tex \
            latexmk \
            ''
      - name: Archive production artifacts
        uses: actions/upload-artifact@v3
        with:
          name: pdf
          path: main.pdf
          retention-days: 5
```

## References:

[1] <https://github.com/xu-cheng/latex-action>
