#!/bin/bash
# Hotel Management System - Build and Run Script for Linux/Mac

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     HOTEL MANAGEMENT SYSTEM - BUILD AND RUN SCRIPT         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

JAVA_SRC="src"
LIB_DIR="lib"
MYSQL_JAR="mysql-connector-java-8.0.33.jar"

# Check if MySQL driver exists
if [ ! -f "$LIB_DIR/$MYSQL_JAR" ]; then
    echo ""
    echo "✗ ERROR: MySQL JDBC driver not found!"
    echo ""
    echo "Please download mysql-connector-java from:"
    echo "https://dev.mysql.com/downloads/connector/j/"
    echo ""
    echo "Extract and place the JAR file in the 'lib' folder"
    echo ""
    exit 1
fi

echo "✓ MySQL JDBC Driver found"
echo ""

# Compile
echo "Compiling Java files..."
javac -cp "$LIB_DIR/$MYSQL_JAR" "$JAVA_SRC"/*.java -d "$JAVA_SRC"

if [ $? -ne 0 ]; then
    echo ""
    echo "✗ Compilation failed!"
    echo ""
    exit 1
fi

echo "✓ Compilation successful!"
echo ""

# Run
echo "Starting Hotel Management Application..."
echo ""
java -cp "$LIB_DIR/$MYSQL_JAR:$JAVA_SRC" HotelManagementApp
