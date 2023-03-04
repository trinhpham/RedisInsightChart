This provide a CI wrapper to keep building latest release of RedisInsight.
Then help you to deploy it via Helm chart

# Usage
```bash
helm repo add ric https://trinhpham.github.io/RedisInsightChart
helm -n your-namespace upgrade --install --create-namespace redis-insight ric/RedisInsight
```
