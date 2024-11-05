name: Snyk Scan

on:
  pull_request:
    branches:
      - main  # Cambia esto a la rama principal de tu proyecto

jobs:
  snyk:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.x'  # Especifica la versión de Python que necesitas

    - name: Install dependencies
      run: |
        pip install -r requirements_cpu.txt
        pip install -r requirements_gpu.txt

    - name: Install Snyk CLI
      run: npm install -g snyk

    - name: Run Snyk to check for vulnerabilities
      run: |
        snyk test --file=requirements_cpu.txt --package-manager=pip || exit 1
        snyk test --file=requirements_gpu.txt --package-manager=pip || exit 1
