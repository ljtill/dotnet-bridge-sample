# Contoso

```bash
kind create cluster && make build && make upload && make apply && make list
```

## Tools

- [Bridge to Kubernetes](https://learn.microsoft.com/en-us/visualstudio/bridge/)
- [ProcDump](https://github.com/Sysinternals/ProcDump-for-Linux/)

## Scenarios

1. Review repository structure
2. Bridge to Kubernetes
  1. Create cluster - `kind create cluster`
  2. Check resources - `make watch`
  3. Build image - `make build`
  4. Upload image - `make upload`
  5. Apply manifests - `make apply`
  6. Check resources - `make list`
  7. Follow logs - `make logs`
  7. Configure Bridge - Prompt
3. .NET Monitor
  1. Review Kubernetes Manifests
  2. Showcase the endpoints
