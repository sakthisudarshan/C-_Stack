#!/usr/bin/env bash
# ==============================================================================
# 9-Block Platform - White-Box Quality Gates & Metrics Runner (Bash)
# ==============================================================================
set -e

echo "=== 9-BLOCK TALENT MATRIX: WHITE-BOX METRICS RUNNER ==="

echo "1. Running Tests & Coverage..."
dotnet test NineBlock.sln --collect:"XPlat Code Coverage"

echo "2. Running Code Duplication (jscpd)..."
npx jscpd backend/Services/ frontend/src/utils/ --threshold 0 || true

echo "3. Running Complexity (lizard)..."
if command -v lizard &> /dev/null; then
    lizard backend/Services/ frontend/src/utils/ -l csharp,javascript --CCN 15 || true
fi

echo "4. Running C# Code Style (dotnet format)..."
dotnet format --verify-no-changes || true

echo "5. Checking Vulnerable Packages..."
dotnet list backend/NineBlock.csproj package --vulnerable || true

echo "=== ALL WHITE-BOX CHECKS COMPLETED ==="
