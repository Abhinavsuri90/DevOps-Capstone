# Demo: presentation and live demo

**Author:** Abhinav Suri (24BCS10282) · SpendWise, DevOps Final Capstone (rubric M10)

This folder holds the presentation material that the capstone brief asks for in `demo/`.

| File | What it is |
| --- | --- |
| [SpendWise-DevOps-Capstone.pdf](SpendWise-DevOps-Capstone.pdf) | The presentation: 18 slides, 16:9, PDF. Also on [Google Drive](https://drive.google.com/file/d/1MOUyH8X_VMM7THeL8x-YOiapEYEuX67m/view?usp=sharing) |
| [../DEMO.md](../DEMO.md) | The 5-minute live demo script: what to show and what to say at each step |

## What the slides cover

The slides follow the order the brief asks every student to demonstrate.

| Slides | Topic |
| --- | --- |
| 1–2 | SpendWise, and the path of one change from a commit to the cluster |
| 3–6 | M1 application · M2 tests (9 passed, 97% coverage) · M3 Git and GitHub · M4 Docker images and Compose |
| 7–9 | M5 CI/CD pipeline (12 jobs) · M6 DevSecOps gates and Trivy (0 HIGH/CRITICAL) · GHCR images tagged with the commit SHA |
| 10–11 | M7 Terraform: VPC with 2 public subnets and EKS with a node group, plan 18 / destroy 18, and the AWS Console |
| 12–15 | M8 Kubernetes and Helm · Ingress and the HPA · M9 Prometheus and Grafana · GitOps with Argo CD |
| 16–18 | The five troubleshooting faults · the live demo · summary of M1–M10 |

## Live demo (M10): commit a change, watch the pipeline, see the deployment update

```bash
minikube start
make mode-gitops        # Argo CD on (an 8 GB laptop cannot run every tool at full size at once)
make status             # Argo CD Synced/Healthy, Pods Running
make port-forward       # app on http://spendwise.local:18080, Argo CD on http://localhost:8081
```

Then change the subtitle in `frontend/src/App.jsx`, commit and push. The pipeline runs on GitHub Actions, commits the new image tag (`gitops: deploy spendwise <sha>`), and Argo CD rolls it out. The footer of the app shows the new version. A recorded rehearsal with timings is in the [README](../README.md#live-demo-m10-commit--pipeline--deployment-update-recorded).
