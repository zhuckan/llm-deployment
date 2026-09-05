FROM ghcr.io/ggml-org/llama.cpp:server

USER root
RUN mkdir -p /models
COPY qwen2.5-0.5b-instruct-q4_k_m.gguf /models/
RUN chmod 644 /models/qwen2.5-0.5b-instruct-q4_k_m.gguf

EXPOSE 8080
CMD ["-m", "/models/qwen2.5-0.5b-instruct-q4_k_m.gguf", "--host", "0.0.0.0", "--port", "8080"]
