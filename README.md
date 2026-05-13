# System Programming Lab: Threaded Checksum and Concurrency Speedup

## 1. Learning Objectives
By the end of this lab, you should be able to:
- split one CPU-heavy workload across multiple threads
- avoid race conditions by using per-thread partial results
- merge thread results safely in the main thread
- confirm that single-thread and multi-thread modes produce identical results
- measure whether multi-thread mode improves wall-clock runtime on your machine

## 2. Repository Layout
- `src/`: starter source with TODO sections
- `include/`: shared types and function declarations
- `scripts/`: visible checks and grading hooks
- `tests/`: visible test notes
- `samples/`: sample run commands

## 3. Problem Statement
Implement `src/thread_checksum_lab.c`.

Your program computes a deterministic checksum over `items` virtual records.
For each index `i`, compute a 32-bit value with `value_for_index(i, rounds, seed)` and aggregate:
- `sum` (64-bit sum of all values)
- `xor` (32-bit xor of all values)
- `max` (largest 32-bit value)

### Program Interface
```text
./bin/thread_checksum_lab <mode:single|multi> <threads> <items> <rounds> <seed>
```

Rules:
1. `single` mode must run the full range in one thread context.
2. `multi` mode must split work into `threads` chunks and create one pthread per chunk.
3. each worker computes only its own partial aggregates.
4. merge happens in the parent thread after `pthread_join`.
5. output format must match exactly.
6. do not change declarations in `include/thread_checksum_lab.h`.