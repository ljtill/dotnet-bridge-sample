#!/usr/bin/env bash

set -e

echo "Updating workloads cache..."
sudo env "PATH=$PATH" dotnet workload update

echo "Installing dotnet diagnostics..."
dotnet tool install -g dotnet-counters
dotnet tool install -g dotnet-coverage
dotnet tool install -g dotnet-dump
dotnet tool install -g dotnet-gcdump
dotnet tool install -g dotnet-monitor
dotnet tool install -g dotnet-trace
dotnet tool install -g dotnet-stack
dotnet tool install -g dotnet-symbol
dotnet tool install -g dotnet-sos
dotnet tool install -g dotnet-dsrouter
