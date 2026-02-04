FROM python:3.11

# Copy your Dagster project
COPY . /

# This makes sure that logs show up immediately instead of being buffered
ENV PYTHONUNBUFFERED=1

#RUN pip install --upgrade pip

# Install dagster and any other dependencies your project requires
RUN \
    pip install \
        dagster \
        dagster-postgres \
        dagster-k8s \
        pandas

WORKDIR /iris_analysis/

# Expose the gRPC port (not 80 - that's for the webserver)
EXPOSE 3030

# Start the Dagster gRPC server (NOT the webserver)
CMD ["dagster", "api", "grpc", "--python-file", "/iris_analysis/definitions.py", "--host", "0.0.0.0", "--port", "3030"]
