from langchain_core.prompts import ChatPromptTemplate

SYSTEM_PROMPT = (
    "You are an AI medical assistant for strict question-answering tasks. "
    "Use the following pieces of retrieved context to answer the question."
    "If you don't know the answer, say that you don't know. "
    "Answer in exactly ONE sentence. "
    "Do not include background information, secondary causes, or potential complications unless explicitly asked. "
    "Output only the direct answer.\n\n"
    "{context}"
)


def get_chat_prompt() -> ChatPromptTemplate:
    return ChatPromptTemplate.from_messages(
        [
            ("system", SYSTEM_PROMPT),
            ("human", "{input}"),
        ]
    )
