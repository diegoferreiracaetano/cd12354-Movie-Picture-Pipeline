# Submission Evidence

Deployed via the `backend-cd.yaml` / `frontend-cd.yaml` workflows in this repo, cluster provisioned by `setup/terraform`.

## GitHub Actions runs (all four workflows, successful)

- Frontend Continuous Integration: [screenshots/frontend-ci-success.png](screenshots/frontend-ci-success.png)
- Backend Continuous Integration: [screenshots/backend-ci-success.png](screenshots/backend-ci-success.png)
- Frontend Continuous Deployment: [screenshots/frontend-cd-success.png](screenshots/frontend-cd-success.png)
- Backend Continuous Deployment: [screenshots/backend-cd-success.png](screenshots/backend-cd-success.png)

## Backend

Working URL (LoadBalancer, only valid while the EKS cluster is up):
`http://af50913de83164c378fc35dfc084d759-906327990.us-east-1.elb.amazonaws.com/movies`

Response:
```json
{"movies":[{"id":"123","title":"Top Gun: Maverick"},{"id":"456","title":"Sonic the Hedgehog"},{"id":"789","title":"A Quiet Place"}]}
```

Screenshot: [screenshots/backend-movies-endpoint.png](screenshots/backend-movies-endpoint.png)

## Frontend

Working URL (LoadBalancer, only valid while the EKS cluster is up):
`http://adba5ebc0577046799a965807a17d07b-1848545007.us-east-1.elb.amazonaws.com`

Screenshot: [screenshots/frontend-movie-list.png](screenshots/frontend-movie-list.png) — shows the movie list rendered from the live backend API, confirming `REACT_APP_MOVIE_API_URL` was correctly injected at build time.

## Rubric compliance checklist

**Frontend CI (`frontend-ci.yaml`)**
- [x] Named "Frontend Continuous Integration"
- [x] Triggers on `pull_request` to `main`, scoped to `starter/frontend/**` changes
- [x] Can be triggered manually via `workflow_dispatch`
- [x] `lint` and `test` jobs run in parallel, each: checkout → setup NodeJS → restore cache → install deps → run command
- [x] `build` job runs only after `lint` and `test` succeed (`needs: [lint, test]`), and includes `npm run test` as its own step (per rubric) plus a `docker build` step to actually build the image

**Backend CI (`backend-ci.yaml`)**
- [x] Named "Backend Continuous Integration"
- [x] Triggers on `pull_request` to `main`, scoped to `starter/backend/**` changes
- [x] Can be triggered manually via `workflow_dispatch`
- [x] `lint` and `test` jobs run in parallel
- [x] `build` job runs only after `lint` and `test` succeed, and builds the Docker image

**Frontend CD (`frontend-cd.yaml`)**
- [x] Named "Frontend Continuous Deployment"
- [x] Triggers on `push` to `main`, scoped to `starter/frontend/**` changes
- [x] Can be triggered manually via `workflow_dispatch`
- [x] `lint` and `test` steps run and pass
- [x] `build` job runs only after `lint`/`test` succeed, builds with `--build-arg REACT_APP_MOVIE_API_URL`, and tags the image with the git SHA
- [x] Logs in to ECR via `aws-actions/amazon-ecr-login`, credentials sourced from GitHub Secrets (no AWS credentials hardcoded anywhere)
- [x] Pushes the image to ECR
- [x] `deploy` job applies the Kubernetes manifests (via `kustomize` + `kubectl apply`) to the EKS cluster

**Backend CD (`backend-cd.yaml`)**
- [x] Named "Backend Continuous Deployment"
- [x] Triggers on `push` to `main`, scoped to `starter/backend/**` changes
- [x] Can be triggered manually via `workflow_dispatch`
- [x] Same lint/test/build/deploy structure as frontend CD, tagged with the git SHA
- [x] Logs in to ECR via `aws-actions/amazon-ecr-login`, credentials sourced from GitHub Secrets
- [x] `deploy` job applies the Kubernetes manifests to the EKS cluster

**End-to-end verification**
- [x] Both CD pipelines ran successfully and pushed images to ECR
- [x] Both apps are running on the EKS cluster (`kubectl get pods` / `kubectl get svc` confirmed)
- [x] Backend `/movies` endpoint returns the expected JSON (see screenshot above)
- [x] Frontend renders the movie list fetched from the backend, confirming the injected API URL works end-to-end (see screenshot above)
