from langchain_core.embeddings import Embeddings
from langchain_core.vectorstores import VectorStoreRetriever
from langchain_pinecone import PineconeVectorStore

from sana.config import settings


def get_retriever(embeddings: Embeddings) -> VectorStoreRetriever:
    docsearch = PineconeVectorStore.from_existing_index(
        index_name=settings.pinecone_index_name,
        embedding=embeddings,
    )
    return docsearch.as_retriever(
        search_type="similarity",
        search_kwargs={"k": settings.retriever_k},
    )
