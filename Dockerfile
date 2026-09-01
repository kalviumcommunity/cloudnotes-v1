# ============================
# Stage 1: Build
# ============================
FROM python:3.12-alpine AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# ============================
# Stage 2: Runtime
# ============================
FROM python:3.12-alpine

WORKDIR /app

# Copy installed dependencies from builder
COPY --from=builder /install /usr/local

# Copy application code
COPY app.py .
COPY api ./api
COPY utils ./utils
COPY templates ./templates
COPY static ./static

# Create necessary directories and set permissions
RUN mkdir -p uploads database && \
    chown -R nobody:nobody /app

# Exclude build tools (pip) and package managers (apk)
RUN rm -rf /usr/local/bin/pip* /usr/local/bin/easy_install* && \
    rm -rf /sbin/apk /lib/apk /usr/share/apk /var/cache/apk/*

# Run as non-root user
USER nobody

EXPOSE 5000

CMD ["python", "app.py"]
