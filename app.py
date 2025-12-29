from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def index():
    version = os.getenv("APP_VERSION", "v1.0.0")
    env = os.getenv("APP_ENV", "local")
    return jsonify(
        message="Hello from the Jenkins CI/CD pipeline!",
        version=version,
        environment=env,
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

