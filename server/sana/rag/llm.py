from langchain_groq import ChatGroq

from sana.config import settings


def get_llm() -> ChatGroq:
    return ChatGroq(
        api_key=settings.groq_api_key,
        model=settings.groq_model_id,
        temperature=settings.llm_temperature,
        max_tokens=settings.llm_max_tokens,
    )
