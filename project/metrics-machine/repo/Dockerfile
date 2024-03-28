FROM python:3.9

ARG REPO_URL
ARG SNAPSHOTS_DIR
ENV REPO_URL=${REPO_URL}
ENV SNAPSHOTS_DIR=${SNAPSHOTS_DIR}
ENV REPO_DIR="/app/repository"

WORKDIR /app

RUN pip install pandas gitpython

# Clone the repository
RUN apt-get update && apt-get install -y git
RUN git clone ${REPO_URL} /app/repository

# Copy Python scripts to the container
COPY scripts /app/scripts

RUN mkdir -p ${SNAPSHOTS_DIR}

ENTRYPOINT ["python", "scripts/startup.py"]