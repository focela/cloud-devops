
# 🦊 GitLab Setup with Docker Compose

This repository contains the necessary Docker Compose configuration to set up GitLab, Redis, and PostgreSQL using Docker Compose.

### 📂 Directory Structure
```
├── compose/
│   ├── gitlab/
│   │   ├── gitlab.env.example  # Example environment file for reference
│   │   ├── compose.yaml        # Docker Compose configuration for GitLab
│   │   └── README.md           # This README file
```

### ✅ Prerequisites

- 🐳 **Docker installed** on your local machine: [Install Docker](https://docs.docker.com/get-docker/)
- 🛠️ **Docker Compose installed**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- 📥 **Clone this repository** to your local machine.

### 🚀 Getting Started

1. **Clone the repository**:
   ```bash
   git clone git@github.com:focela/devops-infra.git
   cd compose/gitlab
   ```

2. **Create the environment file**:
   Copy the `.env.example` file and create your own `gitlab.env` file with the appropriate values.
   ```bash
   cp gitlab.env.example gitlab.env
   ```

3. **Adjust environment variables**:
   Edit the `gitlab.env` file with the necessary configuration values, especially the following:
   - `DB_USER`, `DB_PASS`, `DB_NAME`: PostgreSQL database configuration.
   - `GITLAB_ROOT_PASSWORD`: Set the initial root password for GitLab.
   - `GITLAB_HOST`: Set the host for accessing GitLab.

4. **Run the services**:
   Start the GitLab, PostgreSQL, and Redis services using Docker Compose.
   ```bash
   docker compose -f compose.yaml up -d
   ```

   This will launch:
   - 🌐 GitLab on `http://localhost:10080`
   - 🔐 SSH access to GitLab via port `10022`

5. **Access GitLab**:
   Open your browser and visit `http://localhost:10080`. Log in using the root user and the password set in `gitlab.env`.

### ⚙️ Configuration Details

- **PostgreSQL**:
  - The PostgreSQL database is configured using the values in `gitlab.env`. You can adjust these settings for your environment as needed.

- **Redis**:
  - Redis is used by GitLab for caching. Its configuration is also managed in `gitlab.env`.

- **Volumes**:
  - The data for PostgreSQL, Redis, and GitLab is stored in persistent volumes:
    - 🗃️ PostgreSQL: `/home/data/gitlab/postgresql`
    - 🗃️ Redis: `/home/data/gitlab/redis`
    - 🗃️ GitLab: `/home/data/gitlab/data`

### 🔧 Environment Variables

- **gitlab.env**:
  The `gitlab.env` file contains all the configuration parameters for GitLab, PostgreSQL, and Redis. Refer to the `gitlab.env.example` file for a full list of variables and descriptions.

### 🗄️ Backup and Restore

You can configure GitLab's backup schedule in the `gitlab.env` file:
- `GITLAB_BACKUP_SCHEDULE`: Set the backup schedule (e.g., `daily`).
- `GITLAB_BACKUP_TIME`: Set the time of the day when backups should run (e.g., `01:00`).

To manually trigger a backup, you can run the following command inside the GitLab container:
```bash
docker exec -t gitlab gitlab-backup create
```

### 🛠️ Troubleshooting

- 📝 **To check the logs of the GitLab container**, use the following command:
  ```bash
  docker logs gitlab
  ```

- 🔄 **To restart the services**:
  ```bash
  docker compose restart
  ```

### 📝 License

This project is licensed under the MIT License. See the [LICENSE](../../LICENSE) file for more details.
