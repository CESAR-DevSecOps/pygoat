# justfile para facilitar comandos do workflow 01-secret-scanning

# Executa o gitleaks via Docker e gera o relatório JSON
gitleaks:
    docker run --rm -v "$(pwd)":/tmp/repo zricethezav/gitleaks:latest \
      detect --source /tmp/repo --report-path /tmp/repo/gitleaks-report.json --report-format json

# Exibe o relatório gerado
gitleaks-report:
    cat gitleaks-report.json

# Valida o relatório e falha se encontrar segredos
gitleaks-validate:
    if grep -q '"total":0' gitleaks-report.json; then \
      echo "Nenhum segredo encontrado."; \
    else \
      echo "Segredos encontrados! Veja gitleaks-report.json."; \
      exit 1; \
    fi
