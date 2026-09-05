# LLM Deployment with llama.cpp on Kubernetes (CPU)

This project demonstrates deploying a quantized LLM (Qwen2.5-0.5B-Instruct-GGUF) as a Kubernetes service using llama.cpp. It also includes a SeldonDeployment manifest (not applied due to lack of arm64 images).

## What is done
- Minikube cluster with 4 CPUs and 4GB RAM
- Downloaded Qwen2.5-0.5B-Instruct-GGUF (Q4_K_M quantization)
- Built Docker image based on llama.cpp server
- Deployed image to Kubernetes using Deployment and Service
- Tested inference via HTTP API (port-forward)
- Prepared SeldonDeployment manifest for future use

## Tech Stack
Kubernetes (Minikube) · Docker · llama.cpp · Qwen2.5-0.5B · GGUF

## Repository Structure
- `Dockerfile` — image for llama.cpp server with model
- `deployment.yaml` — Kubernetes Deployment and Service
- `seldondeployment.yaml` — example SeldonDeployment manifest
- `README.md` — this file

## How to run
1. Start Minikube: `minikube start --cpus 4 --memory 4096`
2. Build image: `docker build -t llama-llm:local .`
3. Load image into Minikube: `minikube image load llama-llm:local`
4. Apply deployment: `kubectl apply -f deployment.yaml`
5. Forward port: `kubectl port-forward pod/llama-llm-<pod-id> 8081:8080`
6. Send test request: `curl -X POST http://localhost:8081/v1/completions -H "Content-Type: application/json" -d '{"prompt":"What is the capital of France?","max_tokens":50}'`

## GPU and Seldon Core (Theory)
- NVIDIA GPU is not available on this MacBook, so NVIDIA drivers/CUDA/Device Plugin not installed.
- Seldon Core images for arm64 are missing in public registries; hence SeldonDeployment is prepared but not applied.
- For full GPU support, use x86_64 Linux with NVIDIA GPU.
