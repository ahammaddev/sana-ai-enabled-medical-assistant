"""Entrypoint for the Sana API (used by the Dockerfile / Hugging Face Space)."""
from sana.api import create_app
from sana.config import settings
from sana.logger import configure_logging

configure_logging()
app = create_app()

if __name__ == "__main__":
    app.run(host=settings.host, port=settings.port, debug=False)
