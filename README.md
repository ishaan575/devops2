# FastAPI Continuous Delivery with GitHub Actions

This project demonstrates Continuous Delivery by automating the creation and deployment of a Dockerized FastAPI application using GitHub Actions.

## Project Overview
This project involves setting up a FastAPI server, containerizing it using Docker, and automating the build and deployment process with GitHub Actions.

## Setup and Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/<your-username>/<your-repo>.git
   cd <your-repo>
   ```
2. Create a virtual environment and activate it:
   ```sh
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. Install dependencies:
   ```sh
   pip install -r requirements.txt
   ```

## Running the Application Locally
Run the FastAPI application using:
```sh
uvicorn main:app --host 0.0.0.0 --port 8000
```
The server will be available at `http://localhost:8000`.

## Containerizing the Application
1. Build the Docker image:
   ```sh
   docker build -t <your-dockerhub-username>/fastapi-app .
   ```
2. Run the Docker container:
   ```sh
   docker run -p 8000:8000 <your-dockerhub-username>/fastapi-app
   ```

## GitHub Actions Workflow
A GitHub Actions workflow is created in `.github/workflows/DockerBuild.yml`. The workflow:
- Triggers on `push` events.
- Checks out the repository.
- Logs into Docker Hub using a secret token.
- Builds and pushes the Docker image to Docker Hub.

### Expected Workflow File (DockerBuild.yml):
```yaml
name: Docker image build

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Build & Push Image
        run: |
          echo ${{ secrets.DOCKERTOKEN }} | docker login -u "<your-dockerhub-username>" --password-stdin
          docker build -t <your-dockerhub-username>/fastapi-app:latest .
          docker push <your-dockerhub-username>/fastapi-app:latest
```

## Setting Up Docker Token and GitHub Secrets
### Generating a Docker Token
1. Go to [Docker Hub](https://hub.docker.com/) and sign in.
2. Navigate to **Account Settings** → **Security** → **Access Tokens**.
3. Click **Generate Token** and copy the token.

### Adding Secrets to GitHub
1. Go to your GitHub repository.
2. Navigate to **Settings** → **Secrets and variables** → **Actions**.
3. Click **New repository secret** and add:
   - Name: `DOCKERTOKEN`
   - Value: *(Paste the Docker token here)*
