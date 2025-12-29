
# Jenkins CI/CD DevOps Demo

End-to-end CI/CD pipeline using **Jenkins** to build, test, containerize, and deploy a Python Flask web application to separate **staging** and **production** environments with Docker and SSH-based automation.

---

## 🔧 Tech Stack

- **CI/CD:** Jenkins (Declarative Pipeline)
- **Version Control:** Git (GitHub / GitLab / Bitbucket)
- **Language:** Python (Flask)
- **Containerization:** Docker
- **Orchestration:** Docker Compose (staging & production)
- **Deployment:** SSH-based remote deployment scripts
- **Testing:** pytest

---

## 🎯 What This Project Demonstrates

- Jenkins pipeline triggered on Git changes
- Automated steps:
  - Checkout
  - Install dependencies
  - Run unit tests
  - Build Docker image
  - Push image to Docker registry
  - Deploy to staging via Docker Compose
  - Manual approval gate
  - Deploy to production
- Separation of concerns between **dev**, **staging**, and **production** environments
- Realistic DevOps workflow with promotion and rollback capability

---

## 🗂️ Repository Structure

```text
app/                  # Flask application and tests
  app.py
  requirements.txt
  tests/
    test_app.py

scripts/              # Deployment scripts
  deploy_staging.sh
  deploy_prod.sh

Dockerfile            # Container image definition
docker-compose.staging.yml  # Staging environment
docker-compose.prod.yml     # Production environment
Jenkinsfile           # Jenkins Declarative Pipeline
README.md



#Local Development
# Clone the repo
git clone https://github.com/<your-username>/jenkins-cicd-devops-demo.git
cd jenkins-cicd-devops-demo

# Run the app locally (without Docker)
cd app
python -m venv venv
. venv/bin/activate
pip install -r requirements.txt
python app.py


#Running Test

cd app
. venv/bin/activate
pytest

#Running with Docker
# From repo root
docker build -t jenkins-cicd-demo:local .
docker run -p 5000:5000 jenkins-cicd-demo:local
Visit: http://localhost:5000

