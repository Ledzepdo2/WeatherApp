#!/bin/bash

# Script para integrar SwiftLint en Xcode
# Este script debe ser agregado como "Run Script Phase" en tu proyecto de Xcode

# Verificar si SwiftLint está instalado
if which swiftlint >/dev/null; then
    echo "SwiftLint encontrado, ejecutando lint..."
    swiftlint
else
    echo "error: SwiftLint no está instalado. Instálalo con 'brew install swiftlint'"
    exit 1
fi