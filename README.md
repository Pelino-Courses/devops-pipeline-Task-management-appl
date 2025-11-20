# DevOps Pipeline Task Management Application

A comprehensive Task Management Application built with a modern DevOps pipeline, demonstrating Infrastructure as Code, Configuration Management, CI/CD, and DevSecOps practices.

## 🚀 Features
- **Task Management**: Create, read, update, and delete tasks.
- **Modern UI**: Built with React and a custom design system.
- **Robust Backend**: Node.js/Express API with PostgreSQL database.
- **Infrastructure as Code**: Azure resources provisioned via Terraform.
- **Configuration Management**: Server configuration automated with Ansible.
- **CI/CD**: Full automation with GitHub Actions.
- **Security**: Integrated SAST, DAST, and dependency scanning.

## 🛠️ Tech Stack
- **Frontend**: React, Vite, CSS Modules
- **Backend**: Node.js, Express, Sequelize
- **Database**: PostgreSQL
- **Infrastructure**: Terraform, Azure
- **Config Management**: Ansible, Docker
- **CI/CD**: GitHub Actions

## 📚 Documentation
- [Deployment Guide](docs/DEPLOYMENT.md): How to provision and deploy.
- [System Architecture](docs/ARCHITECTURE.md): Detailed system design and diagrams.
- [Security Overview](docs/SECURITY.md): Security measures and compliance.

## 🏁 Getting Started (Local Development)

### Prerequisites
- Node.js (v18+)
- Docker & Docker Compose

### Installation
1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd devops-pipeline-Task-management-application
   ```

2. Start the application using Docker Compose:
   ```bash
   docker-compose up --build
   ```

3. Access the application:
   - Frontend: `http://localhost:5173`
   - Backend: `http://localhost:3000`

## 🧪 Running Tests
```bash
# Backend
cd backend
npm test

# Frontend
cd frontend
npm test
```

## 🤝 Contributing
Please read the [Security Policy](docs/SECURITY.md) before contributing.