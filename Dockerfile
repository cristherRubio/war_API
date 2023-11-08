# syntax=docker/dockerfile:1

FROM python:3.11-alpine as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /usr/src/app

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc mysql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip install --upgrade pip \
    && pip install poetry \
    && poetry config virtualenvs.create false

# Copy the source code into the container.
COPY . .

RUN poetry install

EXPOSE 8000

CMD python manage.py runserver 0.0.0.0:8000
