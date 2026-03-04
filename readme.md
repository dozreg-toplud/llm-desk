An Urbit desk to run LLM inference via Wasm.

The "weights" file had to be split into fragments because otherwise u3r_met would
crash since number of bits in the file is greater than UINT32_MAX (matters during jamming).

These files than had to be commited into a desk in a couple of rounds to avoid
overflow during jam buffer reallocation. Five files at a time was ok, all 11
were too much. They were commited into a separate desk to simplify the workflow:
I typically use rsync to sync a repo and a desk, and any change to any file caused
crashes on `|commit`


TODO:
- [] Vere64 fixes all of that?
- [] why rsync + `|commit` caused all files to be commited?