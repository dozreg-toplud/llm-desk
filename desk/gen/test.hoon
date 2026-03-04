/+  wasm=wasm-lia
/*  llama-cpp-wrapper  %wasm  /llama-cpp-wrapper/wasm
::
=*  script-wasm  script:lia-sur:wasm
=*  cw           coin-wasm:wasm-sur:wasm
=*  cws          (list cw)
=*  script-form  script-raw-form:lia-sur:wasm
::
=*  acc-mold  *
=/  arr  (arrows:wasm acc-mold)
=/  imports=(map (pair cord cord) $-(cws (script-form cws acc-mold)))
  %-  malt
  =/  m  (script:lia-sur:wasm (list cw) acc-mold)
  :~
    :-  'wasi_snapshot_preview1'^'clock_time_get'
    |=  args=(pole cw)
    ^-  form:m
    ?>  ?=([[%i32 @] [%i64 @] [%i32 time-u=@] ~] args)
    =,  arr  =,  args
    ::  stub: always return 0 time
    ;<  ~  try:m  (memwrite time-u 8 0)
    (return:m i32+0 ~)
  ::
    :-  'wasi_snapshot_preview1'^'environ_sizes_get'
    |=  args=(pole cw)
    ^-  form:m
    ?>  ?=([[%i32 num-u=@] [%i32 len-u=@] ~] args)
    =,  arr  =,  args
    ;<  ~  try:m  (memwrite num-u 4 0)  ::  no environment vars
    ;<  ~  try:m  (memwrite len-u 4 0)
    (return:m i32+0 ~)
  ==
::
:-  %say  |=  [[now=@da eny=@uvJ our=@p *] *]  :-  %noun
::
::  requires %data desk to exist with /weights/hoon file that produces octs
::
=/  weights
  !<  octs
  .^(vase %ca /(scot %p our)/data/(scot %da now)/weights/hoon)
::
~>  %bout  ::  took s/1643. Sad!
%^  (run-once:wasm cord acc-mold)  [llama-cpp-wrapper *acc-mold imports]  %$
=/  m  (script-wasm cord acc-mold)
^-  form:m
=,  arr
~&  %init-module
;<  *  try:m  (call '_initialize' ~)
;<  weights-u=@  try:m  (call-1 'malloc' p.weights ~)
::
;<  *  try:m  (memwrite weights-u p.weights q.weights)
~&  %init-llama-cpp
;<  *  try:m  (call 'llama_cpp_init_from_gguf_bytes' weights-u p.weights ~)
::
=/  prompt=cord  'Q: What is the capital of the United Kingdom?\0aA: '
::  (chars + null terminator)
::
=/  len-prompt  +((met 3 prompt))
;<  str-u=@   try:m  (call-1 'malloc' len-prompt ~)
;<  *         try:m  (memwrite str-u len-prompt prompt)
~&  %infer
;<  res-u=@   try:m  (call-1 'infer_c_string' str-u 0 ~)
;<  res-w=@   try:m  (call-1 'strlen' res-u ~)
;<  o=octs    try:m  (memread res-u res-w)
(return:m `cord`q.o)