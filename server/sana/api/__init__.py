import logging
import sys

from flask import Flask
from langchain_core.runnables import Runnable

from sana.api.routes import api_bp
from sana.config import settings

logger = logging.getLogger(__name__)


def create_app(rag_chain: Runnable | None = None) -> Flask:
    """Application factory. Pass `rag_chain` to inject a stub (e.g. in tests)."""
    if rag_chain is None:
        missing = settings.missing_keys("pinecone_api_key", "groq_api_key")
        if missing:
            logger.critical(f"Critical API keys are missing ({', '.join(missing)}). Check your .env file.")
            sys.exit(1)

        from sana.rag import build_rag_chain

        rag_chain = build_rag_chain()

    app = Flask(__name__)
    app.extensions["rag_chain"] = rag_chain
    app.register_blueprint(api_bp)
    return app
