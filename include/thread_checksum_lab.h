#ifndef THREAD_CHECKSUM_LAB_H
#define THREAD_CHECKSUM_LAB_H

#include <stddef.h>
#include <stdint.h>

typedef struct {
    size_t start;
    size_t end;
    int rounds;
    uint32_t seed;
    uint64_t partial_sum;
    uint32_t partial_xor;
    uint32_t partial_max;
} WorkerArgs;

uint32_t mix32(uint32_t x);
uint32_t value_for_index(size_t index, int rounds, uint32_t seed);
void *worker_run(void *arg);
int run_single(WorkerArgs *args, uint64_t *sum, uint32_t *x, uint32_t *maxv);
int run_multi(WorkerArgs *args, int thread_count, uint64_t *sum, uint32_t *x, uint32_t *maxv);

#endif