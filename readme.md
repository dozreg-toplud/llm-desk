An Urbit desk to run LLM inference via Wasm.

The "weights" file had to be split into fragments because otherwise u3r_met would
crash since number of bits in the file is greater than UINT32_MAX (matters during jamming).

These files than had to be commited into a desk in a couple of rounds to avoid
overflow during jam buffer reallocation. Five files at a time was ok, all 11
were too much.

Vere64 resolves this?