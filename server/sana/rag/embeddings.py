from langchain_huggingface import HuggingFaceEmbeddings

from sana.config import settings


def download_hugging_face_embeddings() -> HuggingFaceEmbeddings:
    return HuggingFaceEmbeddings(model_name=settings.embedding_model_name)
