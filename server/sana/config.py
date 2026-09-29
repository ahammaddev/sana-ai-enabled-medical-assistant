import os
from dataclasses import dataclass

from dotenv import load_dotenv

load_dotenv()


@dataclass(frozen=True)
class Settings:
    # API keys
    pinecone_api_key: str | None = os.getenv("PINECONE_API_KEY")
    groq_api_key: str | None = os.getenv("GROQ_API_KEY")

    # LLM
    groq_model_id: str = os.getenv("GROQ_MODEL_ID", "openai/gpt-oss-120b")
    llm_temperature: float = 0.0
    llm_max_tokens: int = 256

    # Embeddings
    embedding_model_name: str = "sentence-transformers/all-MiniLM-L6-v2"

    # Vector store
    pinecone_index_name: str = os.getenv("PINECONE_INDEX_NAME", "medical-chatbot-faisal")
    retriever_k: int = 3

    # Server
    host: str = os.getenv("HOST", "0.0.0.0")
    port: int = int(os.getenv("PORT", "7860"))

    def missing_keys(self, *names: str) -> list[str]:
        return [name for name in names if not getattr(self, name)]


settings = Settings()
