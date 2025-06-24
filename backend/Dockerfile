FROM python:3.10

# ENV PYTHONUNBUFFERED=1

# WORKDIR /app/

# # Install uv
# # Ref: https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
# COPY --from=ghcr.io/astral-sh/uv:0.5.11 /uv /uvx /bin/

# # Place executables in the environment at the front of the path
# # Ref: https://docs.astral.sh/uv/guides/integration/docker/#using-the-environment
# ENV PATH="/app/.venv/bin:$PATH"

# # Compile bytecode
# # Ref: https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
# ENV UV_COMPILE_BYTECODE=1

# # uv Cache
# # Ref: https://docs.astral.sh/uv/guides/integration/docker/#caching
# ENV UV_LINK_MODE=copy

# # Install dependencies
# # Ref: https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
# RUN --mount=type=cache,target=/root/.cache/uv \
#     --mount=type=bind,source=uv.lock,target=uv.lock \
#     --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
#     uv sync --frozen --no-install-project

# ENV PYTHONPATH=/app

# COPY ./scripts /app/scripts

# COPY ./pyproject.toml ./uv.lock ./alembic.ini /app/

# COPY ./app /app/app

# # Sync the project
# # Ref: https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
# RUN --mount=type=cache,target=/root/.cache/uv \
#     uv sync

EXPOSE 8080

# For debugging: Skip prestart script to test if the app itself works
# CMD ["fastapi", "run", "app/main.py", "--host", "0.0.0.0", "--port", "8080"]

# Production CMD with prestart script
CMD ["python", "-c", "import time; print('Container started successfully!', flush=True); time.sleep(10); print('Python and container work!', flush=True); import http.server; import socketserver; PORT = 8080; Handler = http.server.SimpleHTTPRequestHandler; with socketserver.TCPServer(('', PORT), Handler) as httpd: print(f'Server running on port {PORT}', flush=True); httpd.serve_forever()"]


# CMD ["bash", "-c", "echo 'Starting container...' && python -c 'print(\"Python works\")' && echo 'Testing imports...' && python -c 'from app.main import app; print(\"Import successful\")' && echo 'Starting FastAPI...' && fastapi run app/main.py --host 0.0.0.0 --port 8080"]
# CMD ["bash", "-c", "bash scripts/prestart.sh && fastapi run app/main.py --host 0.0.0.0 --port 8080"]
# CMD ["fastapi", "run", "app/main.py", "--host", "0.0.0.0", "--port", "8080"]