# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# build-time tokens for gated downloads — never baked into final image.
# pass via: docker build --build-arg HF_TOKEN=$HF_TOKEN ...
ARG HF_TOKEN=""

# download models into comfyui
RUN for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors' --relative-path models/vae --filename 'qwen_image_vae.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; echo "model-download attempt $i failed; retrying in $((i*10))s" >&2; sleep $((i*10)); done
RUN for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors' --relative-path models/text_encoders --filename 'qwen_2.5_vl_7b_fp8_scaled.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; echo "model-download attempt $i failed; retrying in $((i*10))s" >&2; sleep $((i*10)); done
RUN for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2511_bf16.safetensors' --relative-path models/diffusion_models --filename 'qwen_image_edit_2511_bf16.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; echo "model-download attempt $i failed; retrying in $((i*10))s" >&2; sleep $((i*10)); done
RUN for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/prithivMLmods/Qwen-Image-Edit-2511-Unblur-Upscale/resolve/main/Qwen-Image-Edit-Unblur-Upscale_20.safetensors' --relative-path models/loras --filename 'Qwen/Qwen-Image-Edit-Unblur-Upscale_20.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; echo "model-download attempt $i failed; retrying in $((i*10))s" >&2; sleep $((i*10)); done
RUN for i in 1 2 3 4 5; do HF_TOKEN=$HF_TOKEN comfy model download --url 'https://huggingface.co/Drockdgd/SEXGOD_FemaleNudity_QwenEdit_2511_v2/resolve/main/SEXGOD_FemaleNudity_QwenEdit_2511_v2.safetensors' --relative-path models/loras --filename 'Qwen/SEXGOD_FemaleNudity_QwenEdit_2511_v2.safetensors' && break; if [ $i -eq 5 ]; then echo "model-download failed after 5 attempts" >&2; exit 1; fi; echo "model-download attempt $i failed; retrying in $((i*10))s" >&2; sleep $((i*10)); done

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/

# user-provided inputs override the auto-generated placeholders above.
RUN wget --progress=dot:giga -O '/comfyui/input/ComfyUI_00034_.png_202605060031.jpeg' "https://cool-anteater-319.convex.cloud/api/storage/2f5badf3-1276-4367-9518-56f92d624c40"
