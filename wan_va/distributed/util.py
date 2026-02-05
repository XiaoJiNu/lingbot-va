# Copyright 2024-2025 The Alibaba Wan Team Authors. All rights reserved.
import os

import torch
import torch.distributed as dist


def _configure_model(model, shard_fn, param_dtype, device):
    """
    TODO
    """
    model.eval().requires_grad_(False)
    if dist.is_initialized():
        dist.barrier()

    if dist.is_initialized():
        model = shard_fn(model)
    else:
        model.to(param_dtype)
        model.to(device)

    return model


def init_distributed(world_size, local_rank, rank):
    if dist.is_initialized():
        return

    if world_size <= 1 and (os.getenv("MASTER_ADDR") is None
                            or os.getenv("MASTER_PORT") is None):
        return

    backend = "nccl" if torch.cuda.is_available() else "gloo"
    if backend == "nccl":
        torch.cuda.set_device(local_rank)

    dist.init_process_group(
        backend=backend,
        init_method="env://",
        rank=rank,
        world_size=world_size,
    )
