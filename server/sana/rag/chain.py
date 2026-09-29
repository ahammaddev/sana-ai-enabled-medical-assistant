import logging

from langchain.chains import create_retrieval_chain
from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain_core.runnables import Runnable

from sana.config import settings
from sana.rag.embeddings import download_hugging_face_embeddings
from sana.rag.llm import get_llm
from sana.rag.prompts import get_chat_prompt
from sana.rag.vectorstore import get_retriever

logger = logging.getLogger(__name__)


def build_rag_chain() -> Runnable:
    logger.info("Initializing Embeddings and Vector Store...")
    retriever = get_retriever(download_hugging_face_embeddings())

    logger.info(f"Initializing Groq LLM Client with model: {settings.groq_model_id}...")
    question_answer_chain = create_stuff_documents_chain(get_llm(), get_chat_prompt())

    return create_retrieval_chain(retriever, question_answer_chain)
