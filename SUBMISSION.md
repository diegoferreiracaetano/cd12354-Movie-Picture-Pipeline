# Submission Evidence

Deployed via the `backend-cd.yaml` / `frontend-cd.yaml` workflows in this repo, cluster provisioned by `setup/terraform`.

## Backend

Working URL (LoadBalancer, only valid while the EKS cluster is up):
`http://af50913de83164c378fc35dfc084d759-906327990.us-east-1.elb.amazonaws.com/movies`

Response:
```json
{"movies":[{"id":"123","title":"Top Gun: Maverick"},{"id":"456","title":"Sonic the Hedgehog"},{"id":"789","title":"A Quiet Place"}]}
```

## Frontend

Working URL (LoadBalancer, only valid while the EKS cluster is up):
`http://adba5ebc0577046799a965807a17d07b-1848545007.us-east-1.elb.amazonaws.com`

Screenshot: [screenshots/frontend-movie-list.png](screenshots/frontend-movie-list.png) — shows the movie list rendered from the live backend API, confirming `REACT_APP_MOVIE_API_URL` was correctly injected at build time.
