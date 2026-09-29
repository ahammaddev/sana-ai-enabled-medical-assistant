import logging

from flask import Blueprint, current_app, jsonify, request

from sana import __version__

logger = logging.getLogger(__name__)

api_bp = Blueprint("api", __name__)


@api_bp.route("/", methods=["GET"])
def health_check():
    return jsonify({
        "status": "online",
        "service": "Sana Medical NLP API",
        "version": __version__,
    }), 200


@api_bp.route("/api/chat", methods=["POST"])
def chat():
    try:
        data = request.get_json(silent=True)

        if not data or "message" not in data:
            logger.warning("Invalid request: Missing 'message' payload.")
            return jsonify({
                "status": "error",
                "message": "Bad Request: Missing 'message' in JSON body."
            }), 400

        user_message = data["message"]
        logger.info(f"Processing query: {user_message}")

        rag_chain = current_app.extensions["rag_chain"]
        response = rag_chain.invoke({"input": user_message})

        answer = response.get("answer", "I am unable to process that request at the moment.")

        return jsonify({
            "status": "success",
            "message": answer
        }), 200

    except Exception as e:
        logger.error(f"Internal Server Error during chat invocation: {str(e)}", exc_info=True)
        return jsonify({
            "status": "error",
            "message": "The assistant is currently taking a nap. Please try again later!"
        }), 500
