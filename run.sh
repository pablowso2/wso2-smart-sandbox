#!/bin/bash

# Función para mostrar las opciones disponibles
mostrar_ayuda() {
    echo "=========================================================="
    echo " 🛠️  WSO2 Smart Sandbox - Script de Lanzamiento"
    echo "=========================================================="
    echo "Uso: ./run.sh [opción]"
    echo ""
    echo "Opciones disponibles:"
    echo "  -apim      : Lanza SOLO el WSO2 API Manager (Puerto 9443)."
    echo "  -is        : Lanza SOLO el WSO2 Identity Server (Puerto 9443)."
    echo "  -is-apim   : Lanza AMBOS (APIM en 9443 e IS en 9446)."
    echo "  -h, --help : Muestra este menú de ayuda."
    echo ""
    echo "Ejemplos:"
    echo "  ./run.sh -apim"
    echo "  ./run.sh -is-apim"
    echo "=========================================================="
}

# 1. Si no se pasan parámetros, mostrar la ayuda y salir
if [ "$#" -eq 0 ]; then
    mostrar_ayuda
    exit 0
fi

# 2. Leer la opción directa pasada por consola
case $1 in
    -apim) 
        MODO="apim"
        ;;
    -is) 
        MODO="is"
        ;;
    -is-apim) 
        MODO="is-apim"
        ;;
    -h|--help) 
        mostrar_ayuda
        exit 0 
        ;;
    *) 
        echo "❌ Opción desconocida o incorrecta: $1"
        echo ""
        mostrar_ayuda
        exit 1 
        ;;
esac

echo "🚀 Lanzando WSO2 Smart Sandbox en modo: $MODO"

# 3. Exportar la variable para que la lea docker-compose
export WSO2_MODE=$MODO

# 4. Ejecutar Docker (Limpiamos contenedores viejos y levantamos el nuevo)
docker-compose down -v
docker-compose up --build