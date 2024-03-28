FROM python:3.9

ARG SNAPSHOTS_DIR
ENV SNAPSHOTS_DIR=${SNAPSHOTS_DIR}

ARG METRICS_DIR
ENV METRICS_DIR=${METRICS_DIR}

WORKDIR /app

# Install the 'metrixpp' package
RUN pip install metrixpp

# Copy Python scripts to the container
COPY scripts /app/scripts

CMD ["tail", "-f", "/dev/null"]