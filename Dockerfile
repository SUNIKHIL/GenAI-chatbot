## Using slim image because it's lightweight (smaller size)
FROM python:3.10-slim 

## This sets the working directory inside the container
WORKDIR /app

## Install required system packages
RUN apt-get update && apt-get install -y \
    build-essential \        ## Needed to compile some Python packages
    libgl1 \                 ## Required for OpenCV / image related libs
    libglib2.0-0 && \        ## Dependency for some ML / GUI libs
    rm -rf /var/lib/apt/lists/*   ## Clean cache to reduce image size

## Upgrade pip to latest version
RUN pip install --upgrade pip 

## Copy everything from current folder into /app inside container
COPY . /app/

## Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

## Tell Docker that app runs on port 8501 (Streamlit default)
EXPOSE 8501

## Command to start Streamlit when container runs
CMD ["streamlit","run","app.py","--server.port=8501","--server.address=0.0.0.0"]