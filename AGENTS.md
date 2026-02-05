# Repository Guidelines

## Project Structure & Module Organization

- `wan_va/`: core LingBot-VA code (configs in `wan_va/configs/`, model code in `wan_va/modules/`, distributed helpers in `wan_va/distributed/`, utilities in `wan_va/utils/`).
- `script/`: launch scripts (e.g. `run_launch_va_server_sync.sh` for `torch.distributed.run`).
- `evaluation/robotwin/`: RoboTwin 2.0 evaluation client/server scripts and metrics utilities.
- `assets/`, `example/`: figures/videos and sample observations used in docs.

## 运行环境

* 电脑系统为ubuntu24.04,5090gpu 1个, cuda版本12.8
* conda环境：使用torch291cu128py311：/home/yr/anaconda3/envs/torch291cu128py311。pytorch, cuda,torchvision, torchaudio,python的版本不要改变，其它的按照本仓库的说明文档来安装，如果版本不匹配，则安装适应现在的python,pytorch这些版本来安装。

## Build, Test, and Development Commands

- `pip install -e .` / `pip install -e '.[dev]'`: install the package (and dev tools). For pinned GPU deps, see `requirements.txt` and `README.md`.
- `make format`: formats `wan_va/` using `isort` + `yapf`.
- `python -m wan_va.wan_va_server --config-name robotwin`: run the server entrypoint (GPU expected).
- `NGPU=1 CONFIG_NAME=robotwin_i2av bash script/run_launch_va_server_sync.sh`: single-GPU distributed launch.
- RoboTwin eval (requires RoboTwin env): `bash evaluation/robotwin/launch_server.sh` then `bash evaluation/robotwin/launch_client.sh results/ adjust_bottle`.

## Coding Style & Naming Conventions

- Python: 4-space indentation; keep functions small and readable.
- Naming: `snake_case.py`, `snake_case` functions/vars, `CapWords` classes, `UPPER_SNAKE_CASE` constants.
- Keep new configs consistent with keys in `wan_va/configs/__init__.py` (e.g. `robotwin_i2av`, `franka_i2av`).

## Testing Guidelines

- No dedicated unit-test suite yet. Add tests under `tests/` using `pytest` (`test_*.py`) when introducing new logic.
- At minimum, include a smoke check in PR notes (e.g. `python -m wan_va.wan_va_server --help`, or a short launch of the relevant script).

## Commit & Pull Request Guidelines

- Commits in this repo are short and imperative (e.g. `init`, `Update README.md`). Keep subjects concise; add scope when helpful (e.g. `evaluation:` / `wan_va:`).
- PRs: describe the change, list commands run, note GPU/CUDA assumptions, and include outputs/screenshots for behavior changes.

## Security & Large Files

- Do not commit model weights, datasets, or generated results under `results/`; use external storage and document download steps instead.
