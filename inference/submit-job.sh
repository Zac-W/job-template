#!/bin/bash
TS=$(date -u '+%Y%m%d%H%M%S')

export JOB_NAME=${JOB_NAME:-inference-job-$TS}
export ADAPTER_NAME=${ADAPTER_NAME:-demo}
export MODEL_NAME=${MODEL_NAME:-meta-llama/Meta-Llama-3.1-8B-Instruct}
export GPUS_PER_NODE=${GPUS_PER_NODE:-1}
let DEFAULT_CPU_RESOURCES_REQS=$((8 * ${GPUS_PER_NODE}))
let DEFAULT_CPU_RESOURCES_LIMITS=$((10 * ${GPUS_PER_NODE}))
let DEFAULT_MEM_RESOURCES_REQS=$((16 * ${GPUS_PER_NODE}))
let DEFAULT_MEM_RESOURCES_LIMITS=$((32 * ${GPUS_PER_NODE}))
export CPU_RESOURCES_REQS=${CPU_RESOURCES_REQS:-${DEFAULT_CPU_RESOURCES_REQS}}
export CPU_RESOURCES_LIMITS=${CPU_RESOURCES_LIMITS:-${DEFAULT_CPU_RESOURCES_LIMITS}}
export MEM_RESOURCES_REQS=${MEM_RESOURCES_REQS_:-${DEFAULT_MEM_RESOURCES_REQS}Gi}
export MEM_RESOURCES_LIMITS=${MEM_RESOURCES_LIMITS:-${DEFAULT_MEM_RESOURCES_LIMITS}Gi}
export GPU_SPEC=${GPU_SPEC:-A800_NVLINK_80GB}
export IMAGE_NAME=${IMAGE_NAME:-"10.5.1.249/bob/vllm-openai-offline:stable"}

envsubst '$JOB_NAME $ADAPTER_NAME $MODEL_NAME $GPUS_PER_NODE $GPU_SPEC $CPU_RESOURCES_REQS $MEM_RESOURCES_REQS $CPU_RESOURCES_LIMITS $MEM_RESOURCES_LIMITS' < job.tpl.yaml | kubectl replace --force -f -
