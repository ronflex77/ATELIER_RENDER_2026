from flask import Flask, jsonify
import os
from flask_cors import CORS

app = Flask(__name__)
# Autorise ton frontend React à appeler cette API
CORS(app)

@app.route("/")
def home():
    return "Ceci est le site web pour afficher sur Render"

@app.route("/health")
def health():
    return jsonify({"status": "Tout est ok"})

@app.route("/info")
def info():
    return jsonify({
        "app": "Flask Render",
        "student": "lucas",
        "version": "v1",
        "env": os.getenv("ENV", "production")
    })

@app.route("/env")
def env():
    return jsonify({"env": os.getenv("ENV", "not-set")})

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=port)
