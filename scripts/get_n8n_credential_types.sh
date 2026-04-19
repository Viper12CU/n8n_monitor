#!/bin/bash
# Script para obtener los tipos de credencial válidos de n8n
# Uso: ./get_n8n_credential_types.sh <BASE_URL> <API_KEY>

if [ $# -lt 2 ]; then
    echo "Uso: $0 <BASE_URL> <API_KEY>"
    echo ""
    echo "Ejemplo:"
    echo "  $0 http://localhost:5678 sk_test_..."
    echo ""
    echo "Esto mostrará todos los tipos de credencial válidos en tu instancia de n8n"
    exit 1
fi

BASE_URL="$1"
API_KEY="$2"

echo "Obteniendo tipos de credencial de: $BASE_URL"
echo ""

# Intenta obtener el schema de credenciales
curl -s -X GET "$BASE_URL/api/v1/credentials/schema" \
  -H "X-N8N-API-KEY: $API_KEY" \
  -H "Content-Type: application/json" | python3 -m json.tool

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Error al conectar. Verifica:"
    echo "   - BASE_URL es correcto: $BASE_URL"
    echo "   - API_KEY es válida"
fi
