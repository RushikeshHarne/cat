# 🚀 Docker + MySQL + Flask Setup

This project demonstrates how to build a simple Dockerized web app using:

- ✅ A Flask backend (Docker image pulled from Docker Hub)
- 🐬 A MySQL database that initializes with a custom `init.sql` file
- ⚙️ Docker Compose to run both containers together

---

📦 Requirements
Docker
Docker Compose
A Docker Hub account (to push/pull images)

🐳 Start the Project
# Run Everything with Docker Compose
docker-compose up --build

Flask app: http://localhost:4000
MySQL: localhost:3306 (inside network)

⚙️ Change Default Port (Optional)
If you want to change the app port, update this part in docker-compose.yml

🧼 Stop & Clean Containers
docker-compose down

🤝 Contributing
Feel free to fork this repo, open issues, or make pull requests to improve it!


